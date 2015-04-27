/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2015, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014 - 2015
*/

#ifndef PEB_H
#define PEB_H

#include <QApplication>
#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QtWebKit>
#include <QtNetwork/QNetworkAccessManager>
#include <QProcess>
#include <QSpacerItem>
#include <QGridLayout>
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


// Global variable:
extern QStringList startedScripts;


class FileDetector : public QObject
{
    Q_OBJECT

public slots:

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
                interpreter = (qApp->property ("perlInterpreter").toString());
            }
        } else {
            if (extension.contains (htmlExtensions)) {
                interpreter = "browser-html";
            }
            if (extension.contains (cssExtension)) {
                interpreter = "browser-css";
            }
            if (extension.contains (jsExtension)) {
                interpreter = "browser-js";
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
                interpreter = (qApp->property ("perlInterpreter").toString());
            }
        }
    }

public:

    FileDetector();

    QString extension;
    QString interpreter;

private:

    // Regular expressions for file type detection by shebang line:
    QRegExp perlShebang;

    // Regular expressions for file type detection by extension:
    QRegExp htmlExtensions;
    QRegExp cssExtension;
    QRegExp jsExtension;
    QRegExp pngExtension;
    QRegExp jpgExtensions;
    QRegExp gifExtension;

    QRegExp plExtension;

};


class TrayIcon : public QSystemTrayIcon
{

    Q_OBJECT

public slots:

    void trayIconActivatedSlot (QSystemTrayIcon::ActivationReason reason)
    {
        if (reason == QSystemTrayIcon::DoubleClick) {

            if ((qApp->property ("systrayIconDoubleClickAction").toString()) == "quit") {
                QMessageBox confirmExitMessageBox;
                confirmExitMessageBox.setWindowModality (Qt::WindowModal);
                confirmExitMessageBox.setWindowTitle (tr ("Quit"));
                confirmExitMessageBox.setIconPixmap ((qApp->property ("icon").toString()));
                confirmExitMessageBox.setText (tr ("You are going to quit the program.<br>Are you sure?"));
                confirmExitMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
                confirmExitMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
                confirmExitMessageBox.setButtonText (QMessageBox::No, tr ("No"));
                confirmExitMessageBox.setDefaultButton (QMessageBox::No);
                if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                    QApplication::quit();
                }
            }

            if ((qApp->property ("systrayIconDoubleClickAction").toString()) == "minimize_all_windows") {
                foreach (QWidget* window, QApplication::topLevelWidgets()) {
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

    QAction* quitAction;
    QAction* aboutAction;
    QAction* aboutQtAction;

private:

    QSystemTrayIcon* trayIcon;
    QMenu* trayIconMenu;

};


class ModifiedNetworkAccessManager : public QNetworkAccessManager
{

    Q_OBJECT

signals:

    void startScriptSignal (QUrl url, QByteArray postDataArray);

    void startPerlDebuggerSignal (QUrl debuggerUrl);

protected:

    virtual QNetworkReply* createRequest (Operation operation,
                                          const QNetworkRequest &request,
                                          QIODevice* outgoingData = 0)
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
                    ((qApp->property ("rootDirName").toString())+
                     filepath);

            FileDetector detector;
            detector.defineInterpreter (fullFilePath);

            // Local HTML, CSS, JS or supported image files:
            if (detector.interpreter.contains ("browser")) {

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (QDir::toNativeSeparators (
                              (qApp->property ("rootDirName").toString())+
                              request.url().toString (
                                  QUrl::RemoveScheme | QUrl::RemoveAuthority))));

                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest (networkRequest));
            }

            // Local Perl scripts:
            if ((!detector.interpreter.contains ("undefined")) and
                    (!detector.interpreter.contains ("browser"))) {

                QByteArray emptyPostDataArray;
                emit startScriptSignal (request.url(), emptyPostDataArray);
            }

            // Local files without recognized file type:
            if (detector.interpreter.contains ("undefined")) {

                qDebug() << "File type not recognized!";
                qDebug() << "===============";

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         ((qApp->property ("helpDirectory").toString())+
                          QDir::separator()+
                          "notrecognized.htm"));

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

        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Perl debugger interaction.
            // Implementation of an idea proposed by Valcho Nedelchev.
            // Transmit requests to Perl debugger in case debugger is started in a new window:
            if (operation == GetOperation and
                    request.url().scheme().contains ("file") and
                    request.url().hasQuery()) {

                emit startPerlDebuggerSignal (request.url());

            }
        }

        // GET, POST and PUT requests to network resources.
        // Domain filtering happens here:
        if ((operation == GetOperation or
             operation == PostOperation or
             operation == PutOperation) and
                ((request.url().scheme().contains ("file")) or
                 (request.url().toString().contains (PEB_DOMAIN)) or
                 ((qApp->property ("allowedDomainsList").toStringList())
                  .contains (request.url().authority())))) {

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
                     ((qApp->property ("helpDirectory").toString())+
                      QDir::separator()+
                      "forbidden.htm"));

            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest (networkRequest));
        }

        return QNetworkAccessManager::createRequest (operation, request);
    }

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

    void cssLinker (QString htmlInput)
    {
        cssLinkedHtml = "";

        if ((htmlInput.contains ("</title>")) and
                (!htmlInput.contains ("current.css"))) {
            QString cssLink;

            cssLink.append ("</title>\n");
            cssLink.append ("<link rel=\"stylesheet\" type=\"text/css\"");
            cssLink.append ("href=\"http://perl-executing-browser-pseudodomain/html/current.css\" media=\"all\" />");
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

    void setThemeSlot (QString theme)
    {
        theme.prepend ((qApp->property ("allThemesDirectory").toString())+QDir::separator());
        theme.append (".theme");

        if (theme.length() > 0) {
            if (QFile::exists (
                        QDir::toNativeSeparators (
                            (qApp->property ("defaultThemeDirectory").toString())+
                            QDir::separator()+"current.css"))) {
                QFile::remove (
                            QDir::toNativeSeparators (
                                (qApp->property ("defaultThemeDirectory").toString())+
                                QDir::separator()+"current.css"));
            }
            QFile::copy (theme,
                         QDir::toNativeSeparators (
                             (qApp->property ("defaultThemeDirectory").toString())+
                             QDir::separator()+"current.css"));

            emit reloadSignal();

            qDebug() << "Selected new theme:" << theme;
            qDebug() << "===============";
        } else {
            qDebug() << "No new theme selected.";
            qDebug() << "===============";
        }
    }

    void selectThemeSlot()
    {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (icon);
        QString newTheme = dialog.getOpenFileName
                (0, tr ("Select Browser Theme"),
                 (qApp->property ("allThemesDirectory").toString()),
                 tr ("Browser theme (*.theme)"));
        dialog.close();
        dialog.deleteLater();
        if (newTheme.length() > 0) {
            if (QFile::exists (
                        QDir::toNativeSeparators (
                            (qApp->property ("defaultThemeDirectory").toString())+
                            QDir::separator()+"current.css"))) {
                QFile::remove (
                            QDir::toNativeSeparators (
                                (qApp->property ("defaultThemeDirectory").toString())+
                                QDir::separator()+"current.css"));
            }
            QFile::copy (newTheme,
                         QDir::toNativeSeparators (
                             (qApp->property ("defaultThemeDirectory").toString())+
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
        qDebug() << "Script URL:" << url.toString();

        QString relativeFilePath = url.toString (QUrl::RemoveScheme
                                                 | QUrl::RemoveAuthority
                                                 | QUrl::RemoveQuery);
        scriptFullFilePath = QDir::toNativeSeparators
                ((qApp->property ("rootDirName").toString())+
                 relativeFilePath);

        QString queryString = url.toString (QUrl::RemoveScheme
                                            | QUrl::RemoveAuthority
                                            | QUrl::RemovePath)
                .replace ("?", "")
                .replace ("//", "");

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
                msgBox.setIconPixmap ((qApp->property ("icon").toString()));
                msgBox.setText (tr ("This script is terminated as requested:<br>")+
                                scriptFullFilePath);
                msgBox.setDefaultButton (QMessageBox::Ok);
                msgBox.exec();
            } else {
                scriptKilled = true;

                QMessageBox msgBox;
                msgBox.setWindowModality (Qt::WindowModal);
                msgBox.setWindowTitle (tr ("Script Finished"));
                msgBox.setIconPixmap ((qApp->property ("icon").toString()));
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

            FileDetector detector;
            detector.defineInterpreter (scriptFullFilePath);

            qDebug() << "File path:" << scriptFullFilePath;
            qDebug() << "Extension:" << detector.extension;
            qDebug() << "Interpreter:" << detector.interpreter;

            if (queryString.length() > 0) {
                scriptEnvironment.insert ("REQUEST_METHOD", "GET");
                scriptEnvironment.insert ("QUERY_STRING", queryString);
                qDebug() << "Query string:" << queryString;
            }

            if (postData.length() > 0) {
                scriptEnvironment.insert ("REQUEST_METHOD", "POST");
                QString postDataSize = QString::number (postData.size());
                scriptEnvironment.insert ("CONTENT_LENGTH", postDataSize);
                qDebug() << "POST data:" << postData;
            }

            scriptHandler.setProcessEnvironment (scriptEnvironment);

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
                    sourceViewerCommandLine = sourceViewerMandatoryCommandLine;
                    sourceViewerCommandLine.append (sourceFilepath);

                    scriptHandler.start ((qApp->property ("perlInterpreter").toString()),
                                         sourceViewerCommandLine,
                                         QProcess::Unbuffered | QProcess::ReadWrite);

                    startedScripts.append (sourceFilepath);
                } else {

                    if (SCRIPT_CENSORING == 0) {
                        scriptHandler.start ((qApp->property ("perlInterpreter").toString()),
                                             QStringList() <<
                                             QDir::toNativeSeparators
                                             (scriptFullFilePath),
                                             QProcess::Unbuffered | QProcess::ReadWrite);
                    }

                    if (SCRIPT_CENSORING == 1) {
                        QString censorScriptFileName (QDir::toNativeSeparators (
                                                          (qApp->property ("rootDirName").toString())+
                                                          "perl/censor.pl"));
                        QFile censorScriptFile (censorScriptFileName);
                        censorScriptFile.open (QIODevice::ReadOnly | QIODevice::Text);
                        QTextStream stream (&censorScriptFile);
                        QString censorScriptContents = stream.readAll();
                        censorScriptFile.close();

                        scriptHandler.start ((qApp->property ("perlInterpreter").toString()),
                                             QStringList()
                                             << "-se"
                                             << censorScriptContents
                                             << "--"
                                             << QDir::toNativeSeparators (scriptFullFilePath),
                                             QProcess::Unbuffered | QProcess::ReadWrite);
                    }

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
                msgBox.setIconPixmap ((qApp->property ("icon").toString()));
                msgBox.setText (tr ("This script is already started and still running:<br>")+
                                scriptFullFilePath);
                msgBox.setDefaultButton (QMessageBox::Ok);
                msgBox.exec();
            }

            scriptTimedOut = false;

            if (!scriptFullFilePath.contains ("longrun")) {
                int scriptTimeoutNumeric =
                        (qApp->property ("scriptTimeout").toInt());
                int maximumTimeMilliseconds = scriptTimeoutNumeric * 1000 ;
                QTimer::singleShot (maximumTimeMilliseconds, this, SLOT (scriptTimeoutSlot()));
            }

            QWebSettings::clearMemoryCaches();

            scriptEnvironment.remove ("FILE_TO_OPEN");
            scriptEnvironment.remove ("FILE_TO_CREATE");
            scriptEnvironment.remove ("FOLDER_TO_OPEN");
            scriptEnvironment.remove ("REQUEST_METHOD");

            if (queryString.length() > 0) {
                scriptEnvironment.remove ("QUERY_STRING");
            }

            if (postData.length() > 0) {
                scriptEnvironment.remove ("CONTENT_LENGTH");
            }

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
                    ((qApp->property ("applicationOutputDirectory").toString())+
                     QDir::separator()+"output.htm");
        } else {
            scriptOutputFilePath = QDir::toNativeSeparators
                    ((qApp->property ("applicationOutputDirectory").toString())+
                     QDir::separator()+"lroutput.htm");
        }

        QFile scriptOutputFile (scriptOutputFilePath);

        // Delete previous output file:
        if (scriptOutputFile.exists()) {
            scriptOutputFile.remove();
        }

        // Latest output:
        if (scriptOutputType == "latest") {

            httpHeaderCleaner (output);
            output = httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                cssLinker (output);
                output = cssLinkedHtml;
            }

            if (scriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&scriptOutputFile);
                stream << output << endl;
            }
        }

        // Accumulated output:
        if (scriptOutputType == "accumulation" or
                scriptOutputType == "final") {

            httpHeaderCleaner (scriptAccumulatedOutput);
            scriptAccumulatedOutput = httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                cssLinker (scriptAccumulatedOutput);
                scriptAccumulatedOutput = cssLinkedHtml;
            }

            if (scriptOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&scriptOutputFile);
                stream << scriptAccumulatedOutput << endl;
            }
        }

        qDebug() << "Output from script received.";
        qDebug() << "Script output file:" << scriptOutputFilePath;
        qDebug() << "===============";

        if (!Page::mainFrame()->childFrames().contains (targetFrame)) {
            targetFrame = Page::currentFrame();
        }

        if (scriptOutputType == "latest") {
            targetFrame->setUrl (QUrl::fromLocalFile (scriptOutputFilePath));
        }
        if (scriptOutputType == "accumulation") {
            if (scriptOutputScrollDown == false) {
                targetFrame->setUrl (QUrl::fromLocalFile (scriptOutputFilePath));
            }
            if (scriptOutputScrollDown == true) {
                targetFrame->setUrl (scriptOutputFilePath+"#latest");
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
        if (!Page::mainFrame()->childFrames().contains (targetFrame)) {
            targetFrame = Page::currentFrame();
        }

        if (scriptTimedOut == false) {
            if (scriptOutputType == "final") {
                targetFrame->setUrl (QUrl::fromLocalFile (scriptOutputFilePath));
            }

            if ((qApp->property ("displayStderr").toString()) == "enable") {
                if (scriptAccumulatedErrors.length() > 0 and
                        scriptKilled == false) {

                    cssLinker (scriptAccumulatedErrors);
                    scriptAccumulatedErrors = cssLinkedHtml;

                    QString scriptErrorFilePath = QDir::toNativeSeparators
                            (QDir::tempPath()+QDir::separator()+"stderr.htm");

                    QFile scriptErrorFile (scriptErrorFilePath);
                    if (scriptErrorFile.open (QIODevice::ReadWrite)) {
                        QTextStream stream (&scriptErrorFile);
                        stream << scriptAccumulatedErrors << endl;

                        if (scriptAccumulatedOutput.length() == 0) {
                            targetFrame->setUrl (QUrl::fromLocalFile (scriptErrorFilePath));
                            scriptErrorFile.remove();
                        } else {
                            QMessageBox showErrorsMessageBox;
                            showErrorsMessageBox.setWindowModality (Qt::WindowModal);
                            showErrorsMessageBox.setWindowTitle (tr ("Errors"));
                            showErrorsMessageBox.setIconPixmap ((qApp->property ("icon").toString()));
                            showErrorsMessageBox.setText (tr ("Errors were found during script execution.<br>")+
                                                          tr ("Do you want to see them?"));
                            showErrorsMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
                            showErrorsMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
                            showErrorsMessageBox.setButtonText (QMessageBox::No, tr ("No"));
                            showErrorsMessageBox.setDefaultButton (QMessageBox::Yes);

                            if (showErrorsMessageBox.exec() == QMessageBox::Yes) {
                                emit displayErrorsSignal (scriptErrorFilePath);
                            }
                        }
                    }
                }
            }

            scriptHandler.close();

            qDebug() << "Script finished:" << scriptFullFilePath;
            qDebug() << "===============";
        }

        startedScripts.removeOne (scriptFullFilePath);

        scriptAccumulatedOutput = "";
        scriptAccumulatedErrors = "";

        QFile scriptOutputFile (scriptOutputFilePath);
        scriptOutputFile.remove();
    }

    void scriptTimeoutSlot ()
    {
        if (scriptHandler.isOpen() and
                scriptAccumulatedErrors.length() == 0) {

            scriptTimedOut = true;
            scriptHandler.close();

            startedScripts.removeOne (scriptFullFilePath);

            qDebug() << "Script timed out:" << scriptFullFilePath;
            qDebug() << "===============";

            QMessageBox msgBox;
            msgBox.setWindowModality (Qt::WindowModal);
            msgBox.setWindowTitle (tr ("Script Timeout"));
            msgBox.setIconPixmap ((qApp->property ("icon").toString()));
            msgBox.setText (tr ("Your script timed out!<br>")+
                            tr ("Consider starting it as a long-running script."));
            msgBox.setDefaultButton (QMessageBox::Ok);
            msgBox.exec();
        }
    }

    // Perl debugger interaction.
    // Implementation of an idea proposed by Valcho Nedelchev.
    void startPerlDebuggerSlot (QUrl debuggerUrl)
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            QString filePath = debuggerUrl.toString (QUrl::RemoveQuery)
                    .replace ("file://", "")
                    .replace ("?", "");

#ifdef Q_OS_WIN
            filePath.replace (QRegExp ("^\\/"), "");
#endif

            if ((!filePath.contains ("select-file")) and (!filePath.contains ("execute"))) {
                debuggerScriptToDebugFilePath = filePath;
            }

            debuggerQueryString = debuggerUrl.toString (QUrl::RemoveScheme
                                                        | QUrl::RemoveAuthority
                                                        | QUrl::RemovePath)
                    .replace ("?", "")
                    .replace ("command=", "")
                    .replace ("+", " ")
                    .replace ("/", "");

            qDebug() << "File passed to Perl debugger:"
                     << QDir::toNativeSeparators (debuggerScriptToDebugFilePath);

            // Perl interpreter to be used for debugging:
            QString debuggerInterpreter = (qApp->property ("perlInterpreter").toString());
            qDebug() << "Interpreter:" << debuggerInterpreter;

            // Clean accumulated debugger output from previous debugger session:
            debuggerAccumulatedOutput = "";

            // Clean debugger output file from previous debugger session:
            QFile debuggerOutputFile (debuggerOutputFilePath);
            if (debuggerOutputFile.exists())
                debuggerOutputFile.remove();

            // Start a new debugger session with a new file to debug:
            if (debuggerUrl.path().contains ("select-file")) {
                debuggerHandler.close();
            }

            if (debuggerHandler.isOpen()) {
                QByteArray debuggerCommand;
                debuggerCommand.append (debuggerQueryString.toLatin1());
                debuggerCommand.append (QString ("\n").toLatin1());
                debuggerHandler.write (debuggerCommand);
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

                env.insert ("PERLDB_OPTS", "ReadLine=0");

                debuggerHandler.setProcessEnvironment (env);

                QFileInfo scriptAbsoluteFilePath (debuggerScriptToDebugFilePath);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                debuggerHandler.setWorkingDirectory (scriptDirectory);
                qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

                qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
                qDebug() << "===============";

                debuggerHandler.setProcessChannelMode (QProcess::MergedChannels);
                debuggerHandler.start (debuggerInterpreter, QStringList()
                                       << "-d" <<
                                       QDir::toNativeSeparators (debuggerScriptToDebugFilePath),
                                       QProcess::Unbuffered | QProcess::ReadWrite);

                QByteArray debuggerCommand;
                debuggerCommand.append (debuggerQueryString.toLatin1());
                debuggerCommand.append (QString ("\n").toLatin1());
                debuggerHandler.write (debuggerCommand);
            }
        }
    }

    void debuggerOutputSlot()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Read debugger output:
            QString debuggerOutput = debuggerHandler.readAllStandardOutput();

            // Replace backtick with single quote:
            debuggerOutput.replace ("`", "'");

            // Remove "Editor support available."
            QRegExp debuggerOutputRegExp01 ("Editor support \\w{1,20}.");
            debuggerOutputRegExp01.setCaseSensitivity (Qt::CaseSensitive);
            debuggerOutput.replace (debuggerOutputRegExp01, "");

            // Remove debugger prompt: "DB<line_number>"
            QRegExp debuggerOutputRegExp02 ("DB\\<\\d{1,5}\\>");
            debuggerOutputRegExp02.setCaseSensitivity (Qt::CaseSensitive);
            debuggerOutput.replace (debuggerOutputRegExp02, "");

            // Remove initial empty line:
            QRegExp debuggerOutputRegExp03 ("^\\s{0,}\n");
            debuggerOutput.replace (debuggerOutputRegExp03, "");

            // Replace two or more empty lines with a single empty line:
            QRegExp debuggerOutputRegExp04 ("\n{3,}");
            debuggerOutput.replace (debuggerOutputRegExp04, "\n\n");

            // Capture the name of the file, which has to be highlighted,
            // and take the value of LineInfoLastLine variable:
            QRegExp debuggerOutputRegExp05 ("\\(.*:{1,}[1-9]{0,}\\)");
            debuggerOutputRegExp05.indexIn (debuggerOutput);
            QString lineInfo = debuggerOutputRegExp05.capturedTexts().first();
            if (lineInfo.length() > 0) {
                if (lineInfo.contains ("[")) {
                    QStringList debuggerLineInfoEvalList = lineInfo.split ("[");
                    QString actualLineInfo = debuggerLineInfoEvalList[1];
                    QStringList debuggerLineInfoList = actualLineInfo.split (":");
#ifdef Q_OS_WIN
                    debuggerSourceToHighlightFilePath = "";
                    debuggerSourceToHighlightFilePath.append (debuggerLineInfoList[0]);
                    debuggerSourceToHighlightFilePath.append (debuggerLineInfoList[1]);
                    debuggerLineInfoLastLine = debuggerLineInfoList[2];
#else
                    debuggerSourceToHighlightFilePath = debuggerLineInfoList[0];
                    debuggerLineInfoLastLine = debuggerLineInfoList[1];
#endif
                    debuggerLineInfoLastLine.replace ("]", "");
                } else {
                    QStringList debuggerLineInfoList = lineInfo.split (":");

#ifdef Q_OS_WIN
                    debuggerSourceToHighlightFilePath = "";
                    debuggerSourceToHighlightFilePath.append (debuggerLineInfoList[0]);
                    debuggerSourceToHighlightFilePath.append (":");
                    debuggerSourceToHighlightFilePath.append (debuggerLineInfoList[1]);
                    debuggerLineInfoLastLine = debuggerLineInfoList[2];
#else
                    debuggerSourceToHighlightFilePath = debuggerLineInfoList[0];
                    debuggerLineInfoLastLine = debuggerLineInfoList[1];
#endif
                    debuggerSourceToHighlightFilePath.replace ("(", "");
                    debuggerLineInfoLastLine.replace (")", "");
                }
            }

            // Make HTML-compatible line endings:
            debuggerOutput.replace ("\n", "<br>\n");

            // Append last output from the debugger to the accumulated debugger output:
            debuggerAccumulatedOutput.append (debuggerOutput);

            // Preserve extra spacing within the output from
            // "List variables in package" and "List variables in current package" commands:
            if (debuggerQueryString == "V") {
                debuggerAccumulatedOutput.replace ("  ", "&nbsp;&nbsp;");
            }
            if (debuggerQueryString == "X") {
                debuggerAccumulatedOutput.replace ("  ", "&nbsp;&nbsp;");
            }

            // Start highlighting the necessary source code:
            if (!debuggerSyntaxHighlighter.isOpen()) {
                qDebug() << "Source viewer for the Perl debugger started.";
                qDebug() << "File to display:" << debuggerScriptToDebugFilePath;

                debuggerSyntaxHighlighter.setProcessEnvironment (scriptEnvironment);

                if (debuggerSourceToHighlightFilePath.length() > 0) {
                    QStringList sourceViewerCommandLine;
                    sourceViewerCommandLine = sourceViewerMandatoryCommandLine;
                    sourceViewerCommandLine.append (QDir::toNativeSeparators (
                                                        debuggerSourceToHighlightFilePath));
                    sourceViewerCommandLine.append (debuggerLineInfoLastLine);

                    debuggerSyntaxHighlighter.start ((qApp->property ("perlInterpreter").toString()),
                                                     sourceViewerCommandLine,
                                                     QProcess::Unbuffered | QProcess::ReadWrite);
                }
            }
        }
    }

    void debuggerSyntaxHighlighterReadySlot()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Read all output from the syntax highlighter script:
            QString output = debuggerSyntaxHighlighter.readAllStandardOutput();

            debuggerSyntaxHighlighter.close();

            // Syntax highlighted source code file path:
            debuggerHighlighterOutputFilePath = (qApp->property ("applicationOutputDirectory").toString())+
                    QDir::separator()+"source.htm";
            QFile sourceOutputFile (debuggerHighlighterOutputFilePath);

            // Delete previous highlighted source HTML file:
            if (sourceOutputFile.exists()) {
                sourceOutputFile.remove();
            }

            // Save highlighted source as a new HTML file:
            if (sourceOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream stream (&sourceOutputFile);
                stream << output << endl;
            }

            qDebug() << "Syntax highlighted source file:"
                     << debuggerHighlighterOutputFilePath;
            qDebug() << "===============";

            // Close syntax highlighter process:
            debuggerSyntaxHighlighter.close();

            emit sourceCodeForDebuggerReadySignal();
        }
    }

    void displaySourceCodeAndDebuggerOutputSlot()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            QFile debuggerHtmlTemplateFile (
                        QDir::toNativeSeparators (
                            (qApp->property ("debuggerHtmlTemplate").toString())));
            debuggerHtmlTemplateFile.open (QFile::ReadOnly | QFile::Text);
            QString debuggerHtmlOutput = QString (debuggerHtmlTemplateFile.readAll());
            debuggerHtmlTemplateFile.close();

            debuggerHtmlOutput.replace ("[% Script %]", debuggerScriptToDebugFilePath);

            int debuggerHighlightedSourceScrollToLineInt;
            if (debuggerLineInfoLastLine.toInt() > 5) {
                debuggerHighlightedSourceScrollToLineInt = debuggerLineInfoLastLine.toInt() - 5;
            } else {
                debuggerHighlightedSourceScrollToLineInt = 1;
            }
            QString debuggerHighlightedSourceScrollToLine =
                    QString::number (debuggerHighlightedSourceScrollToLineInt);
            debuggerHtmlOutput.replace ("[% Source %]",
                                        "source.htm#"
                                        +debuggerHighlightedSourceScrollToLine);

            debuggerHtmlOutput.replace ("[% Debugger Output %]", debuggerAccumulatedOutput);

            if (debuggerQueryString.length() > 0) {
                debuggerHtmlOutput.replace ("[% Debugger Command %]",
                                            "Last command: "+debuggerQueryString);
            } else {
                debuggerHtmlOutput.replace ("[% Debugger Command %]", "");
            }

            cssLinker (debuggerHtmlOutput);
            debuggerHtmlOutput = cssLinkedHtml;

            debuggerOutputFilePath = QDir::toNativeSeparators
                    ((qApp->property ("applicationOutputDirectory").toString())+
                     QDir::separator()+"dbgoutput.htm");

            QFile debuggerOutputFile (debuggerOutputFilePath);
            if (debuggerOutputFile.open (QIODevice::ReadWrite)) {
                QTextStream debuggerOutputStream (&debuggerOutputFile);
                debuggerOutputStream << debuggerHtmlOutput << endl;
            }

            qDebug() << "Output from Perl debugger received.";
            qDebug() << "LineInfo last line:" << debuggerLineInfoLastLine;
            qDebug() << "Perl debugger output file:" << debuggerOutputFilePath;
            qDebug() << "===============";

            targetFrame->setUrl (QUrl::fromLocalFile (debuggerOutputFilePath));

            //debuggerOutputFile.remove();
        }
    }

public:

    Page();
    QString scriptFullFilePath;
    QProcess scriptHandler;

protected:

    bool acceptNavigationRequest (QWebFrame* frame,
                                  const QNetworkRequest &request,
                                  QWebPage::NavigationType type);

private:

    QString userAgentForUrl (const QUrl &url) const
    {
        Q_UNUSED (url);
        return (qApp->property ("userAgent").toString());
    }

    QWebView* newWindow;
    QWebFrame* targetFrame;

    QString cssLinkedHtml;
    QString httpHeadersCleanedHtml;

    QStringList allowedEnvironmentVariables;
    QStringList sourceViewerMandatoryCommandLine;

    QProcessEnvironment scriptEnvironment;
    bool scriptTimedOut;
    bool scriptKilled;
    QString scriptOutputFilePath;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
    bool scriptOutputThemeEnabled;
    QString scriptOutputType;
    bool scriptOutputScrollDown;

    QWebView* debuggerNewWindow;
    QString debuggerScriptUrl;
    QString debuggerScriptToDebugFilePath;
    QString debuggerQueryString;
    QProcess debuggerHandler;
    QString debuggerLineInfoLastLine;
    QString debuggerAccumulatedOutput;
    QString debuggerOutputFilePath;
    QProcess debuggerSyntaxHighlighter;
    QString debuggerSourceToHighlightFilePath;
    QString debuggerHighlighterOutputFilePath;

    QPixmap icon;

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
        FileDetector detector;
        detector.defineInterpreter ((qApp->property ("startPage").toString()));

        if (detector.interpreter.contains ("browser-html")) {
            setUrl (QUrl::fromLocalFile
                    (QDir::toNativeSeparators
                     ((qApp->property ("startPage").toString()))));
        } else {
            setUrl (QUrl (QString (PEB_DOMAIN+
                                   (qApp->property ("startPagePath").toString()))));
        }
    }

    void pageLoadedDynamicTitleSlot (bool ok)
    {
        if (ok) {
            setWindowTitle (TopLevel::title());
            QFile::remove
                    (QDir::toNativeSeparators
                     ((qApp->property ("applicationOutputDirectory").toString())
                      +QDir::separator()+"output.htm"));
        }
    }

    void pageLoadedStaticTitleSlot (bool ok)
    {
        if (ok) {
            QFile::remove
                    (QDir::toNativeSeparators
                     ((qApp->property ("applicationOutputDirectory").toString())+
                      QDir::separator()+"output.htm"));
        }
    }

    void startPrintPreviewSlot()
    {
#ifndef QT_NO_PRINTER
        QPrinter printer (QPrinter::HighResolution);
        QPrintPreviewDialog preview (&printer, this);
        preview.setWindowModality (Qt::WindowModal);
        preview.setMinimumSize (QDesktopWidget().screen()->rect().width()*  0.8,
                                QDesktopWidget().screen()->rect().height()*  0.8);
        connect (&preview, SIGNAL (paintRequested (QPrinter* )),
                 SLOT (printPreviewSlot (QPrinter* )));
        preview.exec();
#endif
    }

    void printPreviewSlot (QPrinter* printer)
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

        QPrintDialog* dialog = new QPrintDialog (&printer);
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
        dialog.setWindowIcon (icon);
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
                ((qApp->property ("rootDirName").toString())+
                 qWebHitTestURL.toString
                 (QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery)
                 .replace ("?", ""));

        qDebug() << "File to edit:" << fileToEdit;
        qDebug() << "===============";

        QProcess externalProcess;
        externalProcess.startDetached ("/usr/bin/scite", QStringList() << fileToEdit);
    }

    void viewSourceFromContextMenuSlot()
    {
        newWindow = new TopLevel ();
        QString iconPathName = qApp->property ("iconPathName").toString();
        QPixmap icon;
        icon.load (iconPathName);
        newWindow->setWindowIcon (icon);

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
        newWindow = new TopLevel ();
        QString iconPathName = qApp->property ("iconPathName").toString();
        QPixmap icon;
        icon.load (iconPathName);
        newWindow->setWindowIcon (icon);

        qDebug() << "Link to open in a new window:" << qWebHitTestURL.toString();
        qDebug() << "===============";

        QString fileToOpen = QDir::toNativeSeparators
                ((qApp->property ("rootDirName").toString())+
                 qWebHitTestURL.toString
                 (QUrl::RemoveScheme | QUrl::RemoveAuthority));

        FileDetector detector;
        detector.defineInterpreter (fileToOpen);

        if (detector.interpreter.contains ("browser-html")) {
            newWindow->setUrl (QUrl::fromLocalFile (fileToOpen));
        } else {
            newWindow->setUrl (qWebHitTestURL);
        }
        newWindow->show();
    }

    void displayErrorsSlot (QString errorsFilePath)
    {
        errorsWindow = new TopLevel ();
        QUrl errorsFileUrl = "file://"+errorsFilePath;
        errorsWindow->setUrl (errorsFileUrl);
        errorsWindow->setFocus();
        errorsWindow->show();

        QFile scriptErrorsFile (errorsFilePath);
        scriptErrorsFile.remove();
    }

    void contextMenuEvent (QContextMenuEvent* event)
    {
        QWebHitTestResult qWebHitTestResult =
                mainPage->mainFrame()->hitTestContent (event->pos());

        QMenu* menu = mainPage->createStandardContextMenu();

        if (!qWebHitTestResult.linkUrl().isEmpty()) {
            qWebHitTestURL = qWebHitTestResult.linkUrl();

            if (QUrl (PEB_DOMAIN).isParentOf (qWebHitTestURL)) {

                menu->addSeparator ();

                QAction* editAct = menu->addAction (tr ("&Edit"));
                QObject::connect (editAct, SIGNAL (triggered()),
                                  this, SLOT (editSlot()));

                QString fileToOpen = QDir::toNativeSeparators
                        ((qApp->property ("rootDirName").toString())+
                         qWebHitTestURL.toString
                         (QUrl::RemoveScheme
                          | QUrl::RemoveAuthority
                          | QUrl::RemoveQuery)
                         .replace ("?", ""));

                FileDetector detector;
                detector.defineInterpreter (fileToOpen);

                if ((!detector.interpreter.contains ("browser")) and
                        (!detector.interpreter.contains ("undefined"))) {
                    QAction* viewSourceAct = menu->addAction (tr ("&View Source"));
                    QObject::connect (viewSourceAct, SIGNAL (triggered()),
                                      this, SLOT (viewSourceFromContextMenuSlot()));
                }
            }

            if (QUrl (PEB_DOMAIN).isParentOf (qWebHitTestURL)) {

                QAction* openInNewWindowAct = menu->addAction (tr ("&Open in new window"));
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

            if ((qApp->property ("windowSize").toString()) == "maximized" or
                    (qApp->property ("windowSize").toString()) == "fullscreen") {
                if (!TopLevel::isMaximized()) {
                    QAction* maximizeAct = menu->addAction (tr ("&Maximized window"));
                    QObject::connect (maximizeAct, SIGNAL (triggered()),
                                      this, SLOT (maximizeSlot()));
                }

                if (!TopLevel::isFullScreen()) {
                QAction* toggleFullScreenAct = menu->addAction (tr ("&Fullscreen"));
                QObject::connect (toggleFullScreenAct, SIGNAL (triggered()),
                                  this, SLOT (toggleFullScreenSlot()));
                }
            }

            QAction* minimizeAct = menu->addAction (tr ("Mi&nimize"));
            QObject::connect (minimizeAct, SIGNAL (triggered()),
                              this, SLOT (minimizeSlot()));

            if (!TopLevel::url().toString().contains ("lroutput")) {
                QAction* homeAct = menu->addAction (tr ("&Home"));
                QObject::connect (homeAct, SIGNAL (triggered()),
                                  this, SLOT (loadStartPageSlot()));
            }

            if ((!TopLevel::url().toString().contains ("output"))) {
                QAction* reloadAct = menu->addAction (tr ("&Reload"));
                QObject::connect (reloadAct, SIGNAL (triggered()),
                                  this, SLOT (reloadSlot()));
            }

            QAction* printPreviewAct = menu->addAction (tr ("Print pre&view"));
            QObject::connect (printPreviewAct, SIGNAL (triggered()),
                              this, SLOT (startPrintPreviewSlot()));

            QAction* printAct = menu->addAction (tr ("&Print"));
            QObject::connect (printAct, SIGNAL (triggered()),
                              this, SLOT (printSlot()));

            QAction* saveAsPdfAct = menu->addAction (tr ("Save as P&DF"));
            QObject::connect (saveAsPdfAct, SIGNAL (triggered()),
                              this, SLOT (saveAsPdfSlot()));

            if ((!TopLevel::url().toString().contains ("output"))) {
                QAction* selectThemeAct = menu->addAction (tr ("&Select theme"));
                QObject::connect (selectThemeAct, SIGNAL (triggered()),
                                  this, SLOT (selectThemeFromContextMenuSlot()));
            }

            QAction* closeWindowAct = menu->addAction (tr ("&Close window"));
            QObject::connect (closeWindowAct, SIGNAL (triggered()),
                              this, SLOT (close()));

            QAction* quitAct = menu->addAction (tr ("&Quit"));
            QObject::connect ( quitAct, SIGNAL (triggered()),
                               this, SLOT (quitApplicationSlot()));

            menu->addSeparator();

            QAction* aboutAction = menu->addAction (tr ("&About"));
            QObject::connect (aboutAction, SIGNAL (triggered()),
                              this, SLOT (aboutSlot()));

            QAction* aboutQtAction = menu->addAction (tr ("About Q&t"));
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

        QMessageBox aboutBox;
        QSpacerItem* horizontalSpacer = new QSpacerItem (500, 0, QSizePolicy::Minimum, QSizePolicy::Expanding);
        aboutBox.setWindowTitle ("About Perl Executing Browser");
        aboutBox.setIconPixmap ((qApp->property ("icon").toString()));
        aboutBox.setText ("Perl Executing Browser, version 0.1<br>"
                        "code name Camel Calf,<br><br>"
                        "Qt WebKit version: "+qtWebKitVersion+"<br>"
                        "Qt version: "+qtVersion+"<br><br>"
                        "This program is free software;<br>"
                        "you can redistribute it and/or modify it<br>"
                        "under the terms of the GNU General Public License,<br>"
                        "as published by the Free Software Foundation;<br>"
                        "either version 3 of the License,<br>"
                        "or (at your option) any later version.<br><br>"
                        "This program is distributed in the hope that it will be useful,<br>"
                        "but WITHOUT ANY WARRANTY;<br>"
                        "without even the implied warranty of<br>"
                        "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.<br><br>"
                        "Dimitar D. Mitov, 2013 - 2015,<br>"
                        "Valcho Nedelchev, 2014 - 2015<br><br>"
                        "<a href='https://github.com/ddmitov/perl-executing-browser'>"
                        "https://github.com/ddmitov/perl-executing-browser</a><br>");
        QGridLayout* layout = (QGridLayout*)aboutBox.layout();
        layout->addItem (horizontalSpacer, layout->rowCount(), 0, 1, layout->columnCount());
        aboutBox.setDefaultButton (QMessageBox::Ok);
        aboutBox.exec();
    }

    void closeEvent (QCloseEvent* event)
    {
        if (mainPage->scriptHandler.isOpen()) {
            QMessageBox confirmExitMessageBox;
            confirmExitMessageBox.setWindowModality (Qt::WindowModal);
            confirmExitMessageBox.setWindowTitle (tr ("Close"));
            confirmExitMessageBox.setIconPixmap ((qApp->property ("icon").toString()));
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
            confirmExitMessageBox.setIconPixmap ((qApp->property ("icon").toString()));
            confirmExitMessageBox.setText (tr ("You are going to quit the program,<br>")+
                                           tr ("but at least one long-running script is still running.<br>")+
                                           tr ("Are you sure?"));
            confirmExitMessageBox.setStandardButtons (QMessageBox::Yes | QMessageBox::No);
            confirmExitMessageBox.setButtonText (QMessageBox::Yes, tr ("Yes"));
            confirmExitMessageBox.setButtonText (QMessageBox::No, tr ("No"));
            confirmExitMessageBox.setDefaultButton (QMessageBox::No);
            if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                // Perl temp folder removal code:
                QProcess cleanerProcess;
                cleanerProcess.startDetached ((qApp->property ("perlInterpreter").toString()),
                                              QStringList()
                                              << "-se"
                                              << "use File::Path;  rmtree (@ARGV);"
                                              << "--"
                                              << (qApp->property ("applicationTempDirectory").toString()));
                QApplication::exit();
            }
        } else {
            // Qt5 temp folder removal code - Qt4 incompatible:
            //QDir applicationTempDirectory (qApp->property ("applicationTempDirectory").toString());
            //applicationTempDirectory.removeRecursively();

            // Perl temp folder removal code:
            QProcess cleanerProcess;
            cleanerProcess.startDetached ((qApp->property ("perlInterpreter").toString()),
                                          QStringList()
                                          << "-se"
                                          << "use File::Path;  rmtree (@ARGV);"
                                          << "--"
                                          << (qApp->property ("applicationTempDirectory").toString()));
            QApplication::exit();
        }

        if ((qApp->property ("systrayIcon").toString()) == "enable") {
            emit trayIconHideSignal();
        }

        QString dateTimeString = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");
        qDebug() << qApp->applicationName().toLatin1().constData()
                 << qApp->applicationVersion().toLatin1().constData()
                 << "terminated normally on:" << dateTimeString;
        qDebug() << "===============";
    }

    void sslErrors (QNetworkReply* reply, const QList<QSslError> &errors)
    {
        foreach (QSslError error, errors) {
            qDebug() << "SSL error: " << error;
        }

        reply->ignoreSslErrors();
    }

public:

    TopLevel ();

    QWebView* createWindow (QWebPage::WebWindowType type)
    {
        qDebug() << "New window requested.";

        Q_UNUSED (type);
        QWebView* window = new TopLevel ();
        window->setWindowIcon (icon);
        window->setAttribute (Qt::WA_DeleteOnClose, true);
        window->show();

        return window;
    }

private:

    Page* mainPage;

    QUrl qWebHitTestURL;
    QString filepath;
    QWebView* newWindow;

    QWebView* errorsWindow;

    QPixmap icon;

};

#endif // PEB_H
