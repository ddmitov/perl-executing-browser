/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014
*/

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

#include <QShortcut>

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

    QString startPageSetting;
    QString startPage;

    QString windowSize;
    int fixedWidth;
    int fixedHeight;
    QString framelessWindow;
    QString stayOnTop;
    QString browserTitle;
    QString contextMenu;

    QString iconPathName;
    QPixmap icon;

    QString defaultTheme;
    QString defaultThemeDirectory;
    QString allThemesDirectory;

    QString logging;
    QString logMode;
    QString logDirName;
    QString logDirFullPath;
    QString logPrefix;

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

        Settings settings;

        // Get output from local script, including:
        // 1.) script used as a start page,
        // 2.) script started in a new window,
        // 3.) script, which was fed with data from local form using CGI GET method,
        // 4.) script started by clicking a hyperlink.
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

                QRegExp regExp01 ("Content-type: text/html.{1,25}\n");
                regExp01.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExp01, "");
                QRegExp regExp02 ("X-Powered-By: PHP.{1,20}\n");
                regExp02.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExp02, "");

                QString css;
                css.append ("<style media=\"screen\" type=\"text/css\">");
                QFile cssFile (
                            QDir::toNativeSeparators (
                                settings.defaultThemeDirectory+QDir::separator()+"current.css"));
                cssFile.open(QFile::ReadOnly);
                QString cssFileContents = QLatin1String (cssFile.readAll());
                css.append (cssFileContents);
                css.append ("</style>");
                css.append ("</head>");
                output.replace ("</head>", css);

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

                QRegExp regExp01 ("Content-type: text/html.{1,25}\n");
                regExp01.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExp01, "");
                QRegExp regExp02 ("X-Powered-By: PHP.{1,20}\n");
                regExp02.setCaseSensitivity (Qt::CaseInsensitive);
                output.replace (regExp02, "");

                QString css;
                css.append ("<style media=\"screen\" type=\"text/css\">");
                QFile cssFile (settings.rootDirName+QDir::separator()+"html/current.css");
                cssFile.open(QFile::ReadOnly);
                QString cssFileContents = QLatin1String (cssFile.readAll());
                css.append (cssFileContents);
                css.append ("</style>");
                css.append ("</head>");
                output.replace ("</head>", css);

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
        msgBox.setWindowTitle (tr ("Missing file"));
        msgBox.setText (QDir::toNativeSeparators
                        (settings.rootDirName+filepath)+
                        tr (" is missing.<br>Please restore the missing file."));
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

    void reloadSignal();

    void closeWindowSignal();

    void quitFromURLSignal();

public slots:

    void selectThemeSlot()
    {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString newTheme = dialog.getOpenFileName
                (0, tr ("Select Browser Theme"),
                 settings.allThemesDirectory,
                 tr ("Browser theme (*.theme)"));
        dialog.close();
        dialog.deleteLater();
        if (newTheme.length() > 0) {
            if (QFile::exists (
                        QDir::toNativeSeparators (
                            settings.defaultThemeDirectory+
                            QDir::separator()+"current.css"))) {
                QFile::remove (
                            QDir::toNativeSeparators (
                                settings.defaultThemeDirectory+
                                QDir::separator()+"current.css"));
            }
            QFile::copy (newTheme,
                         QDir::toNativeSeparators (
                             settings.defaultThemeDirectory+
                             QDir::separator()+"current.css"));
            emit reloadSignal();
            qDebug() << "===============";
            qDebug() << "Selected new theme:" << newTheme;
            qDebug() << "===============";
        } else {
            qDebug() << "===============";
            qDebug() << "No new theme selected.";
            qDebug() << "===============";
        }
    }

    void missingFileMessageSlot()
    {
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (tr ("Missing file"));
        msgBox.setText (QDir::toNativeSeparators
                        (settings.rootDirName+filepath)+
                        tr (" is missing.<br>Please restore the missing file."));
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

    void selectDebuggingPerlInterpreterSlot()
    {
        QFileDialog selectInterpreterDialog;
        selectInterpreterDialog.setFileMode (QFileDialog::AnyFile);
        selectInterpreterDialog.setViewMode (QFileDialog::Detail);
        selectInterpreterDialog.setOption (QFileDialog::DontUseNativeDialog);
        selectInterpreterDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        selectInterpreterDialog.setWindowIcon (settings.icon);
        interpreter = selectInterpreterDialog.getOpenFileName
                (0, tr ("Select Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
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
                (0, tr ("Select PERLLIB"), QDir::currentPath());
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

        QString css;
        css.append ("<style media=\"screen\" type=\"text/css\">");
        QFile cssFile (settings.rootDirName+QDir::separator()+"html/current.css");
        cssFile.open(QFile::ReadOnly);
        QString cssFileContents = QLatin1String (cssFile.readAll());
        css.append (cssFileContents);
        css.append ("</style>");
        css.append ("</head>");
        output.replace ("</head>", css);

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

        QRegExp regExp01 ("\\[\\d{1,2}\\w{1,3}|DB|\\<\\d{1,3}\\>|\e|[\x80-\x9f]|\x08|\r");
        regExp01.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExp01, "");

        QRegExp regExp02 ("Editor support \\w{1,20}.");
        regExp02.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExp02, "");

        QRegExp regExp03 ("Enter h .{40,80}\n");
        regExp03.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (regExp03, "");

        accumulatedOutput.append (debuggerOutput);

        QRegExp regExp04 ("\n\\s*\n");
        regExp04.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExp04, "\n\n");

        QRegExp regExp05 ("\n\\s{4,}");
        regExp05.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExp05, "\n");

        if (accumulatedOutput.contains ("Show module versions")) {
            QRegExp regExp06 ("\n\\s{3,}");
            regExp06.setCaseSensitivity (Qt::CaseSensitive);
            accumulatedOutput.replace (regExp06, "\n");
        }

        QRegExp regExp07 ("routines from .{10,30}\n");
        regExp07.setCaseSensitivity (Qt::CaseSensitive);
        int pos = regExp07.indexIn (accumulatedOutput);
        Q_UNUSED (pos);
        QString debuggerVersion = regExp07.capturedTexts().first();
        accumulatedOutput.replace (regExp07, debuggerVersion+"\n");

        QRegExp regExp08 ("\n{3,100}");
        regExp08.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExp08, "\n\n");

        QRegExp regExp09 ("  ");
        regExp09.setCaseSensitivity (Qt::CaseSensitive);
        accumulatedOutput.replace (regExp09, " ");

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

signals:

    void selectThemeSignal();

public slots:

    void loadStartPageSlot()
    {
        if (settings.startPageSetting.contains (".htm")) {
            setUrl (QUrl::fromLocalFile
                    (QDir::toNativeSeparators
                     (settings.startPage)));
        } else {
            setUrl (QUrl (QString (PEB_DOMAIN+
                                   settings.startPageSetting)));
        }
    }

    void pageLoadedDynamicTitleSlot(bool ok)
    {
        if (ok) {
            setWindowTitle (TopLevel::title());
            QFile::remove
                    (QDir::toNativeSeparators
                     (QDir::tempPath()+QDir::separator()+"output.htm"));
        }
    }

    void pageLoadedStaticTitleSlot(bool ok)
    {
        if (ok) {
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

    void reloadSlot()
    {
        QUrl currentUrl = mainPage->mainFrame()->url();
        setUrl (currentUrl);
        raise();
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
        newWindow = new TopLevel (QString ("mainWindow"));
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

        if (!qWebHitTestResult.isContentEditable()) {

            menu->addSeparator();

            if (settings.windowSize == "maximized" or settings.windowSize == "fullscreen") {
                if (settings.framelessWindow == "no" and
                        (!TopLevel::isMaximized())) {
                    QAction *maximizeAct = menu->addAction (tr ("&Maximize"));
                    QObject::connect (maximizeAct, SIGNAL (triggered()),
                                      this, SLOT (maximizeSlot()));
                }
                QAction *toggleFullScreenAct = menu->addAction (tr ("Toggle &fullscreen"));
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

            if ((!TopLevel::url().toString().contains ("longrun")) and
                    (!TopLevel::url().toString().contains ("deboutput"))) {
                QAction *reloadAct = menu->addAction (tr ("&Reload"));
                QObject::connect (reloadAct, SIGNAL (triggered()),
                                  this, SLOT (reloadSlot()));
            }

            QAction *printAct = menu->addAction (tr ("&Print"));
            QObject::connect (printAct, SIGNAL (triggered()),
                              this, SLOT (printPageSlot()));

            QAction *selectThemeAct = menu->addAction (tr ("&Select theme"));
            QObject::connect (selectThemeAct, SIGNAL (triggered()),
                              this, SLOT (selectThemeFromContextMenuSlot()));

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

        }

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

    void selectThemeFromContextMenuSlot()
    {
        emit selectThemeSignal();
    }

    void aboutSlot()
    {
        QString qtVersion = QT_VERSION_STR;
        QString qtWebKitVersion = QTWEBKIT_VERSION_STR;

//        QMessageBox msgBox;
//        msgBox.setWindowTitle ("About");
//        msgBox.setIconPixmap (settings.icon);
//        msgBox.setText ("Perl Executing Browser, version 0.1<br>"
//                        "code name Camel Calf,<br>"
//                        "Qt WebKit version: "+qtWebKitVersion+"<br>"
//                        "Qt version: "+qtVersion+"<br>"
//                        "<a href='https://github.com/ddmitov/perl-executing-browser'>"
//                        "https://github.com/ddmitov/perl-executing-browser</a><br>");
//        msgBox.setDefaultButton (QMessageBox::Ok);
//        msgBox.exec();

        // Initialize a new message box
        aboutDialog = new TopLevel (QString ("messageBox"));

        // Calculate message box dimensions,
        // center message box on screen:
        QRect screenRect = QDesktopWidget().screen()->rect();
        float onePercentOfScreenWidth = screenRect.width()/100;
        float onePercentOfScreenHeigth = screenRect.height()/100;
        float messageBoxWidth = onePercentOfScreenWidth * 54;
        float messageBoxHeigth = onePercentOfScreenHeigth * 58;
        aboutDialog->setFixedSize (messageBoxWidth, messageBoxHeigth);
        aboutDialog->move (QPoint(screenRect.width()/2 - aboutDialog->width()/2,
                              screenRect.height()/2 - aboutDialog->height()/2));

        // Output file name:
        QString outputFilePath = QDir::toNativeSeparators
                (QDir::tempPath()+
                 QDir::separator()+
                 "output.htm");
        QFile outputFile ( outputFilePath );
        if (outputFile.exists()) {
            outputFile.remove();
        }

        // Initialize output variable:
        QString output;

        // Read template file, add browser vaiables and
        // append all of this to the output variable:
        QFile aboutFileTemplateFile (
                    QDir::toNativeSeparators (
                        QApplication::applicationDirPath()+
                        QDir::separator()+"help/about.htm"));
        aboutFileTemplateFile.open(QFile::ReadOnly);
        QString aboutTemplateContents = QLatin1String (aboutFileTemplateFile.readAll());
        aboutTemplateContents.replace ("[% browser root %]", settings.rootDirName);
        aboutTemplateContents.replace ("[% Qt Webkit version %]", qtVersion);
        aboutTemplateContents.replace ("[% Qt version %]", qtWebKitVersion);
        output.append (aboutTemplateContents);

        // Read CSS theme file and inject its content into the output variable:
        QString css;
        css.append ("<style media=\"screen\" type=\"text/css\">");
        QFile cssFile (
                    QDir::toNativeSeparators (
                        settings.defaultThemeDirectory+QDir::separator()+"current.css"));
        cssFile.open(QFile::ReadOnly);
        QString cssFileContents = QLatin1String (cssFile.readAll());
        css.append (cssFileContents);
        css.append ("</style>");
        css.append ("</head>");
        output.replace ("</head>", css);

        // Save the output variable as an output file:
        if (outputFile.open (QIODevice::ReadWrite)) {
            QTextStream stream (&outputFile);
            stream << output << endl;
        }

        // Load the output file and show it:
        QUrl aboutUrl = "file://"+outputFilePath;
        aboutDialog->setUrl (aboutUrl);
        aboutDialog->setFocus();
        aboutDialog->show();

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

    void sslErrors (QNetworkReply *reply, const QList<QSslError> &errors)
    {
        foreach (QSslError error, errors) {
            qDebug() << "SSL error: " << error;
        }
        reply->ignoreSslErrors();
    }

public:

    TopLevel (QString type);

private:

    Page *mainPage;

    Settings settings;

    QUrl qWebHitTestURL;
    QString filepath;
    QWebView *newWindow;

    QWebView *aboutDialog;

};

#endif // PEB_H
