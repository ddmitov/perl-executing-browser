/*
 Perl Executing Browser

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU Lesser General Public License,
 as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2016
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef PEB_H
#define PEB_H

#include <QApplication>
#include <QMainWindow>
#include <QtNetwork/QNetworkAccessManager>
#include <QMimeDatabase>
#include <QNetworkReply>
#include <QtWebKit>
#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QWebInspector>
#include <QProcess>
#include <QFileDialog>
#include <QInputDialog>
#include <QMessageBox>
#include <QMenu>
#include <QDesktopWidget>
#include <qglobal.h>

#include <QMenu>

// ==============================
// PRINT SUPPORT:
// ==============================
#ifndef QT_NO_PRINTER
#include <QPrintPreviewDialog>
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#endif

// ==============================
// PSEUDO-DOMAIN:
// ==============================
#ifndef PSEUDO_DOMAIN
#define PSEUDO_DOMAIN "local-pseudodomain"
#endif

// ==============================
// FILE READER CLASS DEFINITION:
// Usefull for both files inside binary resources and files on disk
// ==============================
class QFileReader : public QObject
{
    Q_OBJECT

public:
    QFileReader(QString filePath);
    QString fileContents;
};

// ==============================
// MAIN WINDOW CLASS DEFINITION:
// ==============================
class QMainBrowserWindow : public QMainWindow
{
    Q_OBJECT

signals:
    void initiateMainWindowClosingSignal();

public slots:
    void setMainWindowTitleSlot(QString title)
    {
        setWindowTitle(title);
    }

    void closeEvent(QCloseEvent *event)
    {
        if (qApp->property("mainWindowCloseRequested").toBool() == false) {
            event->ignore();
            emit initiateMainWindowClosingSignal();
        }

        if (qApp->property("mainWindowCloseRequested").toBool() == true) {
            event->accept();
        }
    }

public:
    explicit QMainBrowserWindow(QWidget *parent = 0);
    QWebView *webViewWidget;
};

// ==============================
// SCRIPT HANDLER:
// ==============================
class QScriptHandler : public QObject
{
    Q_OBJECT

signals:
    void displayScriptOutputSignal(QString output, QString scriptStdoutTarget);
    void scriptFinishedSignal(QString scriptAccumulatedOutput,
                              QString scriptAccumulatedErrors,
                              QString scriptId,
                              QString scriptFullFilePath,
                              QString scriptStdoutTarget);

public slots:
    void qScriptOutputSlot()
    {
        QString output = scriptProcess.readAllStandardOutput();
        scriptAccumulatedOutput.append(output);

        qInfo() << QDateTime::currentMSecsSinceEpoch()
                << "msecs from epoch: Output from" << scriptFullFilePath;

        // Handling 'script closed' confirmation:
        if (output == scriptClosedConfirmation) {
            qInfo() << "Interactive script terminated normally:"
                    << scriptFullFilePath;
        } else {
            if (scriptStdoutTarget.length() > 0) {
                emit displayScriptOutputSignal(output, scriptStdoutTarget);
            }
        }
    }

    void qScriptErrorsSlot()
    {
        QString scriptErrors = scriptProcess.readAllStandardError();
        scriptAccumulatedErrors.append(scriptErrors);
        scriptAccumulatedErrors.append("\n");

        qInfo() << QDateTime::currentMSecsSinceEpoch()
                << "msecs from epoch: Errors from" << scriptFullFilePath;

        // qDebug() << "Script errors:" << scriptErrors;
    }

    void qScriptFinishedSlot()
    {
        emit scriptFinishedSignal(scriptAccumulatedOutput,
                                  scriptAccumulatedErrors,
                                  scriptId,
                                  scriptFullFilePath,
                                  scriptStdoutTarget);

        scriptProcess.close();

        qInfo() << "Script finished:" << scriptFullFilePath;
    }

    void qRootPasswordTimeoutSlot()
    {
        qApp->setProperty("rootPassword", "");
    }

public:
    QScriptHandler(QUrl url, QByteArray postDataArray);
    QString scriptId;
    QString scriptFullFilePath;
    QProcess scriptProcess;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
    QString scriptCloseCommand;
    QString scriptClosedConfirmation;

private:
    QString scriptStdoutTarget;
    QString scriptUser;
};

// ==============================
// CUSTOM NETWORK REPLY CLASS DEFINITION:
// ==============================
class QCustomNetworkReply : public QNetworkReply
{
    Q_OBJECT

public:

    QCustomNetworkReply(
            const QUrl &url, const QString &data, const QString &mime);
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
// NETWORK ACCESS MANAGER
// CLASS DEFINITION:
// ==============================
class QAccessManager : public QNetworkAccessManager
{
    Q_OBJECT

signals:
    void startScriptSignal(QUrl url, QByteArray postDataArray);
    void closeWindowSignal();

protected:
    virtual QNetworkReply *createRequest(Operation operation,
                                         const QNetworkRequest &request,
                                         QIODevice *outgoingData = 0)
    {
        // ==============================
        // Starting local AJAX Perl scripts is prohibited if
        // untrusted content is loaded in the same window:
        // ==============================
        if ((operation == GetOperation or
             operation == PostOperation) and
                request.url().host() == PSEUDO_DOMAIN and
                request.url().userName() == "ajax" and
                pageStatus == "untrusted") {

            QString errorMessage =
                    "Calling local Perl scripts after "
                    "untrusted content is loaded is prohibited.<br>"
                    "Go to start page to unlock local Perl scripts.";
            qInfo() << "Local AJAX Perl script called after"
                    << "untrusted content is loaded:"
                    << request.url().toString();

            QCustomNetworkReply *reply =
                    new QCustomNetworkReply (
                        request.url(), errorMessage, emptyString);
            return reply;
        }

        // ==============================
        // Local AJAX GET and POST requests:
        // ==============================
        if ((operation == GetOperation or
             operation == PostOperation) and
                request.url().host() == PSEUDO_DOMAIN and
                request.url().userName() == "ajax" and
                pageStatus == "trusted") {

            QString ajaxScriptFullFilePath = QDir::toNativeSeparators
                    ((qApp->property("application").toString())
                     + request.url().path());

            QFile file(ajaxScriptFullFilePath);
            if (file.exists()) {
                QByteArray postDataArray;
                if (outgoingData) {
                    postDataArray = outgoingData->readAll();
                }

                QScriptHandler *ajaxScriptHandler =
                        new QScriptHandler(
                            request.url(), postDataArray);

                // Non-blocking event loop waiting for
                // AJAX script output and errors:
                QEventLoop ajaxScriptHandlerWaitingLoop;

                // Signal and slot for reading output and errors from
                // all local AJAX Perl scripts:
                QObject::connect(ajaxScriptHandler,
                                 SIGNAL(scriptFinishedSignal(QString,
                                                             QString,
                                                             QString,
                                                             QString,
                                                             QString)),
                                 &ajaxScriptHandlerWaitingLoop,
                                 SLOT(quit()));

                ajaxScriptHandlerWaitingLoop.exec();

                QString ajaxScriptOutput =
                        ajaxScriptHandler->scriptAccumulatedOutput;

                QString ajaxScriptErrors =
                        ajaxScriptHandler->scriptAccumulatedErrors;

                if (ajaxScriptOutput.length() == 0 and
                        ajaxScriptErrors == 0) {
                    qDebug() << "AJAX script timed out or gave no output:"
                             << ajaxScriptFullFilePath;
                }

                if (ajaxScriptErrors.length() > 0) {
                    qDebug() << "AJAX script errors:";
                    QStringList scriptErrors =
                            ajaxScriptErrors.split("\n");
                    foreach (QString scriptError, scriptErrors) {
                        if (scriptError.length() > 0) {
                            qDebug() << scriptError;
                        }
                    }
                }

                QCustomNetworkReply *reply =
                        new QCustomNetworkReply (
                            request.url(), ajaxScriptOutput, emptyString);
                return reply;
            } else {
                qInfo() << "File not found:" << ajaxScriptFullFilePath;

                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                QString errorMessage =
                        "<p>File not found:<br>"
                        + ajaxScriptFullFilePath + "</p>";
                htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

                QString mimeType = "text/html";

                QCustomNetworkReply *reply =
                        new QCustomNetworkReply (
                            request.url(), htmlErrorContents, mimeType);
                return reply;
            }
        }

        // ==============================
        // GET requests to the browser pseudodomain:
        // local files and non-AJAX scripts:
        // ==============================
        if (operation == GetOperation and
                request.url().host() == PSEUDO_DOMAIN and
                (request.url().userName() != "ajax") and
                (!request.url().path().contains(".function"))) {

            // Compose the full file path:
            QString fullFilePath = QDir::toNativeSeparators
                    ((qApp->property("application").toString())
                     + request.url().path());

            // Check if file exists:
            QFile file(fullFilePath);
            if (file.exists()) {
                // Get the MIME type of the local file:
                QMimeDatabase mimeDatabase;
                QMimeType type = mimeDatabase.mimeTypeForFile(fullFilePath);
                // qDebug() << "MIME type:" << type.name();
                QString mimeType = type.name();

                // Handle local Perl scripts:
                if (mimeType == "application/x-perl") {
                    // Start local Perl scripts only if
                    // no untrusted content is loaded in the same window:
                    if (pageStatus == "trusted") {
                        QByteArray emptyPostDataArray;
                        emit startScriptSignal(
                                    request.url(), emptyPostDataArray);

                        QCustomNetworkReply *reply =
                                new QCustomNetworkReply (
                                    request.url(), emptyString, emptyString);
                        return reply;
                    }

                    // If an attempt is made to start local Perl scripts after
                    // untrusted content is loaded in the same window,
                    //  an error page is displayed:
                    if (pageStatus == "untrusted") {
                        QString errorMessage =
                                "<p>Calling local Perl scripts after "
                                "untrusted content is loaded in "
                                "the same window is prohibited.<br>"
                                "Go to <a href='" +
                                qApp->property("startPage").toString() +
                                "'>start page</a> "
                                "to unlock local Perl scripts.</p>";
                        qInfo() << "Local Perl script called after"
                                << "untrusted content was loaded:"
                                << request.url().toString();

                        QFileReader *resourceReader =
                                new QFileReader(QString(":/html/error.html"));
                        QString htmlErrorContents =
                                resourceReader->fileContents;

                        htmlErrorContents
                                .replace("ERROR_MESSAGE", errorMessage);

                        QString mimeType = "text/html";

                        QCustomNetworkReply *reply =
                                new QCustomNetworkReply (
                                    request.url(), htmlErrorContents, mimeType);
                        return reply;
                    }
                }

                // Handle other supported local files:
                if (mimeType == "text/html" or
                        mimeType == "text/xml" or
                        mimeType == "text/css" or
                        mimeType == "application/javascript" or
                        mimeType == "application/json" or
                        mimeType == "image/gif" or
                        mimeType == "image/jpeg" or
                        mimeType == "image/png" or
                        mimeType == "image/svg+xml" or
                        mimeType == "application/vnd.ms-fontobject" or
                        mimeType == "application/x-font-ttf" or
                        mimeType == "application/font-sfnt" or
                        mimeType.contains("application/font-woff")) {

                    qInfo() << "Local link requested:"
                            << request.url().toString();

                    QFileReader *resourceReader =
                            new QFileReader(QString(fullFilePath));
                    QString fileContents = resourceReader->fileContents;

                    QCustomNetworkReply *reply =
                            new QCustomNetworkReply (
                                request.url(), fileContents, mimeType);
                    return reply;
                } else {
                    qInfo() << "File type not supported:" << fullFilePath;

                    QDesktopServices::openUrl(
                                QUrl::fromLocalFile(fullFilePath));

                    QCustomNetworkReply *reply =
                            new QCustomNetworkReply (
                                request.url(), emptyString, emptyString);
                    return reply;
                }
            } else {
                qInfo() << "File not found:" << fullFilePath;

                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                QString errorMessage =
                        "<p>File not found:<br>" + fullFilePath + "</p>";
                htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

                QString mimeType = "text/html";

                QCustomNetworkReply *reply =
                        new QCustomNetworkReply (
                            request.url(), htmlErrorContents, mimeType);
                return reply;
            }
        }

        // ==============================
        // POST requests to the browser pseudodomain:
        // non-AJAX scripts:
        // ==============================
        if (operation == PostOperation and
                request.url().host() == PSEUDO_DOMAIN and
                (request.url().userName() != "ajax")) {

            if (outgoingData) {
                QByteArray postDataArray = outgoingData->readAll();
                emit startScriptSignal(request.url(), postDataArray);
            }

            QCustomNetworkReply *reply =
                    new QCustomNetworkReply (
                        request.url(), emptyString, emptyString);
            return reply;
        }

        // ==============================
        // Window closing URL:
        // ==============================
        if (operation == GetOperation and
                request.url().fileName() == "close-window.function" and
                pageStatus == "trusted") {
            emit closeWindowSignal();

            QCustomNetworkReply *reply =
                    new QCustomNetworkReply (
                        request.url(), emptyString, emptyString);
            return reply;
        }

        qInfo() << "Link requested:" << request.url().toString();

        return QNetworkAccessManager::createRequest
                (QNetworkAccessManager::GetOperation,
                 QNetworkRequest(request));
    }

public slots:
    void qPageStatusSlot(QString pageStatusTransmitted)
    {
        pageStatus = pageStatusTransmitted;
    }

private:
    QString emptyString;
    QStringList trustedDomains;
    QString pageStatus;
};

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
class QPage : public QWebPage
{
    Q_OBJECT

signals:
    void changeTitleSignal();
    void displayScriptErrorsSignal(QString errors);
    void printPreviewSignal();
    void printSignal();
    void selectInodeSignal(QNetworkRequest request);
    void pageStatusSignal(QString pageStatus);
    void closeAllScriptsSignal();
    void closeWindowSignal();

public slots:
    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            emit changeTitleSignal();
            qJavaScriptInjector(QPage::mainFrame());
        }
    }

    // ==============================
    // SCRIPT HANDLING:
    // ==============================
    void qHandleScriptSlot(QUrl url, QByteArray postDataArray)
    {
        QString scriptId = url.password() + "@" + url.path();

        if ((url.userName() == "interactive" and
             (!runningScripts.contains(scriptId))) or
                (url.userName() != "interactive")) {
            QScriptHandler *scriptHandler =
                    new QScriptHandler(url, postDataArray);

            QObject::connect(scriptHandler,
                             SIGNAL(displayScriptOutputSignal(QString,
                                                              QString)),
                             this,
                             SLOT(qDisplayScriptOutputSlot(QString,
                                                           QString)));
            QObject::connect(scriptHandler,
                             SIGNAL(scriptFinishedSignal(QString,
                                                         QString,
                                                         QString,
                                                         QString,
                                                         QString)),
                             this,
                             SLOT(qScriptFinishedSlot(QString,
                                                      QString,
                                                      QString,
                                                      QString,
                                                      QString)));

            if (url.userName() == "interactive") {
                runningScripts.insert(scriptId, scriptHandler);
            }
        }

        if (url.userName() == "interactive" and
                runningScripts.contains(scriptId) and
                postDataArray.length() > 0) {

            QScriptHandler *handler =
                    runningScripts.value(scriptId);
            if (handler->scriptProcess.isOpen()) {
                postDataArray.append(QString("\n").toLatin1());
                handler->scriptProcess.write(postDataArray);
            }
        }
    }

    void qDisplayScriptOutputSlot(QString output, QString stdoutTarget)
    {
        if (stdoutTarget.length() > 0) {
            qOutputInserter(output, stdoutTarget);
        } else {
            QPage::currentFrame()->setHtml(output, QUrl(PSEUDO_DOMAIN));
        }
    }

    void qScriptFinishedSlot(QString scriptAccumulatedOutput,
                             QString scriptAccumulatedErrors,
                             QString scriptId,
                             QString scriptFullFilePath,
                             QString scriptStdoutTarget)
    {
        runningScripts.remove(scriptId);

        if (pageStatus == "trusted") {
            // If script has no errors and
            // no STDOUT target:
            if (scriptAccumulatedOutput.length() > 0 and
                    scriptAccumulatedErrors.length() == 0 and
                    scriptStdoutTarget.length() == 0) {

                qDisplayScriptOutputSlot(scriptAccumulatedOutput, emptyString);
            }

            if (scriptAccumulatedErrors.length() > 0) {
                if (scriptAccumulatedOutput.length() == 0) {
                    if (scriptStdoutTarget.length() == 0) {
                        // If script has no output and
                        // only errors and
                        // no STDOUT target is defined,
                        // all HTML formatted errors will be displayed
                        // in the same window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            false);
                    } else {
                        // If script has no output and
                        // only errors and
                        // a STDOUT target is defined,
                        // all HTML formatted errors will be displayed
                        // in a new window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            true);
                    }
                } else {
                    // If script has some output and errors,
                    // HTML formatted errors will be displayed in a new window:
                    qFormatScriptErrors(scriptAccumulatedErrors,
                                        scriptFullFilePath,
                                        true);
                    qDisplayScriptOutputSlot(scriptAccumulatedOutput,
                                             emptyString);
                }
            }
        }

        if (windowCloseRequested == true and runningScripts.isEmpty()) {
            emit closeWindowSignal();
        }
    }

    void qOutputInserter(QString stdoutData, QString stdoutTarget)
    {
        QString outputInsertionJavaScript =
                "pebOutputInsertion(\"" +
                stdoutData +
                "\" , \"" +
                stdoutTarget +
                "\"); null";

        currentFrame()->evaluateJavaScript(outputInsertionJavaScript);
    }

    void qFormatScriptErrors(QString errors,
                             QString scriptFullFilePath,
                             bool newWindow)
    {
        QString scriptErrorTitle = "Errors were found during script execution:";

        errors.replace(QRegExp("\n\n$"), "\n");

        QString scriptError = scriptErrorTitle +
                "<br>" +
                scriptFullFilePath +
                "<br><br>" +
                "<pre>" +
                errors +
                "</pre>";

        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString scriptFormattedErrors = resourceReader->fileContents;

        scriptFormattedErrors.replace("ERROR_MESSAGE", scriptError);

        if (newWindow == false) {
            qDisplayScriptOutputSlot(scriptFormattedErrors, emptyString);
        }

        if (newWindow == true) {
            emit displayScriptErrorsSignal(scriptFormattedErrors);
        }
    }

    // ==============================
    // PAGE SECURITY:
    // ==============================
    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        reply->ignoreSslErrors();

        foreach (QSslError error, errors) {
            qDebug() << "SSL error:" << error;
        }
    }

    void qNetworkReply(QNetworkReply *reply)
    {
        QStringList trustedDomains =
                qApp->property("trustedDomains").toStringList();

        if (reply->error() != QNetworkReply::NoError) {
            qDebug() << "Network error:" << reply->errorString();

            if (reply->url().fileName().length() == 0 or
                    reply->url().userName() == "ajax") {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                htmlErrorContents
                        .replace("ERROR_MESSAGE",
                                 "<p>" + reply->errorString() + "</p>");
                QPage::currentFrame()->setHtml(htmlErrorContents);
            }
        }

        if (reply->error() == QNetworkReply::NoError) {
            if (reply->url() == qApp->property("startPage").toString()) {
                pageStatus = "trusted";
                emit pageStatusSignal(pageStatus);
            }

            if (pageStatus.length() == 0) {
                if (trustedDomains.contains(reply->url().host())) {
                    pageStatus = "trusted";
                    emit pageStatusSignal(pageStatus);
                }

                if (!trustedDomains.contains(reply->url().host())) {
                    pageStatus = "untrusted";
                    emit pageStatusSignal(pageStatus);
                }
            }

            if (pageStatus == "trusted") {
                if (!trustedDomains.contains(reply->url().host())) {
                    qMixedContentWarning(reply->url());
                }
            }
        }
    }

    void qMixedContentWarning(QUrl url)
    {
        QString errorMessage =
                "<p>Mixed content is detected.<br>"
                "Offending URL:<br>" +
                url.toString() + "<br>"
                "Mixing trusted and untrusted content is prohibited.<br>"
                "Go to <a href='" +
                qApp->property("startPage").toString() +
                "'>start page</a> "
                "to unlock local scripting.</p>";
        qWarning() << "Mixed content is detected. Offending URL:"
                   << url.toString();

        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
        QPage::mainFrame()->setHtml(htmlErrorContents);
    }

    // ==============================
    // CUSTOM-JAVASCRIPT-INJECTING ROUTINES:
    // ==============================
    void qFrameCustomizerSlot(QWebFrame *frame)
    {
        qJavaScriptInjector(frame);
    }

    void qJavaScriptInjector(QWebFrame *frame)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/scripts/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        frame->evaluateJavaScript(pebJavaScript);
    }

    // ==============================
    // PAGE-CLOSING ROUTINES:
    // ==============================
    void qInitiateWindowClosingSlot()
    {
        if (mainFrame()->childFrames().length() > 0) {
            foreach (QWebFrame *frame, mainFrame()->childFrames()) {
                qFrameIterator(frame);
            }
        } else {
            qCheckUserInputBeforeClose(mainFrame());
        }
    }

    void qFrameIterator(QWebFrame *frame)
    {
        if (frame->childFrames().length() > 0) {
            qCheckUserInputBeforeClose(frame);
            foreach (QWebFrame *frame, frame->childFrames()) {
                qFrameIterator(frame);
            }
        } else {
            qCheckUserInputBeforeClose(frame);
        }
    }

    void qCheckUserInputBeforeClose(QWebFrame *frame)
    {
        qJavaScriptInjector(frame);

        QVariant checkUserInputJsResult =
                frame->evaluateJavaScript("pebCheckUserInputBeforeClose()");
        bool textIsEntered = checkUserInputJsResult.toBool();

        QVariant checkCloseWarningJsResult =
                frame->evaluateJavaScript("pebCheckCloseWarning()");
        QString closeWarning = checkCloseWarningJsResult.toString();

        if (textIsEntered == true) {
            if (closeWarning == "async") {
                frame->evaluateJavaScript("pebCloseConfirmationAsync()");
            }

            if (closeWarning == "sync") {
                QVariant jsSyncResult =
                        frame->evaluateJavaScript("pebCloseConfirmationSync()");

                bool jsCloseDecision;
                if (jsSyncResult.toString().length() > 0) {
                    jsCloseDecision = jsSyncResult.toBool();
                } else {
                    jsCloseDecision = true;
                }

                if (jsCloseDecision == true) {
                    if (!runningScripts.isEmpty()){
                        emit closeAllScriptsSignal();
                    } else {
                        emit closeWindowSignal();
                    }
                }
            }

            if (closeWarning == "none") {
                if (!runningScripts.isEmpty()){
                    emit closeAllScriptsSignal();
                } else {
                    emit closeWindowSignal();
                }
            }
        }

        if (textIsEntered == false) {
            if (!runningScripts.isEmpty()){
                emit closeAllScriptsSignal();
            } else {
                emit closeWindowSignal();
            }
        }
    }

    void qCloseAllScriptsSlot()
    {
        windowCloseRequested = true;

        if (!runningScripts.isEmpty()) {
            int maximumTimeMilliseconds = 5000;
            QTimer::singleShot(maximumTimeMilliseconds,
                               this,
                               SLOT(qScriptsTimeoutSlot()));

            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {
                QScriptHandler *handler = iterator.value();

                QByteArray scriptCloseCommandArray;
                scriptCloseCommandArray
                        .append(
                            QString(handler->scriptCloseCommand).toLatin1());
                scriptCloseCommandArray.append(QString("\n").toLatin1());

                handler->scriptProcess.write(scriptCloseCommandArray);
            }
        }
    }

    void qScriptsTimeoutSlot()
    {
        if (!runningScripts.isEmpty()) {
            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {
                QScriptHandler *handler = iterator.value();

                if (handler->scriptProcess.isOpen()) {
                    handler->scriptProcess.kill();

                    qDebug() << "Interactive script"
                             << "timed out after close command and"
                             << "was killed:"
                             << handler->scriptFullFilePath;
                }
            }
        }

        emit closeWindowSignal();
    }

    void qCloseWindowTransmitterSlot()
    {
        emit closeWindowSignal();
    }

    // ==============================
    // PERL DEBUGGER GUI:
    // Implementation of an idea proposed by Valcho Nedelchev
    // ==============================
    void qHandlePerlDebuggerSlot()
    {
#if PERL_DEBUGGER_GUI == 1
        // Clean any previous debugger output:
        debuggerAccumulatedOutput = "";

        QString commandLineArguments;

        if (debuggerHandler.isOpen()) {
            QByteArray debuggerCommand;
            debuggerCommand.append(debuggerLastCommand.toLatin1());
            debuggerCommand.append(QString("\n").toLatin1());
            debuggerHandler.write(debuggerCommand);
        } else {
            debuggerJustStarted = true;

            // Sеt the environment for the debugged script:
            QProcessEnvironment systemEnvironment =
                    QProcessEnvironment::systemEnvironment();
            systemEnvironment.insert("PERLDB_OPTS", "ReadLine=0");
            debuggerHandler.setProcessEnvironment(systemEnvironment);

            bool ok;
            QString input =
                    QInputDialog::getText(
                        qApp->activeWindow(),
                        "Command Line",
                        "Enter all command line arguments, if any:",
                        QLineEdit::Normal,
                        "",
                        &ok);

            if (ok && !input.isEmpty()) {
                commandLineArguments = input;
            }

            QFileInfo scriptAbsoluteFilePath(debuggerScriptToDebug);
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            debuggerHandler.setWorkingDirectory(scriptDirectory);

            debuggerHandler.setProcessChannelMode(QProcess::MergedChannels);
            debuggerHandler.start(qApp->property("perlInterpreter")
                                  .toString(),
                                  QStringList()
                                  << "-d"
                                  << debuggerScriptToDebug
                                  << commandLineArguments,
                                  QProcess::Unbuffered
                                  | QProcess::ReadWrite);

            QByteArray debuggerCommand;
            debuggerCommand.append(debuggerLastCommand.toLatin1());
            debuggerCommand.append(QString("\n").toLatin1());
            debuggerHandler.write(debuggerCommand);
        }
#endif
    }

    void qDebuggerOutputSlot()
    {
#if PERL_DEBUGGER_GUI == 1
        // Read debugger output:
        QString debuggerOutput = debuggerHandler.readAllStandardOutput();

        // Append last output of the debugger to
        // the accumulated debugger output:
        debuggerAccumulatedOutput.append(debuggerOutput);

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "Output from Perl debugger received.";
        // qDebug() << "Perl debugger raw output:" << endl
        //          << debuggerOutput;

        // Formatting of Perl debugger output is started only after
        // the final command prompt comes out of the debugger:
        if (debuggerJustStarted == true) {
            if (debuggerLastCommand.length() > 0 and
                    debuggerAccumulatedOutput.contains(
                        QRegExp ("DB\\<\\d{1,5}\\>.*DB\\<\\d{1,5}\\>"))) {
                debuggerJustStarted = false;

                if (debuggerOutputHandler.isOpen()) {
                    debuggerOutputHandler.close();
                }
                qDebuggerStartHtmlFormatter();
            }

            if (debuggerLastCommand.length() == 0 and
                    debuggerAccumulatedOutput
                    .contains(QRegExp ("DB\\<\\d{1,5}\\>"))) {
                debuggerJustStarted = false;

                if (debuggerOutputHandler.isOpen()) {
                    debuggerOutputHandler.close();
                }

                qDebuggerStartHtmlFormatter();
            }
        }

        if (debuggerJustStarted == false and
                debuggerAccumulatedOutput
                .contains(QRegExp ("DB\\<\\d{1,5}\\>"))) {
            if (debuggerOutputHandler.isOpen()) {
                debuggerOutputHandler.close();
            }
            qDebuggerStartHtmlFormatter();
        }
#endif
    }

    void qDebuggerStartHtmlFormatter()
    {
#if PERL_DEBUGGER_GUI == 1
        // 'dbgformatter.pl' is compiled into the resources of
        // the binary file and is read from there.
        QFileReader *resourceReader = new QFileReader(
                    QString(":/scripts/dbgformatter.pl"));
        QString debuggerOutputFormatterScript = resourceReader->fileContents;

        // Set clean environment:
        QProcessEnvironment cleanEnvironment;
        cleanEnvironment.insert("REQUEST_METHOD", "GET");
        cleanEnvironment.insert("QUERY_STRING", debuggerAccumulatedOutput);
        debuggerOutputHandler.setProcessEnvironment(cleanEnvironment);

        // Clean any previous debugger output:
        debuggerAccumulatedOutput = "";

        // Set path to the syntax highlighting module:
        debuggerOutputFormatterScript.replace("PEBLIB_PATH",
                         QApplication::applicationDirPath()
                         + QDir::separator() + "sdk"
                         + QDir::separator() + "peblib");

        // Start the Perl debugger output formatting script:
        debuggerOutputHandler
                .start((qApp->property("perlInterpreter").toString()),
                       QStringList()
                       << "-e"
                       << debuggerOutputFormatterScript
                       << debuggerScriptToDebug,
                       QProcess::Unbuffered | QProcess::ReadWrite);

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "Perl debugger output formatter script started.";
#endif
    }

    void qDebuggerHtmlFormatterOutputSlot()
    {
#if PERL_DEBUGGER_GUI == 1
        QString debuggerHtmlOutput =
                debuggerOutputHandler.readAllStandardOutput();

        // Append last output of the debugger formatter to
        // the accumulated debugger formatter output:
        debuggerAccumulatedHtmlOutput.append(debuggerHtmlOutput);

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "Output from Perl debugger formatter received.";
#endif
    }

    void qDebuggerHtmlFormatterErrorsSlot()
    {
#if PERL_DEBUGGER_GUI == 1
        QString debuggerOutputFormatterErrors =
                debuggerOutputHandler.readAllStandardError();

        qDebug() << "Perl debugger formatter error:"
                 << debuggerOutputFormatterErrors;
#endif
    }

    void qDebuggerHtmlFormatterFinishedSlot()
    {
#if PERL_DEBUGGER_GUI == 1
        debuggerFrame->setHtml(debuggerAccumulatedHtmlOutput,
                               QUrl(PSEUDO_DOMAIN));

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "Output from Perl debugger formatter displayed.";

        debuggerOutputHandler.close();
        debuggerAccumulatedHtmlOutput = "";
#endif
    }

public:
    QPage();

protected:
    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType type);

    virtual void javaScriptAlert(QWebFrame *frame, const QString &msg)
    {
        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["alertTitle"]
                    .toString().length() > 0) {
                alertTitle =
                        messageBoxElementsJsonObject["alertTitle"]
                        .toString();
            }

            if (messageBoxElementsJsonObject["okLabel"]
                    .toString().length() > 0) {
                okLabel =
                        messageBoxElementsJsonObject["okLabel"].toString();
            }
        }

        QMessageBox javaScriptAlertMessageBox (qApp->activeWindow());
        javaScriptAlertMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptAlertMessageBox.setWindowTitle(alertTitle);
        javaScriptAlertMessageBox.setText(msg);
        javaScriptAlertMessageBox.setButtonText(QMessageBox::Ok, okLabel);
        javaScriptAlertMessageBox.setDefaultButton(QMessageBox::Ok);
        javaScriptAlertMessageBox.exec();
    }

    virtual bool javaScriptConfirm(QWebFrame *frame, const QString &msg)
    {
        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["confirmTitle"]
                    .toString().length() > 0) {
                confirmTitle =
                        messageBoxElementsJsonObject["confirmTitle"]
                        .toString();
            }

            if (messageBoxElementsJsonObject["yesLabel"]
                    .toString().length() > 0) {
                yesLabel =
                        messageBoxElementsJsonObject["yesLabel"].toString();
            }

            if (messageBoxElementsJsonObject["noLabel"]
                    .toString().length() > 0) {
                noLabel =
                        messageBoxElementsJsonObject["noLabel"].toString();
            }
        }

        QMessageBox javaScriptConfirmMessageBox (qApp->activeWindow());
        javaScriptConfirmMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptConfirmMessageBox.setWindowTitle(confirmTitle);
        javaScriptConfirmMessageBox.setText(msg);
        javaScriptConfirmMessageBox
                .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::Yes, yesLabel);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::No, noLabel);
        javaScriptConfirmMessageBox.setDefaultButton(QMessageBox::No);
        return QMessageBox::Yes == javaScriptConfirmMessageBox.exec();
    }

    virtual bool javaScriptPrompt(QWebFrame *frame,
                                  const QString &msg,
                                  const QString &defaultValue,
                                  QString *result)
    {
        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["promptTitle"]
                    .toString().length() > 0) {
                promptTitle =
                        messageBoxElementsJsonObject["promptTitle"]
                        .toString();
            }

            if (messageBoxElementsJsonObject["okLabel"]
                    .toString().length() > 0) {
                okLabel =
                        messageBoxElementsJsonObject["okLabel"].toString();
            }

            if (messageBoxElementsJsonObject["cancelLabel"]
                    .toString().length() > 0) {
                cancelLabel =
                        messageBoxElementsJsonObject["cancelLabel"].toString();
            }
        }

        bool ok = false;

        QInputDialog dialog;
        dialog.setModal(true);
        dialog.setWindowTitle(promptTitle);
        dialog.setLabelText(msg);
        dialog.setInputMode(QInputDialog::TextInput);
        dialog.setTextValue(defaultValue);
        dialog.setOkButtonText(okLabel);
        dialog.setCancelButtonText(cancelLabel);

        if (dialog.exec() == QDialog::Accepted) {
            *result = dialog.textValue();
            ok = true;
            return ok;
        }

        return ok;
    }

private:
    QWebView *webViewWidget;

    bool windowCloseRequested;

    QString pageStatus;
    QRegExp htmlFileNameExtensionMarker;
    QString emptyString;

    QString alertTitle;
    QString confirmTitle;
    QString promptTitle;

    QString okLabel;
    QString cancelLabel;
    QString yesLabel;
    QString noLabel;

    QWebFrame *debuggerFrame;
    bool debuggerJustStarted;
    QString debuggerScriptToDebug;
    QString debuggerLastCommand;
    QProcess debuggerHandler;
    QString debuggerAccumulatedOutput;
    QProcess debuggerOutputHandler;
    QString debuggerAccumulatedHtmlOutput;

public:
    QHash<QString, QScriptHandler*> runningScripts;
};

// ==============================
// WEB VIEW CLASS DEFINITION:
// ==============================
class QWebViewWidget : public QWebView
{
    Q_OBJECT

signals:
    void initiateWindowClosingSignal();

public slots:
    void qChangeTitleSlot()
    {
        setWindowTitle(QWebViewWidget::title());
    }

    void qSelectInodesSlot(QNetworkRequest request)
    {
        QString target = request.url().query().replace("target=", "");

        QFileDialog inodesDialog (this);
        inodesDialog.setWindowModality(Qt::WindowModal);
        inodesDialog.setViewMode(QFileDialog::Detail);
        inodesDialog.setWindowTitle(QWebViewWidget::title());
#ifdef Q_OS_WIN
        inodesDialog.setOption(QFileDialog::DontUseNativeDialog);
#endif

        if (request.url().fileName() == "open-file.function") {
            inodesDialog.setFileMode(QFileDialog::AnyFile);
        }

        if (request.url().fileName() == "open-files.function") {
            inodesDialog.setFileMode(QFileDialog::ExistingFiles);
        }

        if (request.url().fileName() == "new-file-name.function") {
            inodesDialog.setAcceptMode(QFileDialog::AcceptSave);
        }

        if (request.url().fileName() == "open-directory.function") {
            inodesDialog.setFileMode(QFileDialog::Directory);
        }

        QStringList userSelectedInodes;
        if (inodesDialog.exec()) {
            userSelectedInodes = inodesDialog.selectedFiles();
        }

        inodesDialog.close();
        inodesDialog.deleteLater();

        if (!userSelectedInodes.isEmpty()) {
            QString userSelectedInodesFormatted;
            foreach (QString userSelectedInode, userSelectedInodes) {
                userSelectedInodesFormatted.append(userSelectedInode);
                userSelectedInodesFormatted.append(";");
            }
            userSelectedInodesFormatted
                    .replace(QRegularExpression(";$"), "");

            // JavaScript bridge back to
            // the local HTML frame where request originated:
            mainPage->qJavaScriptInjector(mainPage->currentFrame());

            QString inodeSelectedJavaScript =
                    "pebInodeSelection(\"" +
                    userSelectedInodesFormatted +
                    "\" , \"" +
                    target +
                    "\"); null";

            mainPage->currentFrame()->
                    evaluateJavaScript(inodeSelectedJavaScript);

            qInfo() << "User selected inode:"
                    << userSelectedInodesFormatted;
        }
    }

    void contextMenuEvent(QContextMenuEvent *event)
    {
        QWebHitTestResult qWebHitTestResult =
                mainPage->mainFrame()->hitTestContent(event->pos());
        QMenu menu;

        QString printPreviewLabel;
        QString printLabel;

        QString cutLabel;
        QString copyLabel;
        QString pasteLabel;
        QString selectAllLabel;

        QFileReader *resourceReader =
                new QFileReader(QString(":/scripts/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        mainPage->currentFrame()->evaluateJavaScript(pebJavaScript);

        QVariant contextMenuJsResult =
                mainPage->currentFrame()->
                evaluateJavaScript("pebFindContextMenu()");

        QJsonDocument contextMenuJsonDocument =
                QJsonDocument::fromJson(
                    contextMenuJsResult.toString().toUtf8());

        QJsonObject contextMenuJsonObject =
                contextMenuJsonDocument.object();

        if (contextMenuJsonObject.length() > 0) {
            if (contextMenuJsonObject["printPreview"].toString()
                    .length() > 0) {
                printPreviewLabel =
                        contextMenuJsonObject["printPreview"].toString();
            }

            if (contextMenuJsonObject["print"].toString().length() > 0) {
                printLabel = contextMenuJsonObject["print"].toString();
            }

            if (contextMenuJsonObject["cut"].toString().length() > 0) {
                cutLabel = contextMenuJsonObject["cut"].toString();
            }

            if (contextMenuJsonObject["copy"].toString().length() > 0) {
                copyLabel = contextMenuJsonObject["copy"].toString();
            }

            if (contextMenuJsonObject["paste"].toString().length() > 0) {
                pasteLabel = contextMenuJsonObject["paste"].toString();
            }

            if (contextMenuJsonObject["selectAll"].toString().length() > 0) {
                selectAllLabel = contextMenuJsonObject["selectAll"]
                        .toString();
            }
        } else {
            printPreviewLabel = "Print Preview";
            printLabel = "Print";

            cutLabel = "Cut";
            copyLabel = "Copy";
            pasteLabel = "Paste";
            selectAllLabel = "Select All";
        }

        if ((qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty()) or
                qWebHitTestResult.isContentSelected()) {

            if (cutLabel.length() > 0) {
                QAction *cutAct = menu.addAction(cutLabel);
                QObject::connect(cutAct, SIGNAL(triggered()),
                                 this, SLOT(qCutAction()));
            }

            if (copyLabel.length() > 0) {
                QAction *copyAct = menu.addAction(copyLabel);
                QObject::connect(copyAct, SIGNAL(triggered()),
                                 this, SLOT(qCopyAction()));
            }

            if (pasteLabel.length() > 0) {
                QAction *pasteAct = menu.addAction(pasteLabel);
                QObject::connect(pasteAct, SIGNAL(triggered()),
                                 this, SLOT(qPasteAction()));
            }

            if (selectAllLabel.length() > 0) {
                QAction *selectAllAct = menu.addAction(selectAllLabel);
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));
            }
        }

        if (!qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty() and
                (!qWebHitTestResult.isContentSelected())) {

            if (printPreviewLabel.length() > 0) {
                QAction *printPreviewAct = menu.addAction(printPreviewLabel);
                QObject::connect(printPreviewAct, SIGNAL(triggered()),
                                 this, SLOT(qStartPrintPreviewSlot()));
            }

            if (printLabel.length() > 0) {
                QAction *printAct = menu.addAction(printLabel);
                QObject::connect(printAct, SIGNAL(triggered()),
                                 this, SLOT(qPrintSlot()));
            }

            if (selectAllLabel.length() > 0) {
                QAction *selectAllAct = menu.addAction(selectAllLabel);
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));
            }
        }

        menu.exec(mapToGlobal(event->pos()));
        this->focusWidget();
    }

    void qCutAction()
    {
        QWebViewWidget::triggerPageAction(QWebPage::Cut);
    }

    void qCopyAction()
    {
        QWebViewWidget::triggerPageAction(QWebPage::Copy);
    }

    void qPasteAction()
    {
        QWebViewWidget::triggerPageAction(QWebPage::Paste);
    }

    void qSelectAllAction()
    {
        QWebViewWidget::triggerPageAction(QWebPage::SelectAll);
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
        QWebViewWidget::print(printer);
#endif
    }

    void qPrintSlot()
    {
#ifndef QT_NO_PRINTER
        qInfo() << "Printing requested.";

        QPrinter printer;
        QPrintDialog *printDialog = new QPrintDialog(&printer);
        printDialog->setWindowModality(Qt::WindowModal);
        QSize dialogSize = printDialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        printDialog->move(QPoint((screenRect.width() / 2)
                                 - (dialogSize.width() / 2),
                                 (screenRect.height() / 2)
                                 - (dialogSize.height() / 2)));
        if (printDialog->exec() == QDialog::Accepted) {
            QWebViewWidget::print(&printer);
        }
        printDialog->close();
        printDialog->deleteLater();
#endif
    }

    void qDisplayScriptErrorsSlot(QString errors)
    {
        errorsWindow = new QWebViewWidget();
        errorsWindow->setHtml(errors, QUrl(PSEUDO_DOMAIN));
        errorsWindow->adjustSize();
        errorsWindow->setFocus();
        errorsWindow->show();
    }

    void qStartQWebInspector()
    {
        qInfo() << "QWebInspector started.";

        QWebInspector *inspector = new QWebInspector;
        inspector->setPage(QWebViewWidget::page());
        inspector->show();
    }

    void closeEvent(QCloseEvent *event)
    {
        if (windowCloseRequested == false) {
            event->ignore();
            emit initiateWindowClosingSignal();
        }

        if (windowCloseRequested == true) {
            event->accept();
        }
    }

    void qCloseWindowSlot()
    {
        if (!this->parentWidget()) {
            windowCloseRequested = true;
            this->close();
        }

        if (this->parentWidget()) {
            qApp->setProperty("mainWindowCloseRequested", true);
            this->parentWidget()->close();
        }
    }

public:
    QWebViewWidget();

    QWebView *createWindow(QWebPage::WebWindowType type)
    {
        Q_UNUSED(type);

        QFileReader *htmlReader =
                new QFileReader(QString(":/html/loading.html"));
        QString loadingContents = htmlReader->fileContents;

        QWebView *window = new QWebViewWidget();
        window->setHtml(loadingContents);
        window->show();

        qInfo() << "New window opened.";

        return window;
    }

private:
    QPage *mainPage;
    QWebView *newWindow;
    QWebView *errorsWindow;

    bool windowCloseRequested;
};

// ==============================
// EXIT HANDLER CLASS DEFINITION:
// ==============================
class QExitHandler : public QObject
{
    Q_OBJECT

public slots:
    void qExitApplicationSlot()
    {
        qInfo() << qApp->applicationName().toLatin1().constData()
                << qApp->applicationVersion().toLatin1().constData()
                << "terminated normally.";

        QApplication::exit();
    }

public:
    QExitHandler();
};

#endif // PEB_H
