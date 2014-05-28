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

#include <qglobal.h>
#if QT_VERSION >= 0x050000
// Qt5 code:
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#include <QUrlQuery>
#else
// Qt4 code:
#include <QPrintDialog>
#include <QPrinter>
#endif


class Settings : public QSettings
{
    Q_OBJECT

public slots:

    void saveSetting (QString key, QString value)
    {
        QRegExp keyFinderRegExp ("^"+key+"=");
        QString temp;

        QFile settingsFile (settingsFileName);

        if (settingsFile.open (QIODevice::ReadOnly | QIODevice::Text)) {
            QTextStream input (&settingsFile);
            while (!input.atEnd()) {
                QString line = input.readLine();
                if (line.contains (keyFinderRegExp)) {
                    line = key+"="+value;
                }
                temp.append (line);
                temp.append ("\n");
            }
        }
        settingsFile.close();

        if (settingsFile.open (QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream output (&settingsFile);
            output << temp;
            settingsFile.close();
        }

        sync();
    }

    void defineInterpreter (QString filepath)
    {
        QString extension = filepath.section (".", 1, 1);
        qDebug() << "Extension:" << extension;

        if (extension == "pl") {
            interpreter = perlInterpreter;
        }
        if (extension == "py") {
            interpreter = pythonInterpreter;
        }
        if (extension == "php") {
            interpreter = phpInterpreter;
        }
        qDebug() << "Interpreter:" << interpreter;
    }

    void cssInjector (QString htmlInput)
    {
        QString css;
        css.append ("<style media=\"screen\" type=\"text/css\">");
        QFile cssFile (QDir::toNativeSeparators (
                        defaultThemeDirectory+
                        QDir::separator()+
                        "current.css"));
        cssFile.open(QFile::ReadOnly);
        QString cssFileContents = QString (cssFile.readAll());
        css.append (cssFileContents);
        css.append ("</style>");
        css.append ("</head>");
        htmlInput.replace ("</head>", css);
        cssInjectedHtml = htmlInput;
    }

    void httpHeaderCleaner (QString input)
    {
        QRegExp regExp01 ("Content-type: text/html.{1,25}\n");
        regExp01.setCaseSensitivity (Qt::CaseInsensitive);
        input.replace (regExp01, "");
        QRegExp regExp02 ("X-Powered-By: PHP.{1,20}\n");
        regExp02.setCaseSensitivity (Qt::CaseInsensitive);
        input.replace (regExp02, "");
        httpHeadersCleanedHtml = input;
    }

public:

    Settings();

    // Variables from settings file:
    QString rootDirName;

    QString settingsFileName;
    QString settingsDirName;
    QDir settingsDir;
    QString mongooseSettingsFileName;

    QString perlLib;
    QString perlInterpreter;
    QString pythonInterpreter;
    QString phpInterpreter;

    QString debuggerInterpreter;
    QString debuggerOutput;
    QString debuggerHtmlHeader;
    QString debuggerHtmlFooter;
    QString sourceViewer;
    QStringList sourceViewerArguments;

    QString autostartLocalWebserver;
    QString pingLocalWebserver;
    QString listeningPort;
    QString quitToken;

    QString pingRemoteWebserver;
    QString remoteWebserver;
    int remoteWebserverPort;

    QString userAgent;

    QString startPageSetting;
    QString startPage;

    QString windowSize;
    int fixedWidth;
    int fixedHeight;
    QString framelessWindow;
    QString stayOnTop;
    QString browserTitle;
    QString contextMenu;
    QString webInspector;

    QString iconPathName;
    QPixmap icon;

    QString defaultTheme;
    QString defaultThemeDirectory;
    QString allThemesDirectory;

    QString defaultTranslation;
    QString allTranslationsDirectory;

    QString helpDirectory;

    QString systrayIcon;
    QString systrayIconDoubleClickAction;

    QString logging;
    QString logMode;
    QString logDirName;
    QString logDirFullPath;
    QString logPrefix;

    // Variables returned from functions:
    QString interpreter;
    QString cssInjectedHtml;
    QString httpHeadersCleanedHtml;

};


class Watchdog : public QObject
{

    Q_OBJECT

public slots:

    void trayIconActivatedSlot (QSystemTrayIcon::ActivationReason reason)
    {
        if (reason == QSystemTrayIcon::DoubleClick) {

            if (settings.systrayIconDoubleClickAction == "quit") {
                QMessageBox confirmExitMessageBox;
                confirmExitMessageBox.setWindowTitle (tr ("Quit"));
                confirmExitMessageBox.setIconPixmap (settings.icon);
                confirmExitMessageBox.setText (tr ("You are going to quit the program.<br>Are you sure?"));
                confirmExitMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
                confirmExitMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
                confirmExitMessageBox.setButtonText (QMessageBox::No, tr ("No"));
                confirmExitMessageBox.setDefaultButton (QMessageBox::No);
                if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                    QApplication::quit();
                }
            }

            if (settings.systrayIconDoubleClickAction == "minimize_all_windows") {
                foreach (QWidget *window, QApplication::topLevelWidgets()) {
                    if (window->isVisible()) {
                        window->showMinimized();
                    }
                }
            }

        }
    }

    void pingSlot()
    {
        QTcpSocket localWebServerPing;
        QTcpSocket webConnectivityPing;

        if (settings.pingLocalWebserver == "enable") {
            localWebServerPing.connectToHost ("127.0.0.1", settings.listeningPort.toInt());
        }

        if (settings.pingRemoteWebserver == "enable") {
            webConnectivityPing.connectToHost (settings.remoteWebserver, settings.remoteWebserverPort);
        }

        if (settings.pingLocalWebserver == "enable") {
            if (localWebServerPing.waitForConnected (1000)) {
                qDebug() << "Local web server is running.";
            } else {
                if (settings.autostartLocalWebserver == "enable") {
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

        if (settings.pingRemoteWebserver == "enable") {
            if (webConnectivityPing.waitForConnected (1000))
            {

                if (settings.systrayIcon == "enable") {
                    if (lastStateOfRemoteWebserver.length() > 0) {
                        if (lastStateOfRemoteWebserver == "unavailable") {
                            QSystemTrayIcon::MessageIcon icon =
                                    QSystemTrayIcon::MessageIcon (0);
                            trayIcon->showMessage (tr ("Connected to remote server"),
                                                   tr ("Connectivity to remote server is restored!"),
                                                   icon, 10 * 1000);
                        }
                    } else {
                        QSystemTrayIcon::MessageIcon icon = QSystemTrayIcon::MessageIcon (0);
                        trayIcon->showMessage (tr ("Connected to remote server"),
                                               tr ("Remote server is available."),
                                               icon, 10 * 1000);
                    }
                    lastStateOfRemoteWebserver = "available";
                }

                qputenv ("REMOTE_SERVER", "available");
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

                if (settings.systrayIcon == "enable") {
                    if (lastStateOfRemoteWebserver.length() > 0) {
                        if (lastStateOfRemoteWebserver == "available") {
                            QSystemTrayIcon::MessageIcon icon = QSystemTrayIcon::MessageIcon (2);
                            trayIcon -> showMessage (tr ("Disconnected"),
                                                     tr ("Connectivity to remote server is lost!"),
                                                     icon, 10 * 1000);
                        }
                    } else {
                        QSystemTrayIcon::MessageIcon icon = QSystemTrayIcon::MessageIcon (2);
                        trayIcon->showMessage (tr ("No connection"),
                                               tr ("Remote server is not available."),
                                               icon, 10 * 1000);
                    }
                    lastStateOfRemoteWebserver = "unavailable";
                }

                qputenv ("REMOTE_SERVER", "unavailable");
                qDebug() << "Internet connectivity is not available.";

            }
            qDebug() << "===============";
        }
    }

    void aboutToQuitSlot()
    {
        if (settings.systrayIcon == "enable") {
            trayIcon->hide();
        }
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

    QString lastStateOfRemoteWebserver;

};


class ModifiedNetworkAccessManager : public QNetworkAccessManager
{

    Q_OBJECT

signals:

    void viewSourceCodeFromNAM (QUrl url,
                                bool sourceEnabled,
                                bool themeEnabled,
                                QString outputType);

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
                (!request.url().toString().contains ("debugger"))) {

            QString query = request.url()
                    .toString (QUrl::RemoveScheme
                               | QUrl::RemoveAuthority
                               | QUrl::RemovePath)
                    .replace ("?", "");

            if (query.contains ("source=enabled")) {
                QUrl url = request.url();
                bool sourceEnabled = true;
                bool themeEnabled = false;
                QString outputType = "accumulation";

                emit viewSourceCodeFromNAM (url,
                                            sourceEnabled,
                                            themeEnabled,
                                            outputType);

                QNetworkRequest emptyRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         emptyRequest);
            }

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

            if (query.length() > 0) {
                qDebug() << "Query string:" << query;
            }

            QString extension = filepath.section (".", 1, 1);
            settings.defineInterpreter (filepath);

            if (extension == "pl" or extension == "php" or extension == "py") {

                QProcess handler;

                if (query.length() > 0) {
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

                QString output;
                QString error;

                if (!filepath.contains ("longrun")) {
                    handler.start (settings.interpreter, QStringList() <<
                                   QDir::toNativeSeparators
                                   (settings.rootDirName+
                                    QDir::separator()+filepath));

                    if (handler.waitForFinished (1000)) {
                        output = handler.readAllStandardOutput();
                        error = handler.readAllStandardError();
                        handler.close();
                    }
                }

                QString outputFilePath;

                outputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "output.htm");

                QFile outputFilePathFile (outputFilePath);
                if (outputFilePathFile.exists()) {
                    outputFilePathFile.remove();
                }

                settings.httpHeaderCleaner (output);
                output = settings.httpHeadersCleanedHtml;

                if ((!request.url().toString().contains ("phpinfo")) and
                    (!query.contains ("theme=disabled"))) {
                    settings.cssInjector (output);
                    output = settings.cssInjectedHtml;
                }

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
                         (outputFilePath));

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

            QString extension = filepath.section (".", 1, 1);
            settings.defineInterpreter (filepath);

            if (extension == "pl" or extension == "php" or extension == "py") {

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
                handler.start (settings.interpreter, QStringList() <<
                               QDir::toNativeSeparators
                               (settings.rootDirName+
                                QDir::separator()+filepath));
                if (postData.size() > 0) {
                    handler.write (outgoingByteArray);
                    handler.closeWriteChannel();
                }

                QString output;
                QString error;

                if (handler.waitForFinished (1000)) {
                    output = handler.readAllStandardOutput();
                    error = handler.readAllStandardError();
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

                settings.httpHeaderCleaner (output);
                output = settings.httpHeadersCleanedHtml;

                settings.cssInjector (output);
                output = settings.cssInjectedHtml;

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
        msgBox.setText (tr ("Please restore the missing file:<br>")+
                        QDir::toNativeSeparators (settings.rootDirName+filepath));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
    }

private:

    QString filepath;

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
        //dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
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

    void selectDebuggingPerlInterpreterSlot()
    {
        QFileDialog selectInterpreterDialog;
        selectInterpreterDialog.setFileMode (QFileDialog::AnyFile);
        selectInterpreterDialog.setViewMode (QFileDialog::Detail);
        //selectInterpreterDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
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
        //selectPerlLibDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
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

    void startLongRunningScript (QUrl url,
                                 bool sourceEnabled,
                                 bool themeEnabled,
                                 QString outputType)
    {
        qDebug() << "Long-running script:" << url.toString();

        longRunningScriptThemeEnabled = themeEnabled;
        longRunningScriptOutputType = outputType;

        filepath = url.toString (QUrl::RemoveScheme
                                 | QUrl::RemoveAuthority
                                 | QUrl::RemoveQuery);

        QString queryString = url.toString (QUrl::RemoveScheme
                                            | QUrl::RemoveAuthority
                                            | QUrl::RemovePath)
                .replace ("?", "");

        qDebug() << "File path:" << QDir::toNativeSeparators
                    (settings.rootDirName+filepath);
        checkFileExistenceSlot();

        extension = filepath.section (".", 1, 1);
        settings.defineInterpreter (filepath);

        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();

        if (queryString.length() > 0) {
            env.insert ("REQUEST_METHOD", "GET");
            env.insert ("QUERY_STRING", queryString);
            longRunningScriptHandler.setProcessEnvironment (env);
            qDebug() << "Long-running script query string:" << queryString;
        }

        QFileInfo scriptAbsoluteFilePath (QDir::toNativeSeparators
                                          (settings.rootDirName+
                                           QDir::separator()+filepath));
        QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
        longRunningScriptHandler.setWorkingDirectory (scriptDirectory);
        qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

        qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
        qDebug() << "===============";

        if (sourceEnabled == true) {
            longRunningScriptOutputInNewWindow = false;

            QStringList sourceViewerCommandLine;
            sourceViewerCommandLine.append (settings.sourceViewer);
            if (settings.sourceViewerArguments.length() > 1) {
                foreach (QString argument, settings.sourceViewerArguments) {
                    sourceViewerCommandLine.append (argument);
                }
            }
            sourceViewerCommandLine.append (QDir::toNativeSeparators
                                            (settings.rootDirName+
                                             QDir::separator()+filepath));

            longRunningScriptHandler.start (settings.perlInterpreter, sourceViewerCommandLine);
        } else {
            longRunningScriptHandler.start (settings.interpreter, QStringList() <<
                                            QDir::toNativeSeparators
                                            (settings.rootDirName+
                                             QDir::separator()+filepath));
        }

        QWebSettings::clearMemoryCaches();
    }

    void displayLongRunningScriptOutputSlot()
    {
        QString output = longRunningScriptHandler.readAllStandardOutput();

        settings.httpHeaderCleaner (output);
        output = settings.httpHeadersCleanedHtml;

        if (longRunningScriptOutputType == "accumulation") {
            longRunningScriptAccumulatedOutput.append (output);
        }

        longRunningScriptOutputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "lroutput.htm");

        QFile longRunningScriptOutputFile (longRunningScriptOutputFilePath);

        // Delete previous output file:
        if (longRunningScriptOutputFile.exists()) {
            longRunningScriptOutputFile.remove();
        }

        // Latest output:
        if (longRunningScriptOutputType == "latest") {
            if (longRunningScriptThemeEnabled == true) {
                settings.cssInjector (output);
                output = settings.cssInjectedHtml;
            }
            if (longRunningScriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&longRunningScriptOutputFile);
                stream << output << endl;
            }
        }

        // Accumulated output:
        if (longRunningScriptOutputType == "accumulation") {
            if (longRunningScriptThemeEnabled == true) {
                settings.cssInjector (longRunningScriptAccumulatedOutput);
                longRunningScriptAccumulatedOutput = settings.cssInjectedHtml;
            }
            if (longRunningScriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&longRunningScriptOutputFile);
                stream << longRunningScriptAccumulatedOutput << endl;
            }
        }

        qDebug() << "Output from long-running script received.";
        qDebug() << "Long-running script output file:" << longRunningScriptOutputFilePath;
        qDebug() << "===============";

        if (longRunningScriptOutputInNewWindow == false) {
            Page::currentFrame()->setUrl
                    (QUrl::fromLocalFile (longRunningScriptOutputFilePath));
        }

        if (longRunningScriptOutputInNewWindow == true) {
            newLongRunWindow->setUrl
                    (QUrl::fromLocalFile (longRunningScriptOutputFilePath));
            newLongRunWindow->show();
        }

    }

    void longRunningScriptFinishedSlot()
    {
        longRunningScriptHandler.close();
        longRunningScriptAccumulatedOutput = "";
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

        // Remove SUB characters:
        debuggerOutput.replace ("\\u001a", "");

        QRegExp debuggerOutputRegExp01 ("\\[\\d{1,2}\\w{1,3}|DB|\\<\\d{1,3}\\>|\e|[\x80-\x9f]|\x08|\r");
        debuggerOutputRegExp01.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp01, "");

        QRegExp debuggerOutputRegExp02 ("Editor support \\w{1,20}.");
        debuggerOutputRegExp02.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp02, "");

        QRegExp debuggerOutputRegExp03 ("Enter h .{40,80}\n");
        debuggerOutputRegExp03.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp03, "");

        QRegExp debuggerOutputRegExp04 (filepath+":\\d{1,5}:\\d{1,5}\n");
        debuggerOutputRegExp04.setCaseSensitivity (Qt::CaseSensitive);
        int outputRegExp04pos = debuggerOutputRegExp04.indexIn (debuggerOutput);
        Q_UNUSED (outputRegExp04pos);
        QString lineInfo = debuggerOutputRegExp04.capturedTexts().first();
        lineInfoLastLine = lineInfo.section (":", 1, 1);
        debuggerOutput.replace (debuggerOutputRegExp04, "");

        if (settings.debuggerOutput == "html") {
            debuggerOutput.replace ("\n", "<br>\n");
        }

        debuggerAccumulatedOutput.append (debuggerOutput);

        QRegExp debuggerAccumulatedOutputRegExp01 ("\n\\s*\n");
        debuggerAccumulatedOutputRegExp01.setCaseSensitivity (Qt::CaseSensitive);
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp01, "\n\n");

        QRegExp debuggerAccumulatedOutputRegExp02 ("\n\\s{4,}");
        debuggerAccumulatedOutputRegExp02.setCaseSensitivity (Qt::CaseSensitive);
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp02, "\n");

        if (debuggerAccumulatedOutput.contains ("Show module versions")) {
            QRegExp debuggerAccumulatedOutputRegExp03 ("\n\\s{3,}");
            debuggerAccumulatedOutputRegExp03.setCaseSensitivity (Qt::CaseSensitive);
            debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp03, "\n");
        }

        QRegExp debuggerAccumulatedOutputRegExp04 ("routines from .{10,30}\n");
        debuggerAccumulatedOutputRegExp04.setCaseSensitivity (Qt::CaseSensitive);
        int debuggerAccumulatedOutputRegExp04pos = debuggerAccumulatedOutputRegExp04.indexIn (debuggerAccumulatedOutput);
        Q_UNUSED (debuggerAccumulatedOutputRegExp04pos);
        QString debuggerVersion = debuggerAccumulatedOutputRegExp04.capturedTexts().first();
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp04, debuggerVersion+"\n");

        QRegExp debuggerAccumulatedOutputRegExp05 ("\n{3,100}");
        debuggerAccumulatedOutputRegExp05.setCaseSensitivity (Qt::CaseSensitive);
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp05, "\n\n");

        if (debuggerCommandHumanReadable != "List Variables in Package (V)") {
            debuggerAccumulatedOutput.replace ("  ", " ");
        }
        if (debuggerCommandHumanReadable == "List Variables in Package (V)" and
                settings.debuggerOutput == "html") {
            debuggerAccumulatedOutput.replace ("  ", "&nbsp;&nbsp;");
        }

        if (settings.debuggerOutput == "html") {
            debuggerAccumulatedOutput.replace ("\n<br>\n<br>", "<br>");

            QFile htmlFooterFile (
                        QDir::toNativeSeparators (settings.debuggerHtmlFooter));
            htmlFooterFile.open (QFile::ReadOnly | QFile::Text);
            QString htmlFooterFileContents = QString (htmlFooterFile.readAll());
            //QString htmlFooterFileContents = "</body>\n</html>";
            debuggerAccumulatedOutput.replace (htmlFooterFileContents, "");
            debuggerAccumulatedOutput.append (htmlFooterFileContents);
        }

        if (settings.debuggerOutput == "txt") {
        debuggerOutputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "deboutput.txt");
        }
        if (settings.debuggerOutput == "html") {
        debuggerOutputFilePath = QDir::toNativeSeparators
                        (QDir::tempPath()+
                         QDir::separator()+
                         "deboutput.htm");
        }

        QFile debuggerOutputFile (debuggerOutputFilePath);
        if (debuggerOutputFile.open (QIODevice::ReadWrite)) {
            QTextStream debuggerOutputStream (&debuggerOutputFile);
            debuggerOutputStream << debuggerAccumulatedOutput << endl;
        }
        qDebug() << "Output from debugger received.";
        qDebug() << "LineInfo last line:" << lineInfoLastLine;
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
    QString longRunningScriptAccumulatedOutput;
    QString longRunningScriptOutputFilePath;
    bool longRunningScriptThemeEnabled;
    QString longRunningScriptOutputType;
    bool longRunningScriptOutputInNewWindow;
    QWebView *newLongRunWindow;

    QProcess debuggerHandler;
    QString debuggerCommandHumanReadable;
    QString lineInfoLastLine;
    QString debuggerAccumulatedOutput;
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
        if (settings.startPage.contains (".htm") or
                settings.startPage.contains (".html") or
                settings.startPage.contains (".HTM") or
                settings.startPage.contains (".HTML")) {
            setUrl (QUrl::fromLocalFile
                    (QDir::toNativeSeparators
                     (settings.startPage)));
        } else {
            setUrl (QUrl (QString (PEB_DOMAIN+
                                   settings.startPageSetting)));
        }
    }

    void pageLoadedDynamicTitleSlot (bool ok)
    {
        if (ok) {
            setWindowTitle (TopLevel::title());
            QFile::remove
                    (QDir::toNativeSeparators
                     (QDir::tempPath()+QDir::separator()+"output.htm"));
        }
    }

    void pageLoadedStaticTitleSlot (bool ok)
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
        QPrintDialog *dialog = new QPrintDialog (&printer);
        //dialog->setWindowFlags (Qt::WindowStaysOnTopHint);
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


    void viewSourceFromContextMenuSlot()
    {
        newWindow = new TopLevel (QString ("mainWindow"));
        newWindow->setWindowIcon (settings.icon);

#if QT_VERSION >= 0x050000
        QUrlQuery viewSourceUrlQuery;
        viewSourceUrlQuery.addQueryItem (QString ("source"), QString ("enabled"));
        QUrl viewSourceUrl = qWebHitTestURL;
        viewSourceUrl.setQuery (viewSourceUrlQuery);
#else
        QUrl viewSourceUrl = qWebHitTestURL;
        viewSourceUrl.addQueryItem (QString ("source"), QString ("enabled"));
#endif

        qDebug() << "Local script to view as source code:" << qWebHitTestURL.toString();
        qDebug() << "===============";

        newWindow->setUrl (viewSourceUrl);
        newWindow->show();
    }

    void openInNewWindowSlot()
    {
        newWindow = new TopLevel (QString ("mainWindow"));
        newWindow->setWindowIcon (settings.icon);
        qDebug() << "Link to open in a new window:" << qWebHitTestURL;
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
            if (QUrl (PEB_DOMAIN).isParentOf (qWebHitTestURL)) {

                menu->addSeparator ();

                QAction *editAct = menu->addAction (tr ("&Edit"));
                QObject::connect (editAct, SIGNAL (triggered()),
                                  this, SLOT (editSlot()));

                QString extension = qWebHitTestURL
                        .toString (QUrl::RemoveQuery)
                        .replace ("?", "")
                        .section (".", 1, 1);

                if (extension == "pl" or extension == "php" or extension == "py") {
                    QAction *viewSourceAct = menu->addAction (tr ("&View Source"));
                    QObject::connect (viewSourceAct, SIGNAL (triggered()),
                                      this, SLOT (viewSourceFromContextMenuSlot()));
                }

                if (!qWebHitTestURL.toString().contains ("longrun")) {
                    QAction *openInNewWindowAct = menu->addAction (tr ("&Open in new window"));
                    QObject::connect (openInNewWindowAct, SIGNAL (triggered()),
                                      this, SLOT (openInNewWindowSlot()));
                }

            }
        }

        if (!qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty() and
                (!qWebHitTestResult.isContentSelected()) and
                (!qWebHitTestResult.isContentEditable ())) {

            menu->addSeparator();

            if (settings.windowSize == "maximized" or settings.windowSize == "fullscreen") {
                if (settings.framelessWindow == "disable" and
                        (!TopLevel::isMaximized())) {
                    QAction *maximizeAct = menu->addAction (tr ("&Maximized window"));
                    QObject::connect (maximizeAct, SIGNAL (triggered()),
                                      this, SLOT (maximizeSlot()));
                }

                if (!TopLevel::isFullScreen()) {
                QAction *toggleFullScreenAct = menu->addAction (tr ("&Fullscreen"));
                QObject::connect (toggleFullScreenAct, SIGNAL (triggered()),
                                  this, SLOT (toggleFullScreenSlot()));
                }
            }

            if (settings.framelessWindow == "disable") {
                QAction *minimizeAct = menu->addAction (tr ("Mi&nimize"));
                QObject::connect (minimizeAct, SIGNAL (triggered()),
                                  this, SLOT (minimizeSlot()));
            }

            if (!TopLevel::url().toString().contains ("lroutput")) {
                QAction *homeAct = menu->addAction (tr ("&Home"));
                QObject::connect (homeAct, SIGNAL (triggered()),
                                  this, SLOT (loadStartPageSlot()));
            }

            if ((!TopLevel::url().toString().contains ("lroutput")) and
                    (!TopLevel::url().toString().contains ("deboutput"))) {
                QAction *reloadAct = menu->addAction (tr ("&Reload"));
                QObject::connect (reloadAct, SIGNAL (triggered()),
                                  this, SLOT (reloadSlot()));
            }

            QAction *printAct = menu->addAction (tr ("&Print"));
            QObject::connect (printAct, SIGNAL (triggered()),
                              this, SLOT (printPageSlot()));

            if ((!TopLevel::url().toString().contains ("lroutput")) and
                    (!TopLevel::url().toString().contains ("deboutput"))) {
                QAction *selectThemeAct = menu->addAction (tr ("&Select theme"));
                QObject::connect (selectThemeAct, SIGNAL (triggered()),
                                  this, SLOT (selectThemeFromContextMenuSlot()));
            }

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

        // Initialize a new message box
        aboutDialog = new TopLevel (QString ("messageBox"));

        // Calculate message box dimensions,
        // center message box on screen:
        QRect screenRect = QDesktopWidget().screen()->rect();
        float messageBoxHeigth = screenRect.height() * 0.57;
        float messageBoxWidth = messageBoxHeigth * 1.20;
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
                        settings.helpDirectory+
                        QDir::separator()+"about.htm"));
        aboutFileTemplateFile.open(QFile::ReadOnly);
        QString aboutTemplateContents = QString (aboutFileTemplateFile.readAll());
        aboutTemplateContents.replace ("[% icon %]", settings.iconPathName);
        aboutTemplateContents.replace ("[% version %]", QApplication::applicationVersion());
        aboutTemplateContents.replace ("[% Qt Webkit version %]", qtVersion);
        aboutTemplateContents.replace ("[% Qt version %]", qtWebKitVersion);
        output.append (aboutTemplateContents);

        // Read CSS theme file and inject its content into the output variable:
        settings.cssInjector (output);
        output = settings.cssInjectedHtml;

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
