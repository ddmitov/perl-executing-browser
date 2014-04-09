
// Perl Executing Browser, v. 0.1

// This program is free software;
// you can redistribute it and/or modify it under the terms of the
// GNU General Public License, as published by the Free Software Foundation;
// either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com
// Valcho Nedelchev, 2014

#ifndef PEB_H
#define PEB_H

// The domain of Perl Executing Browser:
#ifndef PEB_DOMAIN
#define PEB_DOMAIN "http://perl-executing-browser-pseudodomain/"
#endif

#include <QApplication>
#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QWebElement>
#include <QtWebKit>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QTcpSocket>
#include <QProcess>
#include <QMessageBox>
#include <QFileDialog>
#include <QMenu>
#include <QDesktopWidget>
#include <QDateTime>
#include <QSystemTrayIcon>
#include <QDebug>

#include <qglobal.h>
#if QT_VERSION >= 0x050000
// Qt5 code:
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#else
// Qt4 code:
#include <QPrintDialog>
#include <QPrinter>
#endif

class Settings : public QSettings
{
    Q_OBJECT

public:

    Settings();

    QString rootDirName;

    QString settingsFileName;
    QString settingsDirName;
    QDir settingsDir;
    QString mongooseSettingsFileName;

    QString perlLib;
    QString debuggerInterpreter;

    QString autostartLocalWebserver;
    QString pingLocalWebserver;
    QString pingRemoteWebserver;
    QString userAgent;

    QString listeningPort;
    QString quitToken;

    QString startPage;
    QString windowSize;
    QString framelessWindow;
    QString stayOnTop;
    QString browserTitle;
    QString contextMenu;

    QString iconPathName;
    QPixmap icon;

    QString logging;
    QString logFile;

};

class Watchdog : public QObject
{

    Q_OBJECT

public slots:

    void pingSlot()
    {
        QTcpSocket localWebServerPing;
        QTcpSocket webConnectivityPing;

        if (settings.pingLocalWebserver == "yes") {
            localWebServerPing.connectToHost ("127.0.0.1", settings.listeningPort.toInt());
        }

        if (settings.pingRemoteWebserver == "yes") {
            webConnectivityPing.connectToHost ("www.google.com", 80);
        }

        if (settings.pingLocalWebserver == "yes") {
            if (localWebServerPing.waitForConnected (1000) ) {
                qDebug() << "Local web server is running.";
            } else {
                if (settings.autostartLocalWebserver == "yes") {
                    qDebug() << "Local web server is not running. Will try to restart it.";
                    QProcess server;
                    server.startDetached (QString (settings.rootDirName+
                                                   QDir::separator()+"mongoose"));
                } else {
                    qDebug() << "Local web server is not running.";
                }
            }
            qDebug() << "===============";
        }

        if (settings.pingRemoteWebserver == "yes") {
            if (webConnectivityPing.waitForConnected (1000 ))
            {
                qDebug() << "Internet connectivity is available.";
                QList<QNetworkInterface> list = QNetworkInterface::allInterfaces();
                foreach (QNetworkInterface iface, list) {
                    QList<QNetworkAddressEntry> interfaceEntries = iface.addressEntries();
                    foreach (QNetworkAddressEntry entry, interfaceEntries) {
                        if (entry.ip() == webConnectivityPing.localAddress()) {
                            qDebug() << "Local interface:" << iface.name();
                            qDebug() << "Local MAC:" << iface.hardwareAddress();
                            qDebug() << "Local IP address:" << entry.ip().toString();
                            qDebug() << "Local netmask:" << entry.netmask().toString();
                            qDebug() << "Local broadcast address:" << entry.broadcast().toString();
                            qDebug() << "Local prefix length:" << entry.prefixLength();
                            qDebug() << "Local port:" << webConnectivityPing.localPort();
                            qDebug() << "Remote IP address:"
                                     << webConnectivityPing.peerAddress().toString();
                            qDebug() << "Remote port:"
                                     << webConnectivityPing.peerPort();
                            qDebug() << "Remote domain name:"
                                     << webConnectivityPing.peerName();
                        }
                    }
                }

            } else {
                qDebug() << "Internet connectivity is not available.";
            }
            qDebug() << "===============";
        }
    }

    void aboutToQuitSlot()
    {
        trayIcon->hide();
        QString dateTimeString = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");
        qDebug() << "Perl Executing Browser v.0.1 terminated normally on:" << dateTimeString;
        qDebug() << "===============";
    }

public:

    Watchdog();

    QAction *quitAction;
    QAction *aboutAction;
    QAction *aboutQtAction;

private:

    Settings settings;
    QSystemTrayIcon *trayIcon;
    QMenu *trayIconMenu;

};

class ModifiedNetworkAccessManager : public QNetworkAccessManager
{

    Q_OBJECT

protected:

    virtual QNetworkReply *createRequest (Operation operation,
                                          const QNetworkRequest &request,
                                          QIODevice *outgoingData = 0)
    {

        // Get output from local script, including:
        // 1.) script used as a start page,
        // 2.) script started in a new window,
        // 3.) script, which was fed with data from local form using CGI GET method,
        // 4.) script started by clicking a hyperlink.
        Settings settings;
        if (operation == GetOperation and
                (QUrl (PEB_DOMAIN))
                .isParentOf(request.url()) and
                (!request.url().path().contains ("longrun")) and
                (!request.url().toString().contains ("debugger"))) {

            QString query = request.url()
                    .toString (QUrl::RemoveScheme
                               | QUrl::RemoveAuthority
                               | QUrl::RemovePath)
                    .replace ("?", "");
            filepath = request.url()
                    .toString (QUrl::RemoveScheme
                               | QUrl::RemoveAuthority
                               | QUrl::RemoveQuery);

            qDebug() << "Script path:" << QDir::toNativeSeparators
                        (settings.rootDirName+filepath);

            QFile file (QDir::toNativeSeparators
                        (settings.rootDirName+filepath));
            if (!file.exists()) {
                missingFileMessageSlot();
                QNetworkRequest emptyRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         emptyRequest);
            }

            if (query.length() > 0)
                qDebug() << "Query string:" << query;

            extension = filepath.section (".", 1, 1);
            qDebug() << "Extension:" << extension;
            defineInterpreter ();

            if (extension == "pl" or extension == "php" or extension == "py")
            {
                qDebug() << "Interpreter:" << interpreter;

                QProcess handler;

                if (query.length() > 0)
                {
                    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
                    env.insert ("REQUEST_METHOD", "GET");
                    env.insert ("QUERY_STRING", query);
                    handler.setProcessEnvironment (env);
                    //qDebug() << "Process environment:" << handler.processEnvironment().toStringList();
                }

                QFileInfo scriptAbsoluteFilePath (settings.rootDirName+
                                                  QDir::separator()+
                                                  filepath);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                handler.setWorkingDirectory (scriptDirectory);
                qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);



                qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
                qDebug() << "===============";
                handler.start (interpreter, QStringList() <<
                               QDir::toNativeSeparators
                               (settings.rootDirName+
                                QDir::separator()+filepath));

                QString output;
                if (handler.waitForFinished()) {
                    output = handler.readAll();
                    handler.close();
                }

                QString outputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "output.htm");
                QFile outputFilePathFile (outputFilePath);
                if (outputFilePathFile.exists()) {
                    outputFilePathFile.remove();
                }

                QRegExp regExpOne ("Content-type: text/html.{1,25}\n");
                regExpOne.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExpOne, "");
                QRegExp regExpTwo ("X-Powered-By: PHP.{1,20}\n");
                regExpTwo.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExpTwo, "");

                if (outputFilePathFile.open (QIODevice::ReadWrite)) {
                    QTextStream stream (&outputFilePathFile);
                    stream << output << endl;
                }

                qputenv ("FILE_TO_OPEN", "");
                qputenv ("NEW_FILE", "");
                qputenv ("FOLDER_TO_OPEN", "");

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (QDir::toNativeSeparators
                          (QDir::tempPath()+
                           QDir::separator()+
                           "output.htm" )));

                QWebSettings::clearMemoryCaches();
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest (networkRequest));
            }
        }

        // Get data from local form using CGI POST method and
        // execute associated local script:
        if (operation == PostOperation and
                (QUrl (PEB_DOMAIN))
                .isParentOf (request.url())) {
            QString postData;
            QByteArray outgoingByteArray;
            if (outgoingData) {
                outgoingByteArray = outgoingData->readAll();
                QString postDataRaw (outgoingByteArray);
                postData = postDataRaw;
                qDebug() << "POST data:" << postData;
            }

            qDebug() << "Form submitted to:" << request.url().toString();
            filepath = request.url()
                    .toString (QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery);

            qDebug() << "Script path:" << QDir::toNativeSeparators
                        (settings.rootDirName+filepath);

            QFile file (QDir::toNativeSeparators
                        (settings.rootDirName+filepath));
            if (!file.exists()) {
                missingFileMessageSlot();
                QNetworkRequest emptyRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         emptyRequest);
            }

            extension = filepath.section (".", 1, 1);
            qDebug() << "Extension:" << extension;
            defineInterpreter();
            if (extension == "pl" or extension == "php" or extension == "py") {
                qDebug() << "Interpreter:" << interpreter;
                QProcess handler;
                QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
                if (postData.size() > 0) {
                    env.insert ("REQUEST_METHOD", "POST");
                    QString postDataSize = QString::number (postData.size());
                    env.insert ("CONTENT_LENGTH", postDataSize);
                }
                handler.setProcessEnvironment (env);
                //qDebug() << "Process environment:" << handler.processEnvironment().toStringList();

                QFileInfo scriptAbsoluteFilePath (settings.rootDirName+
                                                  QDir::separator()+
                                                  filepath);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                handler.setWorkingDirectory (scriptDirectory);
                qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

                qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
                qDebug() << "===============";
                handler.start (interpreter, QStringList() <<
                               QDir::toNativeSeparators
                               (settings.rootDirName+
                                QDir::separator()+filepath));
                if (postData.size() > 0) {
                    handler.write (outgoingByteArray);
                    handler.closeWriteChannel();
                }

                QString output;
                if (handler.waitForFinished()) {
                    output = handler.readAll();
                    handler.close();
                }

                QString outputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "output.htm");
                QFile outputFilePathFile ( outputFilePath );
                if (outputFilePathFile.exists()) {
                    outputFilePathFile.remove();
                }

                QRegExp regExpOne ("Content-type: text/html.{1,25}\n");
                regExpOne.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExpOne, "");
                QRegExp regExpTwo ("X-Powered-By: PHP.{1,20}\n");
                regExpTwo.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExpTwo, "");

                if (outputFilePathFile.open (QIODevice::ReadWrite))
                {
                    QTextStream stream (&outputFilePathFile);
                    stream << output << endl;
                }

                qputenv ("FILE_TO_OPEN", "");
                qputenv ("NEW_FILE", "");
                qputenv ("FOLDER_TO_OPEN", "");

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (QDir::toNativeSeparators
                          (QDir::tempPath()+
                           QDir::separator()+
                           "output.htm")));

                QWebSettings::clearMemoryCaches();
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest (networkRequest));
            }
        }

        return QNetworkAccessManager::createRequest (operation, request);
    }

public slots:

    void missingFileMessageSlot()
    {
        Settings settings;
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Missing file");
        msgBox.setText (QDir::toNativeSeparators
                        (settings.rootDirName+filepath)+
                        " is missing.<br>Please restore the missing file.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
    }

    void defineInterpreter()
    {
        if (extension == "pl") {
            QByteArray perlInterpreterByteArray = qgetenv ("PERL_INTERPRETER");
            QString perlInterpreter (perlInterpreterByteArray);
            interpreter = perlInterpreter;
        }
        if (extension == "py") {
            QByteArray pythonInterpreterByteArray = qgetenv ("PYTHON_INTERPRETER");
            QString pythonInterpreter (pythonInterpreterByteArray);
            interpreter = pythonInterpreter;
        }
        if (extension == "php") {
            QByteArray phpInterpreterByteArray = qgetenv ("PHP_INTERPRETER");
            QString phpInterpreter (phpInterpreterByteArray);
            interpreter = phpInterpreter;
        }
    }

private:

    QString filepath;
    QString extension;
    QString interpreter;

};

class Page : public QWebPage
{
    Q_OBJECT

signals:

    void quitFromURLSignal();

    void closeWindowSignal();

public slots:

    void missingFileMessageSlot()
    {
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Missing file");
        msgBox.setText (QDir::toNativeSeparators
                        (settings.rootDirName+filepath)+
                        " is missing.<br>Please restore the missing file.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        qDebug() << QDir::toNativeSeparators
                    (settings.rootDirName+filepath) <<
                    "is missing.";
        qDebug() << "Please restore the missing file.";
        qDebug() << "===============";
    }

    void checkFileExistenceSlot()
    {
        QFile file (QDir::toNativeSeparators
                    (settings.rootDirName+filepath));
        if (!file.exists()) {
            missingFileMessageSlot();
        }
    }

    void defineInterpreter()
    {
        if (extension == "pl") {
            QByteArray perlInterpreterByteArray = qgetenv ("PERL_INTERPRETER");
            QString perlInterpreter (perlInterpreterByteArray);
            interpreter = perlInterpreter;
        }
        if (extension == "py") {
            QByteArray pythonInterpreterByteArray = qgetenv ("PYTHON_INTERPRETER");
            QString pythonInterpreter (pythonInterpreterByteArray);
            interpreter = pythonInterpreter;
        }
        if (extension == "php") {
            QByteArray phpInterpreterByteArray = qgetenv ("PHP_INTERPRETER");
            QString phpInterpreter (phpInterpreterByteArray);
            interpreter = phpInterpreter;
        }
    }

    void selectInterpreterSlot()
    {
        QFileDialog selectInterpreterDialog;
        selectInterpreterDialog.setFileMode (QFileDialog::AnyFile);
        selectInterpreterDialog.setViewMode (QFileDialog::Detail);
        selectInterpreterDialog.setOption (QFileDialog::DontUseNativeDialog);
        selectInterpreterDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        selectInterpreterDialog.setWindowIcon (settings.icon);
        interpreter = selectInterpreterDialog.getOpenFileName
                (0, "Select Interpreter", QDir::currentPath(), "All files (*)");
        qDebug() << "Selected interpreter:" << interpreter;
        qDebug() << "===============";
        selectInterpreterDialog.close();
        selectInterpreterDialog.deleteLater();

        QFileDialog selectPerlLibDialog;
        selectPerlLibDialog.setFileMode (QFileDialog::AnyFile);
        selectPerlLibDialog.setViewMode (QFileDialog::Detail);
        selectPerlLibDialog.setOption (QFileDialog::DontUseNativeDialog);
        selectPerlLibDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        selectPerlLibDialog.setWindowIcon (settings.icon);
        QString perlLibFolderNameString = selectPerlLibDialog.getExistingDirectory
                (0, "Select PERLLIB", QDir::currentPath());
        QByteArray perlLibFolderName;
        perlLibFolderName.append (perlLibFolderNameString);
        qputenv ("PERLLIB", perlLibFolderName);
        qDebug() << "Selected PERLLIB:" << perlLibFolderName;
        qDebug() << "===============";
        selectPerlLibDialog.close();
        selectPerlLibDialog.deleteLater();
    }

    void displayLongRunningScriptOutputSlot()
    {
        QString output = longRunningScriptHandler.readAllStandardOutput();
        QString filepathForConversion;
        filepathForConversion = lastRequest.url().path();

        longRunningScriptOutputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "lroutput.htm");

        QFile longRunningScriptOutputFile (longRunningScriptOutputFilePath);
        if (longRunningScriptOutputFile.exists()) {
            longRunningScriptOutputFile.remove();
        }

        if (longRunningScriptOutputFile.open (QIODevice::ReadWrite)) {
            QTextStream stream (&longRunningScriptOutputFile);
            stream << output << endl;
        }
        qDebug() << "Output from long-running script received.";
        qDebug() << "Long-running script output file:" << longRunningScriptOutputFilePath;
        qDebug() << "===============";
        if (longRunningScriptOutputInNewWindow == false) {
            Page::currentFrame()->setUrl
                    (QUrl::fromLocalFile (longRunningScriptOutputFilePath));
        }
        if (longRunningScriptOutputInNewWindow == true) {
            newLongRunWindow->setUrl (QUrl::fromLocalFile (longRunningScriptOutputFilePath));
            newLongRunWindow->show();
        }
    }

    void longRunningScriptFinishedSlot()
    {
        longRunningScriptHandler.close();
        QFile longRunningScriptOutputFile (longRunningScriptOutputFilePath);
        longRunningScriptOutputFile.remove();
        qDebug() << "Long-running script finished.";
        qDebug() << "===============";
    }

    void displayLongRunningScriptErrorSlot()
    {
        QString error = longRunningScriptHandler.readAllStandardError();
        qDebug() << "Long-running script error:" << error;
        qDebug() << "===============";
    }

    // Display information about user-selected Perl scripts using the built-in Perl debugger.
    // Partial implementation of an idea proposed by Valcho Nedelchev.
    void displayDebuggerOutputSlot()
    {
        QString debuggerOutput = debuggerHandler.readAllStandardOutput();

        QRegExp regExpOne ("\\[\\d{1,2}\\w{1,3}|DB|\\<\\d{1,3}\\>|\e|[\x80-\x9f]|\x08|\r");
        regExpOne.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExpOne, "");

        QRegExp regExpTwo ("Editor support available.");
        regExpTwo.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExpTwo, "");

        QRegExp regExpThree ("Enter h .{40,55}\n");
        regExpThree.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExpThree, "");

        accumulatedOutput.append (debuggerOutput);

        QRegExp regExpFour ("\n\\s*\n");
        regExpFour.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExpFour, "\n\n");

        QRegExp regExpFive ("\n\\s{4,}");
        regExpFive.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExpFive, "");

        QRegExp regExpSix ("\n{3,100}");
        regExpSix.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExpSix, "\n\n");

        debuggerOutputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "deboutput.txt");

        QFile debuggerOutputFile (debuggerOutputFilePath);
        if (debuggerOutputFile.open (QIODevice::ReadWrite)) {
            QTextStream debuggerOutputStream (&debuggerOutputFile);
            debuggerOutputStream << accumulatedOutput << endl;
        }
        qDebug() << "Output from debugger received.";
        qDebug() << "Debugger output file:" << debuggerOutputFilePath;
        qDebug() << "===============";

        newDebuggerWindow->setUrl (QUrl::fromLocalFile (debuggerOutputFilePath));
        newDebuggerWindow->show();
        debuggerOutputFile.remove();
    }

public:

    Page();

protected:

    bool acceptNavigationRequest (QWebFrame *frame,
                                  const QNetworkRequest &request,
                                  QWebPage::NavigationType type);

private:

    QString userAgentForUrl (const QUrl &url) const
    {
        Q_UNUSED (url);
        Settings settings;
        return settings.userAgent;
//        return "Mozilla/5.0 AppleWebKit/534.34 (KHTML, like Gecko) "
//                "PerlExecutingBrowser/0.1 Safari/534.34";
    }

    Settings settings;

    QString filepath;
    QString extension;
    QString interpreter;

    QProcess longRunningScriptHandler;
    QNetworkRequest lastRequest;
    QString longRunningScriptOutputFilePath;
    bool longRunningScriptOutputInNewWindow;
    QWebView *newLongRunWindow;

    QProcess debuggerHandler;
    QString debuggerCommandHumanReadable;
    QString accumulatedOutput;
    QString debuggerOutputFilePath;
    QWebView *newDebuggerWindow;

    QWebView *newWindow;

};

class TopLevel : public QWebView
{
    Q_OBJECT

public slots:

    void loadStartPageSlot()
    {
        if (settings.startPage.contains (".htm")) {
            setUrl (QUrl::fromLocalFile
                    (QDir::toNativeSeparators
                     (settings.rootDirName+
                      QDir::separator()+settings.startPage)));
        } else {
            setUrl (QUrl (QString (PEB_DOMAIN +
                                   settings.startPage)));
        }
    }

    void pageLoadedDynamicTitleSlot(bool ok)
    {
        if (ok)
        {
            setWindowTitle (TopLevel::title());
            QFile::remove
                    (QDir::toNativeSeparators
                     (QDir::tempPath()+QDir::separator()+"output.htm"));
        }
    }

    void pageLoadedStaticTitleSlot(bool ok)
    {
        if (ok)
        {
            QFile::remove
                    (QDir::toNativeSeparators
                     (QDir::tempPath()+QDir::separator()+"output.htm"));
        }
    }

    void printPageSlot()
    {
        QPrinter printer;
        printer.setOrientation (QPrinter::Portrait);
        printer.setPageSize (QPrinter::A4);
        printer.setPageMargins (10, 10, 10, 10, QPrinter::Millimeter);
        printer.setResolution (QPrinter::HighResolution);
        printer.setColorMode (QPrinter::Color);
        printer.setPrintRange (QPrinter::AllPages);
        printer.setNumCopies (1);
        //        printer.setOutputFormat (QPrinter::PdfFormat);
        //        printer.setOutputFileName ("output.pdf");
        QPrintDialog *dialog = new QPrintDialog ( &printer);
        dialog->setWindowFlags (Qt::WindowStaysOnTopHint);
        QSize dialogSize = dialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        dialog->move (QPoint (screenRect.width() / 2 - dialogSize.width() / 2,
                                screenRect.height() / 2 - dialogSize.height() / 2));
        if (dialog->exec() == QDialog::Accepted) {
            TopLevel::print (&printer);
        }
        dialog->close();
        dialog->deleteLater();
    }

    void editSlot()
    {
        QString fileToEdit = QDir::toNativeSeparators
                (settings.rootDirName+
                 QDir::separator()+qWebHitTestURL.toString
                 (QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery)
                 .replace ("?", ""));
        qDebug() << "File to edit:" << fileToEdit;
        qDebug() << "===============";
        QProcess externalProcess;
        externalProcess.startDetached ("padre", QStringList() << fileToEdit);
    }

    void openInNewWindowSlot()
    {
        newWindow = new TopLevel;
        newWindow->setWindowIcon (settings.icon);
        qDebug() << "Link to open in a new window:" << qWebHitTestURL.path();
        qDebug() << "===============";
        if (qWebHitTestURL.path().contains (".htm")) {
            QString fileToOpen = QDir::toNativeSeparators
                    (settings.rootDirName+
                     QDir::separator()+qWebHitTestURL.toString
                     (QUrl::RemoveScheme | QUrl::RemoveAuthority));
            newWindow->setUrl (QUrl::fromLocalFile (fileToOpen));
        } else {
            newWindow->setUrl (qWebHitTestURL);
        }
        newWindow->show();
    }

    void contextMenuEvent (QContextMenuEvent *event)
    {
        QWebHitTestResult qWebHitTestResult =
                mainPage->mainFrame()->hitTestContent (event->pos());
        QMenu *menu = mainPage->createStandardContextMenu();
        if (!qWebHitTestResult.linkUrl().isEmpty()) {
            qWebHitTestURL = qWebHitTestResult.linkUrl();
            if (QUrl (PEB_DOMAIN)
                    .isParentOf (qWebHitTestURL)) {
                menu->addSeparator ();
                QAction *editAct = menu->addAction (tr ("&Edit"));
                QObject::connect (editAct, SIGNAL (triggered()),
                                  this, SLOT (editSlot()));
                QAction *openInNewWindowAct = menu->addAction (tr ("&Open in new window"));
                QObject::connect (openInNewWindowAct, SIGNAL (triggered()),
                                  this, SLOT (openInNewWindowSlot()));
            }
        }
        menu->addSeparator();
        if (settings.windowSize == "maximized" or settings.windowSize == "fullscreen") {
            if (settings.framelessWindow == "no") {
                QAction *maximizeAct = menu->addAction (tr ("&Maximize"));
                QObject::connect (maximizeAct, SIGNAL (triggered()),
                                  this, SLOT (maximizeSlot()));
            }
            QAction *toggleFullScreenAct = menu->addAction (tr ("Toggle &Fullscreen"));
            QObject::connect (toggleFullScreenAct, SIGNAL (triggered()),
                              this, SLOT (toggleFullScreenSlot()));
        }
        if (settings.framelessWindow == "no") {
            QAction *minimizeAct = menu->addAction (tr ("Mi&nimize"));
            QObject::connect (minimizeAct, SIGNAL (triggered()),
                              this, SLOT (minimizeSlot()));
        }
        if (!TopLevel::url().toString().contains ("longrun")) {
            QAction *homeAct = menu->addAction (tr ("&Home"));
            QObject::connect (homeAct, SIGNAL (triggered()),
                              this, SLOT (loadStartPageSlot()));
        }
        QAction *printAct = menu->addAction (tr ("&Print"));
        QObject::connect (printAct, SIGNAL (triggered()),
                          this, SLOT (printPageSlot()));
        QAction *closeWindowAct = menu->addAction (tr ("&Close window"));
        QObject::connect (closeWindowAct, SIGNAL (triggered()),
                          this, SLOT (close()));
        if (!TopLevel::url().toString().contains ("longrun")) {
            QAction *quitAct = menu->addAction (tr ("&Quit"));
            QObject::connect ( quitAct, SIGNAL (triggered()),
                               this, SLOT (quitApplicationSlot()));
        }
        menu->addSeparator();
        QAction *aboutAction = menu->addAction (tr ("&About"));
        QObject::connect (aboutAction, SIGNAL (triggered()),
                          this, SLOT (aboutSlot()));
        QAction *aboutQtAction = menu->addAction (tr ("About Q&t"));
        QObject::connect ( aboutQtAction, SIGNAL (triggered()),
                           qApp, SLOT (aboutQt()));
        menu->exec (mapToGlobal (event->pos()));
    }

    void maximizeSlot()
    {
        raise();
        showMaximized();
    }

    void minimizeSlot()
    {
        showMinimized();
    }

    void toggleFullScreenSlot()
    {
        if (isFullScreen())
        {
            showMaximized();
        } else {
            showFullScreen();
        }
    }

    void aboutSlot()
    {
        QString qtVersion = QT_VERSION_STR;
        QString qtWebKitVersion = QTWEBKIT_VERSION_STR;
        QMessageBox msgBox;
        msgBox.setWindowTitle ("About");
        msgBox.setIconPixmap (settings.icon);
        msgBox.setText ("Perl Executing Browser, version 0.1<br>"
                        "code name Camel Calf,<br>"
                        "Qt WebKit version: "+qtWebKitVersion+"<br>"
                        "Qt version: "+qtVersion+"<br>"
                        "<a href='https://github.com/ddmitov/perl-executing-browser'>"
                        "https://github.com/ddmitov/perl-executing-browser</a><br>");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
    }

    void quitApplicationSlot()
    {
        QFile::remove
                (QDir::toNativeSeparators
                 (QDir::tempPath()+QDir::separator()+"output.htm"));
        setUrl (QUrl (QString ("http://localhost:"+settings.listeningPort+
                               "/quit__"+settings.quitToken)));
        QApplication::exit();
    }

    void sslErrors (QNetworkReply* reply, const QList<QSslError> &errors)
    {
        foreach (QSslError error, errors) {
            qDebug() << "SSL error: " << error;
        }
        reply->ignoreSslErrors();
    }

public:

    TopLevel();

private:

    Page *mainPage;

    Settings settings;

    QUrl qWebHitTestURL;
    QString filepath;
    QWebView *newWindow;

};

#endif // PEB_H
