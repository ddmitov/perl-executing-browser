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

// The domain of the Perl Debugger:
#ifndef PERL_DBG_DOMAIN
#define PERL_DBG_DOMAIN "http://perl-debugger-pseudodomain/"
#endif

#include <QApplication>
#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QtWebKit>
#include <QtNetwork/QNetworkAccessManager>
#include <QProcess>
#include <QMessageBox>
#include <QFileDialog>
#include <QPrintPreviewDialog>
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


extern QStringList startedScripts;

extern QStringList allowedEnvironmentVariables;


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
            settingsFile.close();
        }

        if (settingsFile.open (QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream output (&settingsFile);
            output << temp;
            settingsFile.close();
        }

        sync();
    }

    void defineInterpreter (QString filepath)
    {
        interpreter = "undefined";

        extension = filepath.section (".", 1, 1);

        if (extension.length() == 0) {
            QString firstLine;

            QFile file (filepath);
            if (file.open (QIODevice::ReadOnly | QIODevice::Text)) {
                firstLine = file.readLine();
            }

            if (firstLine.contains (perlShebang)) {
                interpreter = perlInterpreter;
            }
            if (firstLine.contains (pythonShebang)) {
                interpreter = pythonInterpreter;
            }
            if (firstLine.contains (phpShebang)) {
                interpreter = phpInterpreter;
            }
        } else {
            if (extension.contains (htmlExtensions)) {
                interpreter = "browser-html";
            }
            if (extension.contains (cssExtension)) {
                interpreter = "browser-css";
            }
            if (extension.contains (pngExtension)) {
                interpreter = "browser-image";
            }
            if (extension.contains (jpgExtensions)) {
                interpreter = "browser-image";
            }
            if (extension.contains (gifExtension)) {
                interpreter = "browser-image";
            }

            if (extension == "pl") {
                interpreter = perlInterpreter;
            }
            if (extension == "py") {
                interpreter = pythonInterpreter;
            }
            if (extension == "php") {
                interpreter = phpInterpreter;
            }
        }
    }

    void cssLinker (QString htmlInput)
    {
        cssLinkedHtml = "";

        if ((htmlInput.contains ("</title>")) and
                (!htmlInput.contains (defaultThemeDirectory))) {
            QString cssLink;
            cssLink.append ("</title>\n");
            cssLink.append ("<link href='file://");
            cssLink.append (defaultThemeDirectory);
            cssLink.append ("/current.css' media='all' rel='stylesheet'/>");
            htmlInput.replace ("</title>", cssLink);

            cssLinkedHtml = htmlInput;
        } else {
            cssLinkedHtml = htmlInput;
        }
    }

    void httpHeaderCleaner (QString input)
    {
        httpHeadersCleanedHtml = "";

        if (input.contains ("<!DOCTYPE")) {
            QString htmlContent = input.section ("<!DOCTYPE", 1, 1);
            httpHeadersCleanedHtml = "<!DOCTYPE";
            httpHeadersCleanedHtml.append (htmlContent);
        }

        if (input.contains ("<html>")) {
            QString htmlContent = input.section ("<html>", 1, 1);
            httpHeadersCleanedHtml = "<html>";
            httpHeadersCleanedHtml.append (htmlContent);
        }
    }

public:

    Settings();

    // Variables from settings file or command line options:
    QString rootDirName;

    QString settingsFileName;
    QString settingsDirName;
    QDir settingsDir;

    QString perlLib;
    QString perlInterpreter;
    QString pythonInterpreter;
    QString phpInterpreter;

    QString debuggerInterpreter;
    QString debuggerHtmlTemplate;

    QString sourceViewer;
    QStringList sourceViewerArguments;

    QString userAgent;
    QStringList allowedWebSites;

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
    QString extension;
    QString interpreter;
    QString cssLinkedHtml;
    QString httpHeadersCleanedHtml;

private:

    // Regular expressions for file type detection by shebang line:
    QRegExp perlShebang;
    QRegExp pythonShebang;
    QRegExp phpShebang;

    // Regular expressions for file type detection by extension:
    QRegExp htmlExtensions;
    QRegExp cssExtension;
    QRegExp jsExtension;
    QRegExp pngExtension;
    QRegExp jpgExtensions;
    QRegExp gifExtension;

    QRegExp plExtension;
    QRegExp pyExtension;
    QRegExp phpExtension;

};


class TrayIcon : public QSystemTrayIcon
{

    Q_OBJECT

public slots:

    void trayIconActivatedSlot (QSystemTrayIcon::ActivationReason reason)
    {
        if (reason == QSystemTrayIcon::DoubleClick) {

            if (settings.systrayIconDoubleClickAction == "quit") {
                QMessageBox confirmExitMessageBox;
                confirmExitMessageBox.setWindowModality (Qt::WindowModal);
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

    void trayIconHideSlot()
    {
        trayIcon->hide();
    }

public:

    TrayIcon();

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

signals:

    void startScriptSignal (QUrl url, QByteArray postDataArray);

protected:

    virtual QNetworkReply *createRequest (Operation operation,
                                          const QNetworkRequest &request,
                                          QIODevice *outgoingData = 0)
    {
        // GET requests to local content:
        if (operation == GetOperation and
                (QUrl (PEB_DOMAIN)).isParentOf (request.url())) {

            QString filepath = request.url()
                    .toString (QUrl::RemoveScheme
                               | QUrl::RemoveAuthority
                               | QUrl::RemoveQuery
                               | QUrl::RemoveFragment);

            QString fullFilePath = QDir::toNativeSeparators
                    (settings.rootDirName+filepath);

            settings.defineInterpreter (fullFilePath);

            // Local HTML, CSS, JS or supported image files:
            if (settings.interpreter.contains ("browser")) {

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (settings.rootDirName+
                          request.url().toString (
                              QUrl::RemoveScheme | QUrl::RemoveAuthority)));

                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest (networkRequest));
            }

            // Local Perl, Python or PHP scripts:
            if ((!settings.interpreter.contains ("undefined")) and
                    (!settings.interpreter.contains ("browser"))) {

                QByteArray emptyPostDataArray;
                emit startScriptSignal (request.url(), emptyPostDataArray);
            }

            // Local files without recognized file type:
            if (settings.interpreter.contains ("undefined")) {

                qDebug() << "File type not recognized!";
                qDebug() << "===============";


                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (settings.rootDirName+
                          "help/notrecognized.htm"));


                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest (networkRequest));
            }
        }

        // Take data from a local form using CGI POST method and
        // execute associated local script:
        if (operation == PostOperation and
                (QUrl (PEB_DOMAIN)).isParentOf (request.url())) {

            if (outgoingData) {
                QByteArray postDataArray = outgoingData->readAll();
                emit startScriptSignal (request.url(), postDataArray);
            }
        }

        // GET, POST and PUT requests to localhost:
        if ((operation == GetOperation or
             operation == PostOperation or
             operation == PutOperation) and
                (request.url().toString().contains ("localhost"))) {

            qDebug() << "Local webserver link:" << request.url().toString();
            qDebug() << "===============";

            QNetworkRequest networkRequest;
            networkRequest.setUrl (request.url());

            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest (networkRequest));
        }

        // GET, POST and PUT requests to external web resources.
        // Domain filtering happens here:
        if ((operation == GetOperation or
             operation == PostOperation or
             operation == PutOperation) and
                ((request.url().scheme().contains ("file")) or
                 (request.url().toString().contains (PEB_DOMAIN)) or
                 (request.url().toString().contains (PERL_DBG_DOMAIN)) or
                 (settings.allowedWebSites.contains (request.url().authority())))) {

            qDebug() << "Allowed link:" << request.url().toString();
            qDebug() << "===============";

            QNetworkRequest networkRequest;
            networkRequest.setUrl (request.url());

            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest (networkRequest));
        } else {
            qDebug() << "Not allowed link:" << request.url().toString();
            qDebug() << "===============";


            QNetworkRequest networkRequest;
            networkRequest.setUrl
                    (QUrl::fromLocalFile
                     (settings.rootDirName+
                      "help/forbidden.htm"));


            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest (networkRequest));
        }

        return QNetworkAccessManager::createRequest (operation, request);
    }

private:

    Settings settings;

};


class Page : public QWebPage
{
    Q_OBJECT

signals:

    void displayErrorsSignal (QString errorsFilePath);

    void sourceCodeForDebuggerReadySignal();

    void printPreviewSignal();

    void printSignal();

    void saveAsPdfSignal();

    void reloadSignal();

    void closeWindowSignal();

    void quitFromURLSignal();

public slots:

    void selectThemeSlot()
    {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
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

            qDebug() << "Selected new theme:" << newTheme;
            qDebug() << "===============";
        } else {
            qDebug() << "No new theme selected.";
            qDebug() << "===============";
        }
    }

    void missingFileMessageSlot()
    {
        QMessageBox msgBox;
        msgBox.setWindowModality (Qt::WindowModal);
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (tr ("Missing file"));
        msgBox.setText (QDir::toNativeSeparators (scriptFullFilePath)+
                        tr (" is missing.<br>Please restore the missing file."));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        qDebug() << QDir::toNativeSeparators (scriptFullFilePath) <<
                    "is missing.";
        qDebug() << "Please restore the missing file.";
        qDebug() << "===============";
    }

    void checkFileExistenceSlot (QString fullFilePath)
    {
        QFile file (QDir::toNativeSeparators (fullFilePath));
        if (!file.exists()) {
            missingFileMessageSlot();
        }
    }

    void startScriptSlot (QUrl url, QByteArray postDataArray)
    {
        scriptLastUrl = url;
        qDebug() << "Script URL:" << url.toString();

        QString scheme = url.toString (QUrl::RemoveAuthority
                                       | QUrl::RemovePath
                                       | QUrl::RemoveQuery);
        if (scheme == "http:") {
            QString relativeFilePath = url.toString (QUrl::RemoveScheme
                                                     | QUrl::RemoveAuthority
                                                     | QUrl::RemoveQuery);
            scriptFullFilePath = QDir::toNativeSeparators
                    (settings.rootDirName+relativeFilePath);
        }
        if (scheme == "file:") {
            scriptFullFilePath = url.toString (QUrl::RemoveScheme).replace ("//", "");
        }

        QString queryString = url.toString (QUrl::RemoveScheme
                                            | QUrl::RemoveAuthority
                                            | QUrl::RemovePath)
                .replace ("?", "");

        scriptKilled = false;

        QString postData (postDataArray);

        if (queryString.contains ("action=kill") or
                postData.contains ("action=kill")) {
            if (scriptHandler.isOpen()) {
                qDebug() << "Script is going to be terminated by user request.";

                scriptHandler.close();
                scriptKilled = true;

                QMessageBox msgBox;
                msgBox.setWindowModality (Qt::WindowModal);
                msgBox.setWindowTitle (tr ("Script Killed"));
                msgBox.setIconPixmap (settings.icon);
                msgBox.setText (tr ("This script is terminated as requested:<br>")+
                                scriptFullFilePath);
                msgBox.setDefaultButton (QMessageBox::Ok);
                msgBox.exec();
            } else {
                scriptKilled = true;

                QMessageBox msgBox;
                msgBox.setWindowModality (Qt::WindowModal);
                msgBox.setWindowTitle (tr ("Script Finished"));
                msgBox.setIconPixmap (settings.icon);
                msgBox.setText (tr ("This script finished before script termination was requested:<br>")+
                                scriptFullFilePath);
                msgBox.setDefaultButton (QMessageBox::Ok);
                msgBox.exec();
            }
        } else {
            bool sourceEnabled;

            if (scriptFullFilePath.contains ("longrun")) {
                // Default values for long-running scripts:
                sourceEnabled = false;
                scriptOutputThemeEnabled = true;
                scriptOutputType = "accumulation";
                scriptOutputScrollDown = false;
            } else {
                // Default values for CGI-like scripts:
                sourceEnabled = false;
                scriptOutputThemeEnabled = true;
                scriptOutputType = "final";
            }

            if (queryString.contains ("source=enabled")) {
                // Default values for displaying source code outside of the Perl debugger:
                sourceEnabled = true;
                scriptOutputThemeEnabled = false;
                scriptOutputType = "final";
            }

            if (scheme == "file:") {
                // Default values for displaying source code within the Perl debugger GUI:
                sourceEnabled = true;
                scriptOutputThemeEnabled = false;
                scriptOutputType = "final";
            }

            if (queryString.contains ("theme=disabled")) {
                scriptOutputThemeEnabled = false;
                queryString.replace ("theme=disabled", "");
            }

            if (queryString.contains ("output=latest")) {
                scriptOutputType = "latest";
                queryString.replace ("output=latest", "");
            }

            if (queryString.contains ("output=accumulation")) {
                scriptOutputType = "accumulation";
                queryString.replace ("output=accumulation", "");
            }

            if (queryString.contains ("output=final")) {
                scriptOutputType = "final";
                queryString.replace ("output=final", "");
            }

            if (queryString.contains ("scrolldown=enabled")) {
                scriptOutputScrollDown = true;
                queryString.replace ("scrolldown=enabled", "");
            }

            QRegExp multipleAmpersands ("&{2,}");
            queryString.replace (multipleAmpersands, "");
            QRegExp finalAmpersand ("&$");
            queryString.replace (finalAmpersand, "");
            QRegExp finalQuestionMark ("\\?$");
            queryString.replace (finalQuestionMark, "");

            checkFileExistenceSlot (scriptFullFilePath);
            settings.defineInterpreter (scriptFullFilePath);

            qDebug() << "File path:" << scriptFullFilePath;
            qDebug() << "Extension:" << settings.extension;
            qDebug() << "Interpreter:" << settings.interpreter;

            QStringList systemEnvironment =
                    QProcessEnvironment::systemEnvironment().toStringList();

            QProcessEnvironment env;

            foreach (QString environmentVariable, systemEnvironment) {
                QStringList environmentVariableList = environmentVariable.split ("=");
                QString environmentVariableName = environmentVariableList.first();
                if (!allowedEnvironmentVariables.contains (environmentVariableName)) {
                    env.remove (environmentVariable);
                } else {
                    env.insert (environmentVariableList.first(), environmentVariableList[1]);
                }
            }

            if (queryString.length() > 0) {
                env.insert ("REQUEST_METHOD", "GET");
                env.insert ("QUERY_STRING", queryString);
                qDebug() << "Query string:" << queryString;
            }

            if (postData.length() > 0) {
                env.insert ("REQUEST_METHOD", "POST");
                QString postDataSize = QString::number (postData.size());
                env.insert ("CONTENT_LENGTH", postDataSize);
                qDebug() << "POST data:" << postData;
            }

            scriptHandler.setProcessEnvironment (env);

            QFileInfo scriptAbsoluteFilePath (QDir::toNativeSeparators (scriptFullFilePath));
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            scriptHandler.setWorkingDirectory (scriptDirectory);
            qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

            qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
            qDebug() << "===============";

            if (!scriptHandler.isOpen()) {
                if (sourceEnabled == true) {
                    QString sourceFilepath = QDir::toNativeSeparators (scriptFullFilePath);

                    QStringList sourceViewerCommandLine;
                    sourceViewerCommandLine.append (settings.sourceViewer);
                    if (settings.sourceViewerArguments.length() > 1) {
                        foreach (QString argument, settings.sourceViewerArguments) {
                            sourceViewerCommandLine.append (argument);
                        }
                    }
                    sourceViewerCommandLine.append (sourceFilepath);
                    scriptHandler.start (settings.perlInterpreter, sourceViewerCommandLine,
                                         QProcess::Unbuffered | QProcess::ReadWrite);

                    startedScripts.append (sourceFilepath);
                } else {
                    scriptHandler.start (settings.interpreter, QStringList() <<
                                         QDir::toNativeSeparators
                                         (scriptFullFilePath),
                                         QProcess::Unbuffered | QProcess::ReadWrite);

                    startedScripts.append (scriptFullFilePath);

                    if (postData.length() > 0) {
                        scriptHandler.write (postDataArray);
                    }
                }
            } else {
                qDebug() << "Script already started:" << scriptFullFilePath;
                qDebug() << "===============";

                QMessageBox msgBox;
                msgBox.setWindowModality (Qt::WindowModal);
                msgBox.setWindowTitle (tr ("Script Already Started"));
                msgBox.setIconPixmap (settings.icon);
                msgBox.setText (tr ("This script is already started and still running:<br>")+
                                scriptFullFilePath);
                msgBox.setDefaultButton (QMessageBox::Ok);
                msgBox.exec();
            }

            scriptTimedOut = false;

            if (!scriptFullFilePath.contains ("longrun")) {
                QTimer::singleShot (3000, this, SLOT (scriptTimeoutSlot()));
            }

            QWebSettings::clearMemoryCaches();

            qputenv ("FILE_TO_OPEN", "");
            qputenv ("FILE_TO_CREATE", "");
            qputenv ("FOLDER_TO_OPEN", "");
        }
    }

    void scriptOutputSlot()
    {
        QString output = scriptHandler.readAllStandardOutput();

        if (scriptOutputType == "accumulation") {
            if (scriptOutputScrollDown == true) {
                scriptAccumulatedOutput.replace ("<a name='latest'>", "");

                QString modifiedOutput;
                modifiedOutput = output;
                modifiedOutput.prepend ("<a name='latest'>");

                scriptAccumulatedOutput.append (modifiedOutput);
            }

            if (scriptOutputScrollDown == false) {
                scriptAccumulatedOutput.append (output);
            }
        }

        if (scriptOutputType == "final") {
            scriptAccumulatedOutput.append (output);

            scriptOutputFilePath = QDir::toNativeSeparators
                    (QDir::tempPath()+QDir::separator()+"output.htm");
        } else {
            scriptOutputFilePath = QDir::toNativeSeparators
                    (QDir::tempPath()+QDir::separator()+"lroutput.htm");
        }

        QFile scriptOutputFile (scriptOutputFilePath);

        // Delete previous output file:
        if (scriptOutputFile.exists()) {
            scriptOutputFile.remove();
        }

        // Latest output:
        if (scriptOutputType == "latest") {

            settings.httpHeaderCleaner (output);
            output = settings.httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                settings.cssLinker (output);
                output = settings.cssLinkedHtml;
            }

            if (scriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&scriptOutputFile);
                stream << output << endl;
            }
        }

        // Accumulated output:
        if (scriptOutputType == "accumulation" or
                scriptOutputType == "final") {

            settings.httpHeaderCleaner (scriptAccumulatedOutput);
            scriptAccumulatedOutput = settings.httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                settings.cssLinker (scriptAccumulatedOutput);
                scriptAccumulatedOutput = settings.cssLinkedHtml;
            }

            if (scriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&scriptOutputFile);
                stream << scriptAccumulatedOutput << endl;
            }
        }

        qDebug() << "Output from script received.";
        qDebug() << "Script output file:" << scriptOutputFilePath;
        qDebug() << "===============";

        QString scheme = scriptLastUrl.toString (QUrl::RemoveAuthority
                                       | QUrl::RemovePath
                                       | QUrl::RemoveQuery);

        if (scheme != "file:") {
            if (scriptOutputType == "latest") {
                Page::currentFrame()->setUrl
                        (QUrl::fromLocalFile (scriptOutputFilePath));
            }
            if (scriptOutputType == "accumulation") {
                if (scriptOutputScrollDown == false) {
                    Page::currentFrame()->setUrl
                            (QUrl::fromLocalFile (scriptOutputFilePath));
                }
                if (scriptOutputScrollDown == true) {
                    Page::currentFrame()->setUrl (scriptOutputFilePath+"#latest");
                }
            }
        }

    }

    void scriptErrorSlot()
    {
        QString error = scriptHandler.readAllStandardError();
        scriptAccumulatedErrors.append (error);
        scriptAccumulatedErrors.append ("\n");

        qDebug() << "Script error:" << error;
        qDebug() << "===============";
    }

    void scriptFinishedSlot()
    {
        QString scheme = scriptLastUrl.toString (QUrl::RemoveAuthority
                                       | QUrl::RemovePath
                                       | QUrl::RemoveQuery);

        if (scriptTimedOut == false) {
            if (scriptOutputType == "final") {
                if (scheme != "file:") {
                    Page::currentFrame()->setUrl
                            (QUrl::fromLocalFile (scriptOutputFilePath));
                }
            }

            if (scriptAccumulatedErrors.length() > 0 and
                    scriptKilled == false) {
                QMessageBox showErrorsMessageBox;
                showErrorsMessageBox.setWindowModality (Qt::WindowModal);
                showErrorsMessageBox.setWindowTitle (tr ("Errors"));
                showErrorsMessageBox.setIconPixmap (settings.icon);
                showErrorsMessageBox.setText (tr ("Errors were found during script execution.<br>")+
                                              tr ("Do you want to see them?"));
                showErrorsMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
                showErrorsMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
                showErrorsMessageBox.setButtonText (QMessageBox::No, tr ("No"));
                showErrorsMessageBox.setDefaultButton (QMessageBox::Yes);

                if (showErrorsMessageBox.exec() == QMessageBox::Yes) {
                    QString scriptErrorFilePath = QDir::toNativeSeparators
                            (QDir::tempPath()+QDir::separator()+"lrerror.txt");

                    QFile scriptErrorFile (scriptErrorFilePath);
                    if (scriptErrorFile.open (QIODevice::ReadWrite)) {
                        QTextStream stream (&scriptErrorFile);
                        stream << scriptAccumulatedErrors << endl;
                    }

                    emit displayErrorsSignal (scriptErrorFilePath);

                }
            }

            scriptHandler.close();

            qDebug() << "Script finished:" << scriptFullFilePath;
            qDebug() << "===============";
        }

        startedScripts.removeOne (scriptFullFilePath);

        scriptAccumulatedOutput = "";
        scriptAccumulatedErrors = "";

        if (scheme != "file:") {
            QFile scriptOutputFile (scriptOutputFilePath);
            scriptOutputFile.remove();
        }

        if (scheme == "file:") {
            emit sourceCodeForDebuggerReadySignal();
        }
    }

    void scriptTimeoutSlot ()
    {
        if (scriptHandler.isOpen()) {

            scriptTimedOut = true;
            scriptHandler.close();

            startedScripts.removeOne (scriptFullFilePath);

            qDebug() << "Script timed out:" << scriptFullFilePath;
            qDebug() << "===============";

            QMessageBox msgBox;
            msgBox.setWindowModality (Qt::WindowModal);
            msgBox.setWindowTitle (tr ("Script Timeout"));
            msgBox.setIconPixmap (settings.icon);
            msgBox.setText (tr ("Your script timed out!<br>")+
                            tr ("Consider starting it as a long-running script."));
            msgBox.setDefaultButton (QMessageBox::Ok);
            msgBox.exec();
        }
    }

    // Display information about user-selected Perl scripts using the built-in Perl debugger.
    // Partial implementation of an idea proposed by Valcho Nedelchev.
    void selectDebuggingPerlInterpreterSlot()
    {
        QFileDialog selectInterpreterDialog;
        selectInterpreterDialog.setFileMode (QFileDialog::AnyFile);
        selectInterpreterDialog.setViewMode (QFileDialog::Detail);
        selectInterpreterDialog.setWindowModality (Qt::WindowModal);
        selectInterpreterDialog.setWindowIcon (settings.icon);
        debuggingInterpreter = selectInterpreterDialog.getOpenFileName
                (0, tr ("Select Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
        qDebug() << "Selected interpreter:" << debuggingInterpreter;
        qDebug() << "===============";
        selectInterpreterDialog.close();
        selectInterpreterDialog.deleteLater();

        QFileDialog selectPerlLibDialog;
        selectPerlLibDialog.setFileMode (QFileDialog::AnyFile);
        selectPerlLibDialog.setViewMode (QFileDialog::Detail);
        selectPerlLibDialog.setWindowModality (Qt::WindowModal);
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

    void startPerlDebugger (QUrl url)
    {
        debuggerLastUrl = url;

        if (debuggedScriptFilePath.length() > 1) {
            qDebug() << "File passed to Perl debugger:"
                     << QDir::toNativeSeparators (debuggedScriptFilePath);

            // Define Perl interpreter to be used for debugging:
            QString debuggedScriptExtension = debuggedScriptFilePath.section (".", 1, 1);
            if (debuggedScriptExtension.length() == 0)
                debuggedScriptExtension = "pl";
            qDebug() << "Extension:" << debuggedScriptExtension;

            if (settings.debuggerInterpreter == "current") {
                settings.defineInterpreter (debuggedScriptFilePath);
                debuggingInterpreter = settings.interpreter;
            }

            if (settings.debuggerInterpreter == "select") {
                selectDebuggingPerlInterpreterSlot();
            }

            qDebug() << "Interpreter:" << debuggingInterpreter;

            debuggerQueryString = url.toString (QUrl::RemoveScheme
                                                | QUrl::RemoveAuthority
                                                | QUrl::RemovePath)
                    .replace ("?", "")
                    .replace ("command=", "")
                    .replace ("+", " ");

            // Clean accumulated debugger output from previous debugger session:
            debuggerAccumulatedOutput = "";

            // Clean debugger output file from previous debugger session:
            QFile debuggerOutputFile (debuggerOutputFilePath);
            if (debuggerOutputFile.exists())
                debuggerOutputFile.remove();

            // Clean last debugger command in human-readable form:
            debuggerCommandHumanReadable = "";

            // Start a new debugger session with a new file:
            if (url.path().contains ("selectfile")) {
                debuggerHandler.close();
            }

            if (debuggerHandler.isOpen()) {

                QByteArray debuggerCommand;
                debuggerCommand.append (debuggerQueryString.toLatin1());
                debuggerCommand.append (QString ("\n").toLatin1());
                debuggerHandler.write (debuggerCommand);

                if (debuggerQueryString == "M") {
                    debuggerCommandHumanReadable = "Show module versions (M)";
                }
                if (debuggerQueryString == "S") {
                    debuggerCommandHumanReadable = "List subroutine names (S)";
                }
                if (debuggerQueryString == "V") {
                    debuggerCommandHumanReadable = "List variables in package (V)";
                }
                if (debuggerQueryString == "X") {
                    debuggerCommandHumanReadable = "List variables in current package (X)";
                }

            } else {

                QStringList systemEnvironment =
                        QProcessEnvironment::systemEnvironment().toStringList();

                QProcessEnvironment env;

                foreach (QString environmentVariable, systemEnvironment) {
                    QStringList environmentVariableList = environmentVariable.split ("=");
                    QString environmentVariableName = environmentVariableList.first();
                    if (!allowedEnvironmentVariables.contains (environmentVariableName)) {
                        env.remove (environmentVariable);
                    } else {
                        env.insert (environmentVariableList.first(), environmentVariableList[1]);
                    }
                }

                env.insert ("COLUMNS", "80");
                env.insert ("LINES", "24");
                debuggerHandler.setProcessEnvironment (env);

                QFileInfo scriptAbsoluteFilePath (debuggedScriptFilePath);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                debuggerHandler.setWorkingDirectory (scriptDirectory);
                qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

                qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
                qDebug() << "===============";

                debuggerHandler.setProcessChannelMode (QProcess::MergedChannels);
                debuggerHandler.start (debuggingInterpreter, QStringList()
                                       << "-d" <<
                                       QDir::toNativeSeparators (debuggedScriptFilePath)
                                       << "-emacs",
                                       QProcess::Unbuffered | QProcess::ReadWrite);

                QByteArray debuggerCommand;
                debuggerCommand.append (debuggerQueryString.toLatin1());
                debuggerCommand.append (QString ("\n").toLatin1());
                debuggerHandler.write (debuggerCommand);

                if (debuggerQueryString == "M") {
                    debuggerCommandHumanReadable = "Show module versions (M)";
                }
                if (debuggerQueryString == "S") {
                    debuggerCommandHumanReadable = "List subroutine names (S)";
                }
                if (debuggerQueryString == "V") {
                    debuggerCommandHumanReadable = "List variables in package (V)";
                }
                if (debuggerQueryString == "X") {
                    debuggerCommandHumanReadable = "List variables in current package (X)";
                }

            }
        }

    }

    void debuggerOutputSlot()
    {
        QString debuggerOutput = debuggerHandler.readAllStandardOutput();

        // Remove SUB characters:
        static const QChar subChar[] = {0x001A};
        int size = sizeof (subChar) / sizeof (QChar);
        QString subStr = QString::fromRawData (subChar, size);
        debuggerOutput.replace (subStr, "");

        QRegExp debuggerOutputRegExp01 ("\\[\\d{1,2}\\w{1,3}|DB|\\<\\d{1,3}\\>|\e|[\x80-\x9f]|\x08|\r");
        debuggerOutputRegExp01.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp01, "");

        QRegExp debuggerOutputRegExp02 ("Editor support \\w{1,20}.");
        debuggerOutputRegExp02.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp02, "");

        QRegExp debuggerOutputRegExp03 ("Enter h .{40,80}\n");
        debuggerOutputRegExp03.setCaseSensitivity (Qt::CaseSensitive);
        debuggerOutput.replace (debuggerOutputRegExp03, "");

        QRegExp debuggerOutputRegExp04 (debuggedScriptFilePath+":\\d{1,5}:\\d{1,5}\n");
        debuggerOutputRegExp04.setCaseSensitivity (Qt::CaseSensitive);
        int outputRegExp04pos = debuggerOutputRegExp04.indexIn (debuggerOutput);
        Q_UNUSED (outputRegExp04pos);
        QString lineInfo = debuggerOutputRegExp04.capturedTexts().first();
        debuggerLineInfoLastLine = lineInfo.section (":", 1, 1);
        debuggerOutput.replace (debuggerOutputRegExp04, "");

        QRegExp debuggerOutputRegExp05 ("^\\s{0,}\n");
        debuggerOutput.replace (debuggerOutputRegExp05, "");

        debuggerOutput.replace ("\n", "<br>\n");

        debuggerAccumulatedOutput.append (debuggerOutput);

        QRegExp debuggerAccumulatedOutputRegExp01 ("\\s*\n");
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp01, "\n");

        QRegExp debuggerAccumulatedOutputRegExp02 ("\n\\s{4,}");
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp02, "\n");

        if (debuggerAccumulatedOutput.contains ("Show module versions")) {
            QRegExp debuggerAccumulatedOutputRegExp03 ("\n\\s{3,}");
            debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp03, "\n");
        }

        QRegExp debuggerAccumulatedOutputRegExp04 ("\n{2,}");
        debuggerAccumulatedOutput.replace (debuggerAccumulatedOutputRegExp04, "\n");

        if (debuggerQueryString != "V" and debuggerQueryString != "X") {
            debuggerAccumulatedOutput.replace ("  ", " ");
        }

        if (debuggerQueryString == "V") {
            debuggerAccumulatedOutput.replace ("  ", "&nbsp;&nbsp;");
        }

        if (debuggerQueryString == "X") {
            debuggerAccumulatedOutput.replace ("  ", "&nbsp;&nbsp;");
        }

        if (debuggerCommandHumanReadable.length() == 0) {
            debuggerCommandHumanReadable = debuggerQueryString;
        }

        if (sourceViewerForPerlDebuggerStarted == false) {
            QByteArray emptyPostDataArray;
            QUrl fileToDisplayAsSourceCode (QUrl::fromLocalFile (debuggedScriptFilePath));
            startScriptSlot (fileToDisplayAsSourceCode, emptyPostDataArray);
            sourceViewerForPerlDebuggerStarted = true;
        }

    }

    void displaySourceCodeAndDebuggerOutputSlot()
    {
        QFile htmlFile (
                    QDir::toNativeSeparators (settings.debuggerHtmlTemplate));
        htmlFile.open (QFile::ReadOnly | QFile::Text);
        QString debuggerHtmlOutput = QString (htmlFile.readAll());

        debuggerHtmlOutput.replace ("[% Script %]", debuggedScriptFilePath);
        debuggerHtmlOutput.replace ("[% Source %]",
                                    scriptOutputFilePath+"#"+debuggerLineInfoLastLine);
        debuggerHtmlOutput.replace ("[% Debugger Output %]", debuggerAccumulatedOutput);

        if (debuggerCommandHumanReadable.length() > 0) {
            debuggerHtmlOutput.replace ("[% Debugger Command %]",
                                        "Last command: "+debuggerCommandHumanReadable);
        } else {
            debuggerHtmlOutput.replace ("[% Debugger Command %]", "");
        }

        settings.cssLinker (debuggerHtmlOutput);
        debuggerHtmlOutput = settings.cssLinkedHtml;

        debuggerOutputFilePath = QDir::toNativeSeparators
                (QDir::tempPath()+QDir::separator()+"dbgoutput.htm");

        QFile debuggerOutputFile (debuggerOutputFilePath);
        if (debuggerOutputFile.open (QIODevice::ReadWrite)) {
            QTextStream debuggerOutputStream (&debuggerOutputFile);
            debuggerOutputStream << debuggerHtmlOutput << endl;
        }

        qDebug() << "Output from Perl debugger received.";
        qDebug() << "LineInfo last line:" << debuggerLineInfoLastLine;
        qDebug() << "Perl debugger output file:" << debuggerOutputFilePath;
        qDebug() << "===============";

        Page::currentFrame()->setUrl (QUrl::fromLocalFile (debuggerOutputFilePath));

//        newWindow->setUrl (QUrl::fromLocalFile (debuggerOutputFilePath));
//        newWindow->show();

        sourceViewerForPerlDebuggerStarted = false;
        debuggerOutputFile.remove();
    }

public:

    Page();

protected:

    bool acceptNavigationRequest (QWebFrame *frame,
                                  const QNetworkRequest &request,
                                  QWebPage::NavigationType type);

public:

    QString scriptFullFilePath;
    QProcess scriptHandler;

private:

    QString userAgentForUrl (const QUrl &url) const
    {
        Q_UNUSED (url);
        Settings settings;
        return settings.userAgent;
    }

    Settings settings;

    QWebView *newWindow;

    bool scriptTimedOut;
    bool scriptKilled;
    QUrl scriptLastUrl;
    QString scriptOutputFilePath;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
    bool scriptOutputThemeEnabled;
    QString scriptOutputType;
    bool scriptOutputScrollDown;

    QUrl debuggerLastUrl;
    QString debuggerQueryString;
    QString debuggedScriptFilePath;
    QString debuggingInterpreter;
    QProcess debuggerHandler;
    QString debuggerCommandHumanReadable;
    bool sourceViewerForPerlDebuggerStarted;
    QString debuggerLineInfoLastLine;
    QString debuggerAccumulatedOutput;
    QString debuggerOutputFilePath;

};


class TopLevel : public QWebView
{
    Q_OBJECT

signals:

    void selectThemeSignal();

    void trayIconHideSignal();

public slots:

    void loadStartPageSlot()
    {
        settings.defineInterpreter (settings.startPage);

        if (settings.interpreter.contains ("browser-html")) {
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

    void startPrintPreviewSlot()
    {
#ifndef QT_NO_PRINTER
        QPrinter printer (QPrinter::HighResolution);
        QPrintPreviewDialog preview (&printer, this);
        preview.setWindowModality (Qt::WindowModal);
        preview.setMinimumSize (QDesktopWidget().screen()->rect().width() * 0.8,
                                QDesktopWidget().screen()->rect().height() * 0.8);
        connect (&preview, SIGNAL (paintRequested (QPrinter *)),
                 SLOT (printPreviewSlot (QPrinter *)));
        preview.exec();
#endif
    }

    void printPreviewSlot (QPrinter *printer)
    {
#ifdef QT_NO_PRINTER
        Q_UNUSED (printer);
#else
        TopLevel::print (printer);
#endif
    }

    void printSlot()
    {
#ifndef QT_NO_PRINTER

        qDebug() << "Printing requested.";
        qDebug() << "===============";

        QPrinter printer;
        printer.setOrientation (QPrinter::Portrait);
        printer.setPageSize (QPrinter::A4);
        printer.setPageMargins (10, 10, 10, 10, QPrinter::Millimeter);
        printer.setResolution (QPrinter::HighResolution);
        printer.setColorMode (QPrinter::Color);
        printer.setPrintRange (QPrinter::AllPages);
        printer.setNumCopies (1);

        QPrintDialog *dialog = new QPrintDialog (&printer);
        dialog->setWindowModality (Qt::WindowModal);
        QSize dialogSize = dialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        dialog->move (QPoint (screenRect.width() / 2 - dialogSize.width() / 2,
                              screenRect.height() / 2 - dialogSize.height() / 2));
        if (dialog->exec() == QDialog::Accepted) {
            TopLevel::print (&printer);
        }
        dialog->close();
        dialog->deleteLater();
#endif
    }

    void saveAsPdfSlot()
    {
#ifndef QT_NO_PRINTER

        qDebug() << "Save as PDF requested.";

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (settings.icon);

        QString fileName = dialog.getSaveFileName
                (0, tr ("Save as PDF"),
                 QDir::currentPath(), tr ("PDF files (*.pdf)"));
        if (!fileName.isEmpty()) {
            if (QFileInfo (fileName).suffix().isEmpty()) {
                fileName.append(".pdf");
            }

            qDebug() << "PDF file:" << fileName;

            QPrinter printer;
            printer.setOrientation (QPrinter::Portrait);
            printer.setPageSize (QPrinter::A4);
            printer.setPageMargins (10, 10, 10, 10, QPrinter::Millimeter);
            printer.setResolution (QPrinter::HighResolution);
            printer.setColorMode (QPrinter::Color);
            printer.setPrintRange (QPrinter::AllPages);
            printer.setNumCopies (1);
            printer.setOutputFormat (QPrinter::PdfFormat);
            printer.setOutputFileName (fileName);
            TopLevel::print (&printer);
        }

        dialog.close();
        dialog.deleteLater();

        qDebug() << "===============";
#endif
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
                (settings.rootDirName+qWebHitTestURL.toString
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

        qDebug() << "Link to open in a new window:" << qWebHitTestURL.toString();
        qDebug() << "===============";

        QString fileToOpen = QDir::toNativeSeparators
                (settings.rootDirName+qWebHitTestURL.toString
                 (QUrl::RemoveScheme | QUrl::RemoveAuthority));

        settings.defineInterpreter (fileToOpen);

        if (settings.interpreter.contains ("browser-html")) {
            newWindow->setUrl (QUrl::fromLocalFile (fileToOpen));
        } else {
            newWindow->setUrl (qWebHitTestURL);
        }
        newWindow->show();
    }

    void displayErrorsSlot (QString errorsFilePath)
    {
        errorsWindow = new TopLevel (QString ("mainWindow"));
        QUrl aboutUrl = "file://"+errorsFilePath;
        errorsWindow->setWindowTitle ("Script Errors");
        errorsWindow->setUrl (aboutUrl);
        errorsWindow->setFocus();
        errorsWindow->show();
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

                QString fileToOpen = QDir::toNativeSeparators
                        (settings.rootDirName+qWebHitTestURL.toString
                         (QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery)
                         .replace ("?", ""));

                settings.defineInterpreter (fileToOpen);

                if ((!settings.interpreter.contains ("browser")) and
                        (!settings.interpreter.contains ("undefined"))) {
                    QAction *viewSourceAct = menu->addAction (tr ("&View Source"));
                    QObject::connect (viewSourceAct, SIGNAL (triggered()),
                                      this, SLOT (viewSourceFromContextMenuSlot()));
                }
            }

            if (QUrl (PEB_DOMAIN).isParentOf (qWebHitTestURL) or
                    qWebHitTestURL.toString().contains ("localhost")) {

                QAction *openInNewWindowAct = menu->addAction (tr ("&Open in new window"));
                QObject::connect (openInNewWindowAct, SIGNAL (triggered()),
                                  this, SLOT (openInNewWindowSlot()));
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

            if ((!TopLevel::url().toString().contains ("output"))) {
                QAction *reloadAct = menu->addAction (tr ("&Reload"));
                QObject::connect (reloadAct, SIGNAL (triggered()),
                                  this, SLOT (reloadSlot()));
            }

            QAction *printPreviewAct = menu->addAction (tr ("Print pre&view"));
            QObject::connect (printPreviewAct, SIGNAL (triggered()),
                              this, SLOT (startPrintPreviewSlot()));

            QAction *printAct = menu->addAction (tr ("&Print"));
            QObject::connect (printAct, SIGNAL (triggered()),
                              this, SLOT (printSlot()));

            QAction *saveAsPdfAct = menu->addAction (tr ("Save as P&DF"));
            QObject::connect (saveAsPdfAct, SIGNAL (triggered()),
                              this, SLOT (saveAsPdfSlot()));

            if ((!TopLevel::url().toString().contains ("output"))) {
                QAction *selectThemeAct = menu->addAction (tr ("&Select theme"));
                QObject::connect (selectThemeAct, SIGNAL (triggered()),
                                  this, SLOT (selectThemeFromContextMenuSlot()));
            }

            QAction *closeWindowAct = menu->addAction (tr ("&Close window"));
            QObject::connect (closeWindowAct, SIGNAL (triggered()),
                              this, SLOT (close()));

            QAction *quitAct = menu->addAction (tr ("&Quit"));
            QObject::connect ( quitAct, SIGNAL (triggered()),
                               this, SLOT (quitApplicationSlot()));

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

        // Initialize HTML message box:
        aboutDialog = new TopLevel (QString ("messageBox"));

        // Calculate message box dimensions,
        // center message box on screen:
        QRect screenRect = QDesktopWidget().screen()->rect();
        aboutDialog->setFixedSize (screenRect.width() * 0.6,
                                   screenRect.height() * 0.6);
        aboutDialog->move (QPoint(screenRect.width()/2 - aboutDialog->width()/2,
                              screenRect.height()/2 - aboutDialog->height()/2));

        // Output file name:
        QString outputFilePath = QDir::toNativeSeparators
                (QDir::tempPath()+QDir::separator()+"output.htm");
        QFile outputFile (outputFilePath);
        if (outputFile.exists()) {
            outputFile.remove();
        }

        // Initialize output variable:
        QString output;

        // Read template file, add browser vaiables and
        // append all of this to the output variable:
        QFile aboutFileTemplateFile (
                    QDir::toNativeSeparators (
                        settings.helpDirectory+QDir::separator()+"about.htm"));
        aboutFileTemplateFile.open(QFile::ReadOnly);
        QString aboutTemplateContents = QString (aboutFileTemplateFile.readAll());
        aboutTemplateContents.replace ("[% icon %]", settings.iconPathName);
        aboutTemplateContents.replace ("[% version %]", QApplication::applicationVersion());
        aboutTemplateContents.replace ("[% Qt Webkit version %]", qtVersion);
        aboutTemplateContents.replace ("[% Qt version %]", qtWebKitVersion);
        output.append (aboutTemplateContents);

        // Read CSS theme file and link its content to the output variable:
        settings.cssLinker (output);
        output = settings.cssLinkedHtml;

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

    void closeEvent (QCloseEvent *event)
    {
        if (mainPage->scriptHandler.isOpen()) {
            QMessageBox confirmExitMessageBox;
            confirmExitMessageBox.setWindowModality (Qt::WindowModal);
            confirmExitMessageBox.setWindowTitle (tr ("Close"));
            confirmExitMessageBox.setIconPixmap (settings.icon);
            confirmExitMessageBox.setText (tr ("You are going to close the window,<br>")+
                                           tr ("but a long-running script is still running:<br>")+
                                           mainPage->scriptFullFilePath+"<br>"+
                                           tr ("If you close the window, the script will be stopped.<br>")+
                                           tr ("Are you sure?"));
            confirmExitMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
            confirmExitMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
            confirmExitMessageBox.setButtonText (QMessageBox::No, tr ("No"));
            confirmExitMessageBox.setDefaultButton (QMessageBox::No);
            if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                mainPage->scriptHandler.close();
                event->accept();
            } else {
                event->ignore();
            }
        } else {
            event->accept();
        }
    }

    void quitApplicationSlot()
    {
        if (startedScripts.length () > 0) {
            QMessageBox confirmExitMessageBox;
            confirmExitMessageBox.setWindowModality (Qt::WindowModal);
            confirmExitMessageBox.setWindowTitle (tr ("Quit"));
            confirmExitMessageBox.setIconPixmap (settings.icon);
            confirmExitMessageBox.setText (tr ("You are going to quit the program,<br>")+
                                           tr ("but at least one long-running script is still running.<br>")+
                                           tr ("Are you sure?"));
            confirmExitMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
            confirmExitMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
            confirmExitMessageBox.setButtonText (QMessageBox::No, tr ("No"));
            confirmExitMessageBox.setDefaultButton (QMessageBox::No);
            if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                QFile::remove
                        (QDir::toNativeSeparators
                         (QDir::tempPath()+QDir::separator()+"output.htm"));
                QApplication::exit();
            }
        } else {
            QFile::remove
                    (QDir::toNativeSeparators
                     (QDir::tempPath()+QDir::separator()+"output.htm"));
            QApplication::exit();
        }

        if (settings.systrayIcon == "enable") {
            emit trayIconHideSignal();
        }

        QString dateTimeString = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");
        qDebug() << qApp->applicationName().toLatin1().constData()
                 << qApp->applicationVersion().toLatin1().constData()
                 << "terminated normally on:" << dateTimeString;
        qDebug() << "===============";
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

    QWebView *createWindow (QWebPage::WebWindowType type)
    {
        Q_UNUSED (type);
        QWebView *window = new TopLevel (QString ("mainWindow"));
        window->setWindowIcon (settings.icon);
        window->setAttribute (Qt::WA_DeleteOnClose, true);
        window->show();
        return window;
    }

private:

    Page *mainPage;

    Settings settings;

    QUrl qWebHitTestURL;
    QString filepath;
    QWebView *newWindow;

    QWebView *aboutDialog;
    QWebView *errorsWindow;

};

#endif // PEB_H
