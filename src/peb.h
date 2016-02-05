/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2016, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014 - 2016
*/

#ifndef PEB_H
#define PEB_H

#include <QApplication>
#include <QtNetwork/QNetworkAccessManager>
#include <QNetworkReply>
#include <QtWebKit>
#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QProcess>
#include <QFileDialog>
#include <QInputDialog>
#include <QMessageBox>
#include <QSpacerItem>
#include <QGridLayout>
#include <QMenu>
#include <QDesktopWidget>
#include <QSystemTrayIcon>

// ==============================
// PRINT SUPPORT:
// ==============================
#ifndef QT_NO_PRINTER
#include <QPrintPreviewDialog>
#include <qglobal.h>
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#include <QUrlQuery>
#endif

// ==============================
// FILE DETECTOR CLASS DEFINITION:
// ==============================
class QFileDetector : public QObject
{
    Q_OBJECT

public slots:
    void qDefineInterpreter(QString filepath)
    {
        interpreter = "undefined";

        QFileInfo fileInfo(filepath);
        extension = fileInfo.suffix();

        if (extension.length() == 0) {
            QString firstLine;

            QFile file(filepath);

            if (file.open (QIODevice::ReadOnly | QIODevice::Text)) {
                firstLine = file.readLine();
            }

            if (firstLine.contains(perlShebang)) {
                interpreter = (qApp->property("perlInterpreter").toString());
            }
        } else {
            if (extension.contains(htmlExtensions)) {
                interpreter = "browser-html";
            }
            if (extension.contains(cssExtension) or
                    extension.contains(jsExtension) or
                    extension.contains(ttfExtension) or
                    extension.contains(eotExtension) or
                    extension.contains(woffExtensions) or
                    extension.contains(svgExtension) or
                    extension.contains(pngExtension) or
                    extension.contains(jpgExtensions) or
                    extension.contains(gifExtension)) {
                interpreter = "browser";
            }

            if (extension == "pl") {
                interpreter = (qApp->property("perlInterpreter").toString());
            }
        }
    }

    void qCheckFileExistence(QString fullFilePath)
    {
        QFile file(QDir::toNativeSeparators(fullFilePath));
        if (!file.exists()) {
            qMissingFileMessage(QDir::toNativeSeparators(fullFilePath));
        }
    }

    void qMissingFileMessage(QString fullFilePath)
    {
        QMessageBox missingFileMessageBox (qApp->activeWindow());
        missingFileMessageBox.setWindowModality(Qt::WindowModal);
        missingFileMessageBox.setIcon(QMessageBox::Critical);
        missingFileMessageBox.setWindowTitle(tr("Missing file"));
        missingFileMessageBox
                .setText(QDir::toNativeSeparators(fullFilePath)
                         + "<br>"
                         + tr("is missing.")
                         + "<br>"
                         + tr("Please restore the missing file."));
        missingFileMessageBox.setDefaultButton(QMessageBox::Ok);
        missingFileMessageBox.exec();
        qDebug() << QDir::toNativeSeparators(fullFilePath) <<
                    "is missing.";
        qDebug() << "Please restore the missing file.";
        qDebug() << "===============";
    }

public:
    QFileDetector();
    QString interpreter;

    QRegExp plExtension;
    QRegExp htmlExtensions;

private:
    QString extension;
    QRegExp perlShebang;

    // Regular expressions for file type detection by extension:
    QRegExp cssExtension;
    QRegExp jsExtension;
    QRegExp svgExtension;
    QRegExp ttfExtension;
    QRegExp eotExtension;
    QRegExp woffExtensions;
    QRegExp pngExtension;
    QRegExp jpgExtensions;
    QRegExp gifExtension;
};

// ==============================
// SCRIPT ENVIRONMENT CLASS DEFINITION:
// ==============================
class QScriptEnvironment : public QObject
{
    Q_OBJECT

public:
    QScriptEnvironment();

    QProcessEnvironment scriptEnvironment;
};

// ==============================
// SYSTEM TRAY ICON CLASS DEFINITION:
// ==============================
class QTrayIcon : public QSystemTrayIcon
{
    Q_OBJECT

public slots:
    void qTrayIconHideSlot()
    {
        trayIcon->hide();
    }

public:
    QTrayIcon();

    QAction *aboutAction;
    QAction *aboutQtAction;

private:
    QSystemTrayIcon *trayIcon;
    QMenu *trayIconMenu;
};

// ==============================
// CUSTOM NETWORK REPLY CLASS DEFINITION:
// ==============================
class QCustomNetworkReply : public QNetworkReply
{
    Q_OBJECT

public:

    QCustomNetworkReply(const QUrl &url, QString &data);
    ~QCustomNetworkReply();

    void abort();
    qint64 bytesAvailable() const;
    bool isSequential() const;
    qint64 size() const;

protected:
    qint64 read(char *data, qint64 maxSize);
    qint64 readData(char *data, qint64 maxSize);

private:
    struct QCustomNetworkReplyPrivate *reply;
};

// ==============================
// NETWORK ACCESS MANAGER CLASS DEFINITION:
// ==============================
class ModifiedNetworkAccessManager : public QNetworkAccessManager
{
    Q_OBJECT

signals:
    void startScriptSignal(QUrl url, QByteArray postDataArray);
    void startPerlDebuggerSignal(QUrl debuggerUrl);

    void qInjectSettingsSignal();

protected:
    virtual QNetworkReply *createRequest(Operation operation,
                                         const QNetworkRequest &request,
                                         QIODevice *outgoingData = 0)
    {
        // Local AJAX GET and POST requests.
        if ((operation == GetOperation or
             operation == PostOperation) and
                request.url().authority() == PSEUDO_DOMAIN and
                request.url().path().contains("ajax")) {

            QUrl url = request.url();
            qDebug() << "AJAX Script URL:" << url.toString();

            QString scriptFullFilePath = QDir::toNativeSeparators
                    ((qApp->property("rootDirName").toString())
                     + url.path());

            // Replace initial slash at the beginning of the relative path;
            // root directory setting already has a trailing slash.
            scriptFullFilePath = scriptFullFilePath.replace("//", "/");

            QString queryString = url.query();

            QByteArray postDataArray;
            if (outgoingData) {
                postDataArray = outgoingData->readAll();
            }
            QString postData(postDataArray);

            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(scriptFullFilePath);
            fileDetector.qDefineInterpreter(scriptFullFilePath);

            qDebug() << "File path:" << scriptFullFilePath;
            qDebug() << "Interpreter:" << fileDetector.interpreter;

            QScriptEnvironment initialScriptEnvironment;
            QProcessEnvironment scriptEnvironment;
            scriptEnvironment = initialScriptEnvironment.scriptEnvironment;

            if (queryString.length() > 0) {
                scriptEnvironment.insert("REQUEST_METHOD", "GET");
                scriptEnvironment.insert("QUERY_STRING", queryString);
                qDebug() << "Query string:" << queryString;
            }

            if (postData.length() > 0) {
                scriptEnvironment.insert("REQUEST_METHOD", "POST");
                QString postDataSize = QString::number(postData.size());
                scriptEnvironment.insert("CONTENT_LENGTH", postDataSize);
                qDebug() << "POST data:" << postData;
            }

            QProcess scriptHandler;
            scriptHandler.setProcessEnvironment(scriptEnvironment);

            QFileInfo scriptAbsoluteFilePath(
                        QDir::toNativeSeparators(scriptFullFilePath));
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            scriptHandler.setWorkingDirectory(scriptDirectory);
            qDebug() << "Working directory:"
                     << QDir::toNativeSeparators(scriptDirectory);
            qDebug() << "===============";

            QEventLoop scriptHandlerWaitingLoop;

            QObject::connect(&scriptHandler,
                             SIGNAL(finished(int, QProcess::ExitStatus)),
                             &scriptHandlerWaitingLoop,
                             SLOT(quit()));
            QTimer::singleShot(2000, &scriptHandlerWaitingLoop, SLOT(quit()));

            QString scriptResultString;
            QString scriptErrorString;

            if (!scriptHandler.isOpen()) {
                if (SCRIPT_CENSORING == 0) {
                    scriptHandler.start((qApp->property("perlInterpreter")
                                         .toString()),
                                        QStringList() <<
                                        QDir::toNativeSeparators
                                        (scriptFullFilePath),
                                        QProcess::Unbuffered
                                        | QProcess::ReadWrite);
                }

                if (SCRIPT_CENSORING == 1) {
                    // 'censor.pl' is compiled into the resources of
                    // the binary file and called from there.
                    QString censorScriptFileName(":/scripts/perl/censor.pl");
                    QFile censorScriptFile(censorScriptFileName);
                    censorScriptFile.open(QIODevice::ReadOnly
                                          | QIODevice::Text);
                    QTextStream stream(&censorScriptFile);
                    QString censorScriptContents = stream.readAll();
                    censorScriptFile.close();

                    scriptHandler
                            .start((qApp->property("perlInterpreter")
                                    .toString()),
                                   QStringList()
                                   << "-e"
                                   << censorScriptContents
                                   << "--"
                                   << QDir::toNativeSeparators(
                                       scriptFullFilePath),
                                   QProcess::Unbuffered
                                   | QProcess::ReadWrite);
                }

                if (postData.length() > 0) {
                    scriptHandler.write(postDataArray);
                }

                scriptHandlerWaitingLoop.exec();

                QByteArray scriptResultArray =
                        scriptHandler.readAllStandardOutput();
                scriptResultString =
                        QString::fromLatin1(scriptResultArray);

                QByteArray scriptErrorArray =
                        scriptHandler.readAllStandardError();
                scriptErrorString =
                        QString::fromLatin1(scriptErrorArray);

                if (scriptResultString.length() == 0 and
                        scriptErrorString == 0) {
                    qDebug() << "AJAX Script timed out:" << scriptFullFilePath;
                    qDebug() << "===============";

                    QMessageBox scriptTimeoutMessageBox (qApp->activeWindow());
                    scriptTimeoutMessageBox.setWindowModality(Qt::WindowModal);
                    scriptTimeoutMessageBox
                            .setWindowTitle(tr("AJAX Script Timeout"));
                    scriptTimeoutMessageBox
                            .setIconPixmap((qApp->property("icon").toString()));
                    scriptTimeoutMessageBox
                            .setText(
                                tr("Your AJAX script timed out:")
                                + "<br>"
                                + scriptFullFilePath);
                    scriptTimeoutMessageBox.setDefaultButton(QMessageBox::Ok);
                    scriptTimeoutMessageBox.exec();
                }
            } else {
                qDebug() << "Script already started:" << scriptFullFilePath;
                qDebug() << "===============";

                QMessageBox scriptStartedMessageBox (qApp->activeWindow());
                scriptStartedMessageBox
                        .setWindowModality(Qt::WindowModal);
                scriptStartedMessageBox
                        .setWindowTitle(tr("AJAX Script Already Started"));
                scriptStartedMessageBox
                        .setIconPixmap((qApp->property("icon").toString()));
                scriptStartedMessageBox
                        .setText(tr("This AJAX script is already started "
                                    "and still running:")
                                 + "<br>"
                                 + scriptFullFilePath);
                scriptStartedMessageBox.setDefaultButton(QMessageBox::Ok);
                scriptStartedMessageBox.exec();
            }

            QWebSettings::clearMemoryCaches();

            scriptEnvironment.remove("FILE_TO_OPEN");
            scriptEnvironment.remove("FILE_TO_CREATE");
            scriptEnvironment.remove("FOLDER_TO_OPEN");
            scriptEnvironment.remove("REQUEST_METHOD");

            if (queryString.length() > 0) {
                scriptEnvironment.remove("QUERY_STRING");
            }

            if (postData.length() > 0) {
                scriptEnvironment.remove("CONTENT_LENGTH");
            }

            QCustomNetworkReply *reply =
                    new QCustomNetworkReply (request.url(), scriptResultString);
            return reply;
        }

        // GET requests to the browser pseudodomain:
        if (operation == GetOperation and
                request.url().authority() == PSEUDO_DOMAIN and
                (!request.url().path().contains("ajax"))) {

            // Get the full file path and file extension:
            QString fullFilePath = QDir::toNativeSeparators
                    ((qApp->property("rootDirName").toString())
                     + request.url().path());
            fullFilePath.replace("//", "/");

            QFileDetector fileDetector;
            fileDetector.qDefineInterpreter(fullFilePath);
            QString interpreter = fileDetector.interpreter;

            // Handle local Perl scripts:
            if (interpreter ==
                    qApp->property("perlInterpreter").toString()) {

                QByteArray emptyPostDataArray;
                emit startScriptSignal(request.url(), emptyPostDataArray);

                QNetworkRequest emptyNetworkRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest(emptyNetworkRequest));
            }

            // Handle local HTML, CSS, JS, web fonts or supported image files:
            if (interpreter.contains ("browser")) {

                QNetworkRequest networkRequest;
                networkRequest.setUrl
                        (QUrl::fromLocalFile
                         (QDir::toNativeSeparators(
                              (qApp->property("rootDirName").toString())
                              + request.url().path())));

                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest(networkRequest));
            }

            // Local files without recognized file type:
            if (interpreter.contains("undefined")) {

                qDebug() << "File:" << fullFilePath;
                qDebug() << "File type not recognized!";
                qDebug() << "===============";

                QNetworkRequest networkRequest;
                networkRequest.setUrl(QString("qrc:/html/notrecognized.htm"));

                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest(networkRequest));
            }
        }

        // Take data from a local form using CGI POST method and
        // execute associated local script:
        if (operation == PostOperation and
                request.url().authority() == PSEUDO_DOMAIN and
                (!request.url().path().contains("ajax"))) {

            if (outgoingData) {
                QByteArray postDataArray = outgoingData->readAll();
                emit startScriptSignal(request.url(), postDataArray);
            }

            QNetworkRequest emptyNetworkRequest;
            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest(emptyNetworkRequest));
        }

        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Perl debugger interaction.
            // Implementation of an idea proposed by Valcho Nedelchev.
            // Transmit requests to Perl debugger
            // in case debugger is started in a new window:
            if (operation == GetOperation and
                    request.url().scheme().contains("file") and
                    request.url().hasQuery()) {

                emit startPerlDebuggerSignal(request.url());
            }
        }

        // GET, POST and PUT requests to allowed resources.
        // Domain filtering happens here:
        if ((operation == GetOperation or
             operation == PostOperation or
             operation == PutOperation) and
                ((request.url().scheme() =="file") or
                 (request.url().scheme() == "qrc") or
                 (request.url().toString().contains("data:image")) or
                 (request.url().authority() == PSEUDO_DOMAIN) or
                 ((qApp->property("allowedDomainsList").toStringList())
                  .contains(request.url().authority())))) {

            qDebug() << "Allowed link:" << request.url().toString();
            qDebug() << "===============";

            QNetworkRequest networkRequest;
            networkRequest.setUrl(request.url());

            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest(networkRequest));
        } else {
            qDebug() << "Not allowed link:" << request.url().toString();
            qDebug() << "===============";

            QNetworkRequest networkRequest;
            networkRequest.setUrl(QString("qrc:/html/forbidden.htm"));

            return QNetworkAccessManager::createRequest
                    (QNetworkAccessManager::GetOperation,
                     QNetworkRequest(networkRequest));
        }
    }
};

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
class QPage : public QWebPage
{
    Q_OBJECT

signals:
    void displayErrorsSignal(QString errors);
    void printPreviewSignal();
    void printSignal();
    void saveAsPdfSignal();
    void reloadSignal();

public slots:

    void qThemeLinker(QString htmlInput)
    {
        cssLinkedHtml = "";

        if ((htmlInput.contains("</title>")) and
                (!htmlInput.contains("current-theme.css"))) {
            QString cssLink;
            cssLink.append("</title>\n");
            cssLink.append("<link rel=\"stylesheet\" type=\"text/css\"");
            cssLink.append("href=\"http://");
            cssLink.append(PSEUDO_DOMAIN);
            cssLink.append("/");
            cssLink.append(qApp->property("defaultThemeDirectoryName")
                           .toString());
            cssLink.append("/current-theme.css\" media=\"all\" />");

            htmlInput.replace("</title>", cssLink);

            cssLinkedHtml = htmlInput;
        } else {
            cssLinkedHtml = htmlInput;
        }
    }

    void qHttpHeaderCleaner(QString input)
    {
        httpHeadersCleanedHtml = "";

        if (input.contains("<!DOCTYPE")) {
            QString htmlContent = input.section("<!DOCTYPE", 1, 1);
            httpHeadersCleanedHtml = "<!DOCTYPE";
            httpHeadersCleanedHtml.append(htmlContent);
        }

        if (input.contains("<html>")) {
            QString htmlContent = input.section("<html>", 1, 1);
            httpHeadersCleanedHtml = "<html>";
            httpHeadersCleanedHtml.append(htmlContent);
        }
    }

    void qThemeSetterSlot(QString theme)
    {
        theme.prepend((qApp->property("allThemesDirectory").toString())
                      + QDir::separator());
        theme.append(".theme");

        if (theme.length() > 0) {
            if (QFile::exists(
                        QDir::toNativeSeparators(
                            (qApp->property("defaultThemeDirectoryFullPath")
                             .toString())
                            + QDir::separator() + "current-theme.css"))) {
                QFile::remove(
                            QDir::toNativeSeparators(
                                (qApp->property("defaultThemeDirectoryFullPath")
                                 .toString())
                                + QDir::separator() + "current-theme.css"));
            }
            QFile::copy(theme,
                        QDir::toNativeSeparators(
                            (qApp->property("defaultThemeDirectoryFullPath")
                             .toString())
                            + QDir::separator() + "current-theme.css"));

            emit reloadSignal();

            qDebug() << "Selected new theme:" << theme;
            qDebug() << "===============";
        } else {
            qDebug() << "No new theme selected.";
            qDebug() << "===============";
        }
    }

    void qStartScriptSlot(QUrl url, QByteArray postDataArray)
    {
        qDebug() << "Script URL:" << url.toString();

        QString relativeFilePath = url.path();

        scriptFullFilePath = QDir::toNativeSeparators
                ((qApp->property("rootDirName").toString()) + relativeFilePath);
        // Replace initial slash at the beginning of the relative path;
        // root directory setting already has a trailing slash.
        scriptFullFilePath.replace("//", "/");

        QString queryString = url.query();

        scriptKilled = false;

        QString postData(postDataArray);

        if (queryString.contains("action=kill") or
                postData.contains("action=kill")) {
            if (scriptHandler.isOpen()) {
                qDebug() << "Script is going to be terminated by user request.";

                scriptHandler.close();
                scriptKilled = true;

                QMessageBox scriptKilledMessageBox (qApp->activeWindow());
                scriptKilledMessageBox.setWindowModality(Qt::WindowModal);
                scriptKilledMessageBox.setWindowTitle(tr("Script Killed"));
                scriptKilledMessageBox
                        .setIconPixmap((qApp->property("icon").toString()));
                scriptKilledMessageBox
                        .setText(tr("This script is terminated as requested:")
                                 + "<br>"
                                 + scriptFullFilePath);
                scriptKilledMessageBox.setDefaultButton(QMessageBox::Ok);
                scriptKilledMessageBox.exec();
            } else {
                scriptKilled = true;

                QMessageBox scriptAlreadyFinishedMessageBox (
                            qApp->activeWindow());
                scriptAlreadyFinishedMessageBox
                        .setWindowModality(Qt::WindowModal);
                scriptAlreadyFinishedMessageBox
                        .setWindowTitle(tr("Script Finished"));
                scriptAlreadyFinishedMessageBox
                        .setIconPixmap((qApp->property("icon").toString()));
                scriptAlreadyFinishedMessageBox
                        .setText(tr("This script did not start or")
                                 + "<br>"
                                 + tr("finished before "
                                      "script termination was requested:")
                                 + "<br>"
                                 + scriptFullFilePath);
                scriptAlreadyFinishedMessageBox
                        .setDefaultButton(QMessageBox::Ok);
                scriptAlreadyFinishedMessageBox.exec();
            }
        } else {
            bool sourceEnabled;

            if (scriptFullFilePath.contains("longrun")) {
                // Default values for long-running scripts:
                sourceEnabled = false;
                scriptOutputThemeEnabled = true;
                scriptOutputType = "accumulation";
            } else {
                // Default values for CGI-like scripts:
                sourceEnabled = false;
                scriptOutputThemeEnabled = true;
                scriptOutputType = "final";
            }

            if (queryString.contains("source=enabled")) {
                // Default values for displaying source code
                // outside of the Perl debugger:
                sourceEnabled = true;
                scriptOutputThemeEnabled = false;
                scriptOutputType = "final";
            }

            if (queryString.contains("theme=disabled")) {
                scriptOutputThemeEnabled = false;
                queryString.replace("theme=disabled", "");
            }

            if (queryString.contains("output=latest")) {
                scriptOutputType = "latest";
                queryString.replace("output=latest", "");
            }

            if (queryString.contains("output=accumulation")) {
                scriptOutputType = "accumulation";
                queryString.replace("output=accumulation", "");
            }

            if (queryString.contains("output=final")) {
                scriptOutputType = "final";
                queryString.replace("output=final", "");
            }

            QRegExp multipleAmpersands("&{2,}");
            queryString.replace(multipleAmpersands, "");
            QRegExp finalAmpersand("&$");
            queryString.replace(finalAmpersand, "");
            QRegExp finalQuestionMark("\\?$");
            queryString.replace(finalQuestionMark, "");

            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(scriptFullFilePath);
            fileDetector.qDefineInterpreter(scriptFullFilePath);

            qDebug() << "File path:" << scriptFullFilePath;
            qDebug() << "Interpreter:" << fileDetector.interpreter;

            if (queryString.length() > 0) {
                scriptEnvironment.insert("REQUEST_METHOD", "GET");
                scriptEnvironment.insert("QUERY_STRING", queryString);
                qDebug() << "Query string:" << queryString;
            }

            if (postData.length() > 0) {
                scriptEnvironment.insert("REQUEST_METHOD", "POST");
                QString postDataSize = QString::number(postData.size());
                scriptEnvironment.insert("CONTENT_LENGTH", postDataSize);
                qDebug() << "POST data:" << postData;
            }

            scriptHandler.setProcessEnvironment(scriptEnvironment);

            QFileInfo scriptAbsoluteFilePath(
                        QDir::toNativeSeparators(scriptFullFilePath));
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            scriptHandler.setWorkingDirectory(scriptDirectory);
            qDebug() << "Working directory:"
                     << QDir::toNativeSeparators(scriptDirectory);
            qDebug() << "===============";

            if (!scriptHandler.isOpen()) {
                if (sourceEnabled == true) {
                    QString sourceFilepath =
                            QDir::toNativeSeparators(scriptFullFilePath);

                    QStringList sourceViewerCommandLine;
                    sourceViewerCommandLine = sourceViewerMandatoryCommandLine;
                    sourceViewerCommandLine.append(sourceFilepath);

                    scriptHandler.start((qApp->property("perlInterpreter")
                                         .toString()),
                                        sourceViewerCommandLine,
                                        QProcess::Unbuffered
                                        | QProcess::ReadWrite);

                    runningScriptsInCurrentWindowList.append(sourceFilepath);

                } else {
                    if (SCRIPT_CENSORING == 0) {
                        scriptHandler.start((qApp->property("perlInterpreter")
                                             .toString()),
                                            QStringList() <<
                                            QDir::toNativeSeparators
                                            (scriptFullFilePath),
                                            QProcess::Unbuffered
                                            | QProcess::ReadWrite);
                    }

                    if (SCRIPT_CENSORING == 1) {
                        // 'censor.pl' is compiled into the resources of
                        // the binary file and called from there.
                        QString censorScriptFileName(":/scripts/perl/censor.pl");
                        QFile censorScriptFile(censorScriptFileName);
                        censorScriptFile.open(QIODevice::ReadOnly
                                              | QIODevice::Text);
                        QTextStream stream(&censorScriptFile);
                        QString censorScriptContents = stream.readAll();
                        censorScriptFile.close();

                        scriptHandler
                                .start((qApp->property("perlInterpreter")
                                        .toString()),
                                       QStringList()
                                       << "-e"
                                       << censorScriptContents
                                       << "--"
                                       << QDir::toNativeSeparators(
                                           scriptFullFilePath),
                                       QProcess::Unbuffered
                                       | QProcess::ReadWrite);
                    }

                    runningScriptsInCurrentWindowList
                            .append(scriptFullFilePath);

                    if (postData.length() > 0) {
                        scriptHandler.write(postDataArray);
                    }
                }
            } else {
                qDebug() << "Script already started:" << scriptFullFilePath;
                qDebug() << "===============";

                QMessageBox scriptStartedMessageBox (qApp->activeWindow());
                scriptStartedMessageBox
                        .setWindowModality(Qt::WindowModal);
                scriptStartedMessageBox
                        .setWindowTitle(tr("Script Already Started"));
                scriptStartedMessageBox
                        .setIconPixmap((qApp->property("icon").toString()));
                scriptStartedMessageBox
                        .setText(tr("This script is already started "
                                    "and still running:")
                                 + "<br>"
                                 + scriptFullFilePath);
                scriptStartedMessageBox.setDefaultButton(QMessageBox::Ok);
                scriptStartedMessageBox.exec();
            }

            scriptTimedOut = false;

            if (!scriptFullFilePath.contains("longrun")) {
                int scriptTimeoutNumeric =
                        (qApp->property("scriptTimeout").toInt());
                int maximumTimeMilliseconds = scriptTimeoutNumeric * 1000 ;
                QTimer::singleShot(maximumTimeMilliseconds,
                                   this, SLOT(qScriptTimeoutSlot()));
            }

            QWebSettings::clearMemoryCaches();

            scriptEnvironment.remove("FILE_TO_OPEN");
            scriptEnvironment.remove("FILE_TO_CREATE");
            scriptEnvironment.remove("FOLDER_TO_OPEN");
            scriptEnvironment.remove("REQUEST_METHOD");

            if (queryString.length() > 0) {
                scriptEnvironment.remove("QUERY_STRING");
            }

            if (postData.length() > 0) {
                scriptEnvironment.remove("CONTENT_LENGTH");
            }
        }
    }

    void qScriptOutputSlot()
    {
        QString output = scriptHandler.readAllStandardOutput();

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: output from" << scriptFullFilePath;
//        qDebug() << "Script output:" << output;
        qDebug() << "===============";

        if (scriptOutputType == "accumulation" or scriptOutputType == "final") {
            scriptAccumulatedOutput.append(output);
        }

        // Latest output:
        if (scriptOutputType == "latest") {

            qHttpHeaderCleaner(output);
            output = httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                qThemeLinker(output);
                output = cssLinkedHtml;
            }
        }

        // Accumulated output:
        if (scriptOutputType == "accumulation" or scriptOutputType == "final") {

            qHttpHeaderCleaner(scriptAccumulatedOutput);
            scriptAccumulatedOutput = httpHeadersCleanedHtml;

            if (scriptOutputThemeEnabled == true) {
                qThemeLinker(scriptAccumulatedOutput);
                scriptAccumulatedOutput = cssLinkedHtml;
            }
        }

        if (!QPage::mainFrame()->childFrames().contains(targetFrame)) {
            targetFrame = QPage::currentFrame();
        }

        if (scriptOutputType == "latest") {
            targetFrame->setHtml(output, QUrl(PSEUDO_DOMAIN));
        }

        if (scriptOutputType == "accumulation") {
            targetFrame->setHtml(scriptAccumulatedOutput,
                                 QUrl(PSEUDO_DOMAIN));
        }
    }

    void qScriptErrorsSlot()
    {
        QString error = scriptHandler.readAllStandardError();
        scriptAccumulatedErrors.append(error);
        scriptAccumulatedErrors.append("\n");

//        qDebug() << "Script error:" << error;
//        qDebug() << "===============";
    }

    void qScriptFinishedSlot()
    {
        if (!QPage::mainFrame()->childFrames().contains(targetFrame)) {
            targetFrame = QPage::currentFrame();
        }

        if (scriptTimedOut == false) {
            if (scriptOutputType == "final") {
                targetFrame->setHtml(scriptAccumulatedOutput,
                                      QUrl(PSEUDO_DOMAIN));
            }

            if ((qApp->property("displayStderr").toString()) == "enable") {
                if (scriptAccumulatedErrors.length() > 0 and
                        scriptKilled == false) {

                    qThemeLinker(scriptAccumulatedErrors);
                    scriptAccumulatedErrors = cssLinkedHtml;

                    if (scriptAccumulatedOutput.length() == 0) {
                        targetFrame->setHtml(scriptAccumulatedErrors,
                                              QUrl(PSEUDO_DOMAIN));
                    } else {
                        QMessageBox showErrorsMessageBox (qApp->activeWindow());
                        showErrorsMessageBox.setWindowModality(Qt::WindowModal);
                        showErrorsMessageBox.setWindowTitle(tr("Errors"));
                        showErrorsMessageBox
                                .setIconPixmap((qApp->property("icon")
                                               .toString()));
                        showErrorsMessageBox
                                .setText(tr("Errors were found "
                                            "during script execution.")
                                         + "<br>"
                                         + tr("Do you want to see them?"));
                        showErrorsMessageBox
                                .setStandardButtons(QMessageBox::Yes
                                                    | QMessageBox::No);
                        showErrorsMessageBox
                                .setButtonText(QMessageBox::Yes, tr("Yes"));
                        showErrorsMessageBox
                                .setButtonText(QMessageBox::No, tr("No"));
                        showErrorsMessageBox.setDefaultButton(QMessageBox::Yes);

                        if (showErrorsMessageBox.exec() == QMessageBox::Yes) {
                            emit displayErrorsSignal(scriptAccumulatedErrors);
                        }
                    }
                }
            }

            scriptHandler.close();

            qDebug() << "Script finished:" << scriptFullFilePath;
            qDebug() << "===============";
        }

        runningScriptsInCurrentWindowList.removeOne(scriptFullFilePath);

        scriptAccumulatedOutput = "";
        scriptAccumulatedErrors = "";
    }

    void qScriptTimeoutSlot()
    {
        if (scriptHandler.isOpen() and
                scriptAccumulatedErrors.length() == 0) {

            scriptTimedOut = true;
            scriptHandler.close();

            runningScriptsInCurrentWindowList.removeOne(scriptFullFilePath);

            qDebug() << "Script timed out:" << scriptFullFilePath;
            qDebug() << "===============";

            QMessageBox scriptTimeoutMessageBox (qApp->activeWindow());
            scriptTimeoutMessageBox.setWindowModality(Qt::WindowModal);
            scriptTimeoutMessageBox.setWindowTitle(tr("Script Timeout"));
            scriptTimeoutMessageBox
                    .setIconPixmap((qApp->property("icon").toString()));
            scriptTimeoutMessageBox
                    .setText(
                        tr("Your script timed out:")
                        + "<br>"
                        + scriptFullFilePath);
            scriptTimeoutMessageBox.setDefaultButton(QMessageBox::Ok);
            scriptTimeoutMessageBox.exec();
        }
    }

    // ==============================
    // PERL DEBUGGER INTERACTION.
    // Implementation of an idea proposed by Valcho Nedelchev.
    // ==============================
    void qStartPerlDebuggerSlot(QUrl debuggerUrl)
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Read and store in memory
            // the Perl debugger output formatter script:
            QFile debuggerOutputFormatterFile(
                        QDir::toNativeSeparators(
                            (qApp->property("debuggerOutputFormatter")
                             .toString())));
            debuggerOutputFormatterFile.open(QFile::ReadOnly | QFile::Text);
            debuggerOutputFormatterScript =
                    QString(debuggerOutputFormatterFile.readAll());
            debuggerOutputFormatterFile.close();

            // Read Perl debugger interaction special URL:
            QString filePath = debuggerUrl.path();

#ifdef Q_OS_WIN
            filePath.replace(QRegExp("^\\/"), "");
#endif

            if ((!filePath.contains("select-file")) and
                    (!filePath.contains("execute"))) {
                debuggerScriptToDebugFilePath = filePath;
            }

            debuggerLastCommand = debuggerUrl.query()
                    .replace("command", "")
                    .replace("=", "")
                    .replace("+", " ")
                    .replace("/", "");

            qDebug() << "File passed to Perl debugger:"
                     << QDir::toNativeSeparators(debuggerScriptToDebugFilePath);

            // Perl interpreter to be used for debugging:
            QString debuggerInterpreter =
                    (qApp->property("perlInterpreter").toString());
            qDebug() << "Interpreter:" << debuggerInterpreter;

            // Clean accumulated debugger output from previous debugger session:
            debuggerAccumulatedOutput = "";

            // Start a new debugger session with a new file to debug:
            if (debuggerUrl.path().contains("select-file")) {
                debuggerHandler.close();
            }

            if (debuggerHandler.isOpen()) {
                QByteArray debuggerCommand;
                debuggerCommand.append(debuggerLastCommand.toLatin1());
                debuggerCommand.append(QString("\n").toLatin1());
                debuggerHandler.write(debuggerCommand);
            } else {
                debuggerJustStarted = true;

                scriptEnvironment.insert("PERLDB_OPTS", "ReadLine=0");
                debuggerHandler.setProcessEnvironment(scriptEnvironment);

                QFileInfo scriptAbsoluteFilePath(debuggerScriptToDebugFilePath);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                debuggerHandler.setWorkingDirectory(scriptDirectory);
                qDebug() << "Working directory:"
                         << QDir::toNativeSeparators(scriptDirectory);
                qDebug() << "===============";

                debuggerHandler.setProcessChannelMode(QProcess::MergedChannels);
                debuggerHandler.start(debuggerInterpreter, QStringList()
                                      << "-d" <<
                                      QDir::toNativeSeparators(
                                          debuggerScriptToDebugFilePath),
                                      QProcess::Unbuffered
                                      | QProcess::ReadWrite);

                QByteArray debuggerCommand;
                debuggerCommand.append(debuggerLastCommand.toLatin1());
                debuggerCommand.append(QString("\n").toLatin1());
                debuggerHandler.write(debuggerCommand);

                qDebug() << QDateTime::currentMSecsSinceEpoch()
                         << "msecs from epoch: command sent to Perl debugger:"
                         << debuggerLastCommand;
                qDebug() << "===============";
            }
        }
    }

    void qDebuggerOutputSlot()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Read debugger output:
            QString debuggerOutput = debuggerHandler.readAllStandardOutput();

            // Append last output of the debugger to
            // the accumulated debugger output:
            debuggerAccumulatedOutput.append(debuggerOutput);

            qDebug() << QDateTime::currentMSecsSinceEpoch()
                     << "msecs from epoch: output from Perl debugger received.";
//            qDebug() << "Debugger raw output:\n"
//                     << debuggerOutput;
//            qDebug() << "===============";

            // Formatting of Perl debugger output is started only after
            // the final command prompt comes out of the debugger:
            if (debuggerJustStarted == true) {
                if ((debuggerLastCommand.length() > 0) and
                        (debuggerAccumulatedOutput.contains(
                             QRegExp ("DB\\<\\d{1,5}\\>.*DB\\<\\d{1,5}\\>")))) {
                    debuggerJustStarted = false;
                    qDebuggerStartHtmlFormatter();
                }


                if ((debuggerLastCommand.length() == 0) and
                        (debuggerAccumulatedOutput
                         .contains(QRegExp ("DB\\<\\d{1,5}\\>")))) {
                    debuggerJustStarted = false;
                    qDebuggerStartHtmlFormatter();
                }
            }

            if ((debuggerJustStarted == false) and
                    (debuggerAccumulatedOutput
                     .contains(QRegExp ("DB\\<\\d{1,5}\\>")))) {
                qDebuggerStartHtmlFormatter();

            }
        }
    }

    void qDebuggerStartHtmlFormatter()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            scriptEnvironment.insert("REQUEST_METHOD", "POST");
            QString debuggerDataSize =
                    QString::number(debuggerAccumulatedOutput.size());
            scriptEnvironment.insert("CONTENT_LENGTH", debuggerDataSize);

            debuggerOutputHandler.setProcessEnvironment(scriptEnvironment);

            debuggerOutputFormatterScript
                    .replace("SCRIPT", debuggerScriptToDebugFilePath);
            debuggerOutputFormatterScript
                    .replace("DEBUGGER_COMMAND", debuggerLastCommand);

            debuggerOutputHandler
                    .start((qApp->property("perlInterpreter")
                            .toString()),
                           QStringList()
                           << "-e"
                           << debuggerOutputFormatterScript,
                           QProcess::Unbuffered
                           | QProcess::ReadWrite);

            QByteArray debuggerAccumulatedOutputArray;
            debuggerAccumulatedOutputArray
                    .append(debuggerAccumulatedOutput);
            debuggerOutputHandler.write(debuggerAccumulatedOutputArray);

            scriptEnvironment.remove("REQUEST_METHOD");
            scriptEnvironment.remove("CONTENT_LENGTH");
            debuggerAccumulatedOutput = "";

            qDebug() << QDateTime::currentMSecsSinceEpoch()
                     << "msecs from epoch:"
                     << "Perl debugger output formatter script started.";
            qDebug() << "===============";
        }
    }

    void qDebuggerHtmlFormatterOutputSlot()
    {
        QString debuggerHtmlOutput =
                debuggerOutputHandler.readAllStandardOutput();

        // Append last output of the debugger formatter to
        // the accumulated debugger formatter output:
        debuggerAccumulatedHtmlOutput.append(debuggerHtmlOutput);

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "output from Perl debugger formatter received.";
        qDebug() << "===============";
    }

    void qDebuggerHtmlFormatterErrorsSlot()
    {
        QString debuggerOutputFormatterErrors =
                debuggerOutputHandler.readAllStandardError();

        qDebug() << "Perl debugger formatter script error:"
                 << debuggerOutputFormatterErrors;
        qDebug() << "===============";
    }

    void qDebuggerHtmlFormatterFinishedSlot()
    {
        targetFrame->setHtml(debuggerAccumulatedHtmlOutput,
                              QUrl(PSEUDO_DOMAIN));

        debuggerOutputHandler.close();
        debuggerAccumulatedHtmlOutput = "";

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "output from Perl debugger formatter displayed.";
        qDebug() << "===============";
    }

public:
    QPage();
    QString scriptFullFilePath;
    QProcess scriptHandler;
    QStringList runningScriptsInCurrentWindowList;
    QString checkUserInputBeforeQuitJavaScript;

protected:
    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType type);

    virtual void javaScriptAlert(QWebFrame *frame, const QString &msg)
    {
        Q_UNUSED(frame);

        QMessageBox javaScriptAlertMessageBox (qApp->activeWindow());
        javaScriptAlertMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptAlertMessageBox.setWindowTitle(tr("Alert"));
        javaScriptAlertMessageBox
                .setIconPixmap((qApp->property("icon").toString()));
        javaScriptAlertMessageBox.setText(msg);
        javaScriptAlertMessageBox.setButtonText(QMessageBox::Yes, tr("Yes"));
        javaScriptAlertMessageBox.setDefaultButton(QMessageBox::Yes);
        javaScriptAlertMessageBox.exec();
    }

    virtual bool javaScriptConfirm(QWebFrame *frame, const QString &msg)
    {
        Q_UNUSED(frame);

        QMessageBox javaScriptConfirmMessageBox (qApp->activeWindow());
        javaScriptConfirmMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptConfirmMessageBox.setWindowTitle(tr("Confirm"));
        javaScriptConfirmMessageBox
                .setIconPixmap((qApp->property("icon").toString()));
        javaScriptConfirmMessageBox.setText(msg);
        javaScriptConfirmMessageBox
                .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::Yes, tr("Yes"));
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::No, tr("No"));
        javaScriptConfirmMessageBox.setDefaultButton(QMessageBox::No);
        return QMessageBox::Yes == javaScriptConfirmMessageBox.exec();
    }

    virtual bool javaScriptPrompt(QWebFrame *frame,
                                  const QString &msg,
                                  const QString &defaultValue,
                                  QString *result)
    {
        Q_UNUSED(frame);

        bool ok = false;
        QString x = QInputDialog::getText(qApp->activeWindow(),
                                          tr("Prompt"),
                                          msg,
                                          QLineEdit::Normal,
                                          defaultValue,
                                          &ok);
        if (ok && result) {
            *result = x;
        }
        return ok;
    }

private:
    QString userAgentForUrl(const QUrl &url) const
    {
        Q_UNUSED(url);
        return (qApp->property("userAgent").toString());
    }

    QWebView *newWindow;
    QWebFrame *targetFrame;

    QString cssLinkedHtml;
    QString httpHeadersCleanedHtml;

    QProcessEnvironment scriptEnvironment;
    bool scriptTimedOut;
    bool scriptKilled;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
    bool scriptOutputThemeEnabled;
    QString scriptOutputType;

    QStringList sourceViewerMandatoryCommandLine;

    QWebView *debuggerNewWindow;
    bool debuggerJustStarted;
    QString debuggerScriptToDebugFilePath;
    QString debuggerLastCommand;
    QProcess debuggerHandler;
    QString debuggerOutputFormatterScript;
    QProcess debuggerOutputHandler;
    QString debuggerAccumulatedOutput;
    QString debuggerAccumulatedHtmlOutput;

    QPixmap icon;
};

// ==============================
// WEB VIEW CLASS DEFINITION:
// ==============================
class QTopLevel : public QWebView
{
    Q_OBJECT

signals:
    void trayIconHideSignal();

public slots:
    void qLoadStartPageSlot()
    {
        QFileDetector fileDetector;
        fileDetector
                .qDefineInterpreter((qApp->property("startPage").toString()));

        if (fileDetector.interpreter.contains("browser-html")) {
            setUrl(QUrl::fromLocalFile
                   (QDir::toNativeSeparators
                    ((qApp->property("startPage").toString()))));
        } else {
            setUrl(QUrl("http://" + QString(PSEUDO_DOMAIN) + "/"
                        + (qApp->property("startPagePath").toString())));
        }
    }

    void qPageLoadedDynamicTitleSlot(bool ok)
    {
        if (ok) {
            setWindowTitle(QTopLevel::title());
        }
    }

    void qStartPrintPreviewSlot()
    {
#ifndef QT_NO_PRINTER
        QPrinter printer(QPrinter::HighResolution);
        QPrintPreviewDialog preview(&printer, this);
        preview.setWindowModality(Qt::WindowModal);
        preview.setMinimumSize(QDesktopWidget()
                               .screen()->rect().width() * 0.8,
                               QDesktopWidget()
                               .screen()->rect().height() * 0.8);
        connect(&preview, SIGNAL(paintRequested(QPrinter*)),
                SLOT(qPrintPreviewSlot(QPrinter*)));
        preview.exec();
#endif
    }

    void qPrintPreviewSlot(QPrinter *printer)
    {
#ifdef QT_NO_PRINTER
        Q_UNUSED(printer);
#else
        QTopLevel::print(printer);
#endif
    }

    void qPrintSlot()
    {
#ifndef QT_NO_PRINTER

        qDebug() << "Printing requested.";
        qDebug() << "===============";

        QPrinter printer;
        printer.setOrientation(QPrinter::Portrait);
        printer.setPageSize(QPrinter::A4);
        printer.setPageMargins(10, 10, 10, 10, QPrinter::Millimeter);
        printer.setResolution(QPrinter::HighResolution);
        printer.setColorMode(QPrinter::Color);
        printer.setPrintRange(QPrinter::AllPages);
        printer.setNumCopies(1);

        QPrintDialog *printDialog = new QPrintDialog(&printer);
        printDialog->setWindowModality(Qt::WindowModal);
        QSize dialogSize = printDialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        printDialog->move(QPoint((screenRect.width() / 2)
                                 - (dialogSize.width() / 2),
                                 (screenRect.height() / 2)
                                 - (dialogSize.height() / 2)));
        if (printDialog->exec() == QDialog::Accepted) {
            QTopLevel::print(&printer);
        }
        printDialog->close();
        printDialog->deleteLater();
#endif
    }

    void qSaveAsPdfSlot()
    {
#ifndef QT_NO_PRINTER

        qDebug() << "Save as PDF requested.";

        QFileDialog saveAsPdfDialog (qApp->activeWindow());
        saveAsPdfDialog.setFileMode(QFileDialog::AnyFile);
        saveAsPdfDialog.setViewMode(QFileDialog::Detail);
        saveAsPdfDialog.setWindowModality(Qt::WindowModal);
        QString fileName = saveAsPdfDialog.getSaveFileName(
                    qApp->activeWindow(),
                    tr("Save as PDF"),
                    QDir::currentPath(),
                    tr("PDF files (*.pdf)"));
        saveAsPdfDialog.close();
        saveAsPdfDialog.deleteLater();

        if (!fileName.isEmpty()) {
            if (QFileInfo(fileName).suffix().isEmpty()) {
                fileName.append(".pdf");
            }

            qDebug() << "PDF file:" << fileName;

            QPrinter pdfPrinter;
            pdfPrinter.setOrientation(QPrinter::Portrait);
            pdfPrinter.setPageSize(QPrinter::A4);
            pdfPrinter.setPageMargins(10, 10, 10, 10, QPrinter::Millimeter);
            pdfPrinter.setResolution(QPrinter::HighResolution);
            pdfPrinter.setColorMode(QPrinter::Color);
            pdfPrinter.setPrintRange(QPrinter::AllPages);
            pdfPrinter.setNumCopies(1);
            pdfPrinter.setOutputFormat(QPrinter::PdfFormat);
            pdfPrinter.setOutputFileName(fileName);
            QTopLevel::print(&pdfPrinter);
        }

        qDebug() << "===============";
#endif
    }

    void qReloadSlot()
    {
        QUrl currentUrl = mainPage->mainFrame()->url();
        setUrl(currentUrl);
        raise();
    }

    void qEditSlot()
    {
        QString fileToEdit = QDir::toNativeSeparators(
                    (qApp->property("rootDirName").toString())
                    + qWebHitTestURL.path());
        fileToEdit.replace("//", "/");

        qDebug() << "File to edit:" << fileToEdit;
        qDebug() << "===============";

        QProcess externalEditor;
        externalEditor
                .startDetached("/usr/bin/scite",
                               QStringList() << fileToEdit);
    }

    void qViewSourceFromContextMenuSlot()
    {
        newWindow = new QTopLevel();
        QString iconPathName = qApp->property("iconPathName").toString();
        QPixmap icon;
        icon.load(iconPathName);
        newWindow->setWindowIcon(icon);

        QUrlQuery viewSourceUrlQuery;
        viewSourceUrlQuery.addQueryItem(QString("source"), QString("enabled"));
        QUrl viewSourceUrl = qWebHitTestURL;
        viewSourceUrl.setQuery(viewSourceUrlQuery);

        qDebug() << "Local script to view as source code:"
                 << qWebHitTestURL.toString();
        qDebug() << "===============";

        newWindow->setUrl(viewSourceUrl);
        newWindow->show();
    }

    void qOpenInNewWindowSlot()
    {
        newWindow = new QTopLevel();
        QString iconPathName = qApp->property("iconPathName").toString();
        QPixmap icon;
        icon.load(iconPathName);
        newWindow->setWindowIcon(icon);

        qDebug() << "Link to open in a new window:"
                 << qWebHitTestURL.toString();
        qDebug() << "===============";

        QString fileToOpen = QDir::toNativeSeparators
                ((qApp->property("rootDirName").toString())
                 + qWebHitTestURL.path());

        QFileDetector fileDetector;
        fileDetector.qDefineInterpreter(fileToOpen);

        if (fileDetector.interpreter.contains("browser-html")) {
            newWindow->setUrl(QUrl::fromLocalFile(fileToOpen));
        } else {
            newWindow->setUrl(qWebHitTestURL);
        }
        newWindow->show();
    }

    void qDisplayErrorsSlot(QString errors)
    {
        errorsWindow = new QTopLevel();
        errorsWindow->setHtml(errors, QUrl(PSEUDO_DOMAIN));
        errorsWindow->setFocus();
        errorsWindow->show();

    }

    void contextMenuEvent(QContextMenuEvent *event)
    {
        QWebHitTestResult qWebHitTestResult =
                mainPage->mainFrame()->hitTestContent(event->pos());

        QMenu *menu = mainPage->createStandardContextMenu();

        if (!qWebHitTestResult.linkUrl().isEmpty()) {
            qWebHitTestURL = qWebHitTestResult.linkUrl();

            if (qWebHitTestURL.authority() == PSEUDO_DOMAIN and
                    (!qWebHitTestURL.fileName().contains(".function"))) {

                menu->addSeparator();

                QAction *editAct = menu->addAction(tr("&Edit"));
                QObject::connect(editAct, SIGNAL(triggered()),
                                 this, SLOT(qEditSlot()));

                QString fileToOpen = QDir::toNativeSeparators
                        ((qApp->property("rootDirName").toString())
                         + qWebHitTestURL.path());
                fileToOpen.replace("//", "/");

                QFileDetector fileDetector;
                fileDetector.qDefineInterpreter(fileToOpen);

                if ((!fileDetector.interpreter.contains("browser")) and
                        (!fileDetector.interpreter.contains("undefined"))) {
                    QAction *viewSourceAct =
                            menu->addAction(tr("&View Source"));
                    QObject::connect(viewSourceAct,
                                     SIGNAL(triggered()),
                                     this,
                                     SLOT(qViewSourceFromContextMenuSlot()));
                }
            }

            if (qWebHitTestURL.authority() == PSEUDO_DOMAIN and
                    (!qWebHitTestURL.fileName().contains(".function"))) {

                QAction *openInNewWindowAct =
                        menu->addAction(tr("&Open in new window"));
                QObject::connect(openInNewWindowAct, SIGNAL(triggered()),
                                 this, SLOT(qOpenInNewWindowSlot()));
            }
        }

        if (!qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty() and
                (!qWebHitTestResult.isContentSelected())) {

            menu->addSeparator();

            if ((qApp->property("goHomeCapability").toString()) == "enable") {
                if (mainPage->runningScriptsInCurrentWindowList.length() == 0) {
                    QAction *homeAct = menu->addAction(tr("&Home"));
                    QObject::connect(homeAct, SIGNAL(triggered()),
                                     this, SLOT(qLoadStartPageSlot()));
                }
            }

            if ((qApp->property("reloadCapability").toString()) == "enable") {
                if (mainPage->runningScriptsInCurrentWindowList.length() == 0 or
                        QTopLevel::url().toString().length() > 0) {
                    QAction *reloadAct = menu->addAction(tr("&Reload"));
                    QObject::connect(reloadAct, SIGNAL(triggered()),
                                     this, SLOT(qReloadSlot()));
                }
            }

            QAction *printPreviewAct = menu->addAction(tr("Print pre&view"));
            QObject::connect(printPreviewAct, SIGNAL(triggered()),
                             this, SLOT(qStartPrintPreviewSlot()));

            QAction *printAct = menu->addAction(tr("&Print"));
            QObject::connect(printAct, SIGNAL(triggered()),
                             this, SLOT(qPrintSlot()));

            QAction *saveAsPdfAct = menu->addAction(tr("Save as P&DF"));
            QObject::connect(saveAsPdfAct, SIGNAL(triggered()),
                             this, SLOT(qSaveAsPdfSlot()));

            menu->addSeparator();

            QAction *aboutAction = menu->addAction(tr("&About"));
            QObject::connect(aboutAction, SIGNAL(triggered()),
                             this, SLOT(qAboutSlot()));

            QAction *aboutQtAction = menu->addAction(tr("About Q&t"));
            QObject::connect(aboutQtAction, SIGNAL(triggered()),
                             qApp, SLOT(aboutQt()));
        }

        menu->exec(mapToGlobal(event->pos()));
    }

    void qMaximizeSlot()
    {
        raise();
        showMaximized();
    }

    void qToggleFullScreenSlot()
    {
        if (isFullScreen()) {
            showMaximized();
        } else {
            showFullScreen();
        }
    }

    void qAboutSlot()
    {
        QString qtVersion = QT_VERSION_STR;
        QByteArray license;
        license.append("This program is free software;<br>");
        license.append("you can redistribute it and/or modify it<br>");
        license.append("under the terms of ");
        license.append("the GNU General Public License,<br>");
        license.append("as published by the Free Software Foundation;<br>");
        license.append("either version 3 of the License,<br>");
        license.append("or (at your option) any later version.");
        license.append("<br><br>");
        license.append("This program is distributed ");
        license.append("in the hope that it will be useful,<br>");
        license.append("but WITHOUT ANY WARRANTY;<br>");
        license.append("without even the implied warranty of<br>");
        license.append("MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.");
        QByteArray authors;
        authors.append("Dimitar D. Mitov, 2013 - 2016,<br>");
        authors.append("Valcho Nedelchev, 2014 - 2016.");
        QString aboutText =
                (qApp->applicationName()+ tr(" version ")
                 + qApp->applicationVersion() + "<br>"
                 + "Qt" + tr(" version ") + qtVersion
                 + "<br><br>"
                 + tr(license)
                 + "<br><br>"
                 + tr(authors)
                 + "<br><br>"
                 + "<a href="
                 + "'https://github.com/ddmitov/perl-executing-browser'>"
                 + "https://github.com/ddmitov/perl-executing-browser</a><br>");

        QMessageBox aboutMessageBox (qApp->activeWindow());
        QSpacerItem *horizontalSpacer =
                new QSpacerItem(500, 0,
                                QSizePolicy::Minimum, QSizePolicy::Expanding);
        aboutMessageBox.setWindowTitle("About " + qApp->applicationName());
        aboutMessageBox.setIconPixmap(qApp->property("icon").toString());
        aboutMessageBox.setText(aboutText);
        QGridLayout *layout = (QGridLayout*)aboutMessageBox.layout();
        layout->addItem(horizontalSpacer,
                        layout->rowCount(), 0, 1,
                        layout->columnCount());
        aboutMessageBox.setDefaultButton(QMessageBox::Ok);
        aboutMessageBox.exec();
    }

    void closeEvent(QCloseEvent *event)
    {
        if (mainPage->scriptHandler.isOpen()) {
            QMessageBox confirmExitMessageBox (qApp->activeWindow());
            confirmExitMessageBox.setWindowModality(Qt::WindowModal);
            confirmExitMessageBox.setWindowTitle(tr("Close window"));
            confirmExitMessageBox
                    .setIconPixmap((qApp->property("icon").toString()));
            confirmExitMessageBox
                    .setText(
                        tr("You are going to close this window,")
                        + "<br>"
                        + tr("but a script is still running.")
                        + "<br>"
                        + tr("Are you sure?"));
            confirmExitMessageBox
                    .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
            confirmExitMessageBox.setButtonText(QMessageBox::Yes, tr("Yes"));
            confirmExitMessageBox.setButtonText(QMessageBox::No, tr("No"));
            confirmExitMessageBox.setDefaultButton(QMessageBox::No);
            if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                mainPage->scriptHandler.close();
                event->accept();
                windowClosingStarted = true;
            } else {
                event->ignore();
            }
        } else {
            if (qApp->property("warnOnExit").toString() ==
                    "if-text-is-entered") {
                QVariant jsQuitDecision =
                        mainPage->currentFrame()->evaluateJavaScript(
                            "checkUserInputBeforeQuit()");
                QString qtQuitDecision = jsQuitDecision.toString();

                if (qtQuitDecision.length() > 0) {
                    if (qtQuitDecision == "yes") {
                        event->accept();
                        windowClosingStarted = true;
                    }
                    if (qtQuitDecision == "no") {
                        event->ignore();
                    }
                }

                if (qtQuitDecision.length() == 0) {
                    mainPage->currentFrame()->evaluateJavaScript(
                                mainPage->checkUserInputBeforeQuitJavaScript);
                    QVariant jsQuitDecision =
                            mainPage->currentFrame()->evaluateJavaScript(
                                "checkUserInputBeforeQuit()");
                    QString qtQuitDecision = jsQuitDecision.toString();

                    if (qtQuitDecision == "yes") {
                        event->accept();
                        windowClosingStarted = true;
                    }
                    if (qtQuitDecision == "no") {
                        event->ignore();
                    }
                }
            }

            if (qApp->property("warnOnExit").toString() == "always") {
                QMessageBox confirmExitMessageBox (qApp->activeWindow());
                confirmExitMessageBox.setWindowModality(Qt::WindowModal);
                confirmExitMessageBox.setWindowTitle(tr("Close window"));
                confirmExitMessageBox
                        .setIconPixmap((qApp->property("icon").toString()));
                confirmExitMessageBox
                        .setText(
                            tr("You are going to close this window.")
                            + "<br>"
                            + tr("Are you sure?"));
                confirmExitMessageBox
                        .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
                confirmExitMessageBox
                        .setButtonText(QMessageBox::Yes, tr("Yes"));
                confirmExitMessageBox
                        .setButtonText(QMessageBox::No, tr("No"));
                confirmExitMessageBox.setDefaultButton(QMessageBox::No);
                if (confirmExitMessageBox.exec() == QMessageBox::Yes) {
                    event->accept();
                    windowClosingStarted = true;
                } else {
                    event->ignore();
                }
            }
        }
    }

    void qExitApplicationSlot()
    {
        // Temporary folder removal:
        QDir tempDir(qApp->property("applicationTempDirectory").toString());
        tempDir.removeRecursively();

        if ((qApp->property("systrayIcon").toString()) == "enable") {
            emit trayIconHideSignal();
        }

        QString dateTimeString =
                QDateTime::currentDateTime()
                .toString("dd.MM.yyyy hh:mm:ss");
        qDebug() << qApp->applicationName().toLatin1().constData()
                 << qApp->applicationVersion().toLatin1().constData()
                 << "terminated normally on:" << dateTimeString;
        qDebug() << "===============";

        QApplication::exit();
    }

    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        foreach (QSslError error, errors) {
            qDebug() << "SSL error: " << error;
        }

        reply->ignoreSslErrors();
    }

public:
    QTopLevel();

    QWebView *createWindow(QWebPage::WebWindowType type)
    {
        qDebug() << "New window requested.";

        Q_UNUSED(type);
        QWebView *window = new QTopLevel();
        window->setWindowIcon(icon);
        window->setAttribute(Qt::WA_DeleteOnClose, true);
        window->show();

        return window;
    }

private:
    QPage *mainPage;
    QWebView *newWindow;
    QWebView *errorsWindow;

    QUrl qWebHitTestURL;
    QPixmap icon;
    bool windowClosingStarted;
};

#endif // PEB_H
