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
// NONINTERACTIVE SCRIPT HANDLER:
// ==============================
class QNonInteractiveScriptHandler : public QObject
{
    Q_OBJECT

signals:
    void displayScriptOutputSignal(QString output, QString scriptOutputTarget);
    void scriptFinishedSignal(QString scriptAccumulatedOutput,
                              QString scriptAccumulatedErrors,
                              QString scriptFullFilePath,
                              QString scriptOutputTarget);

public slots:
    void qNonInteractiveScriptOutputSlot()
    {
        QString output = scriptHandler.readAllStandardOutput();
        scriptAccumulatedOutput.append(output);

        if (scriptOutputTarget.length() > 0) {
            emit displayScriptOutputSignal(output, scriptOutputTarget);
        }

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: output from" << scriptFullFilePath;
    }

    void qNonInteractiveScriptErrorsSlot()
    {
        QString scriptErrors = scriptHandler.readAllStandardError();
        scriptAccumulatedErrors.append(scriptErrors);
        scriptAccumulatedErrors.append("\n");

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: errors from" << scriptFullFilePath;

        // qDebug() << "Script errors:" << scriptErrors;
    }

    void qNonInteractiveScriptFinishedSlot()
    {
        emit scriptFinishedSignal(scriptAccumulatedOutput,
                                  scriptAccumulatedErrors,
                                  scriptFullFilePath,
                                  scriptOutputTarget);

        scriptHandler.close();

        qDebug() << "Script finished:" << scriptFullFilePath;
    }

    void qRootPasswordTimeoutSlot()
    {
        qApp->setProperty("rootPassword", "");
    }

public:
    QNonInteractiveScriptHandler(QUrl url, QByteArray postDataArray);
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;

private:
    QProcess scriptHandler;
    QString scriptFullFilePath;
    QString scriptOutputTarget;
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
        // Case-insensitive marker for AJAX Perl scripts:
        // ==============================
        scriptAjaxMarker.setPattern("ajax");
        scriptAjaxMarker.setCaseSensitivity(Qt::CaseInsensitive);

        // ==============================
        // Starting local AJAX Perl scripts is prohibited if
        // untrusted content is loaded in the same window:
        // ==============================
        if ((operation == GetOperation or
             operation == PostOperation) and
                request.url().authority() == PSEUDO_DOMAIN and
                request.url().path().contains(scriptAjaxMarker) and
                pageStatus == "untrusted") {

            QString errorMessage =
                    "Calling local Perl scripts after "
                    "untrusted content is loaded is prohibited.<br>"
                    "Go to start page to unlock local Perl scripts.";
            qDebug() << "Local AJAX Perl script called after"
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
                request.url().authority() == PSEUDO_DOMAIN and
                request.url().path().contains(scriptAjaxMarker) and
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

                QNonInteractiveScriptHandler *ajaxScriptHandler =
                        new QNonInteractiveScriptHandler(
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
                qDebug() << "File not found:" << ajaxScriptFullFilePath;

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
                request.url().authority() == PSEUDO_DOMAIN and
                (!request.url().path().contains(scriptAjaxMarker)) and
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
                        qDebug() << "Local Perl script called after"
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

                    qDebug() << "Local link requested:"
                             << request.url().toString();

                    QFileReader *resourceReader =
                            new QFileReader(QString(fullFilePath));
                    QString fileContents = resourceReader->fileContents;

                    QCustomNetworkReply *reply =
                            new QCustomNetworkReply (
                                request.url(), fileContents, mimeType);
                    return reply;
                } else {
                    qDebug() << "File type not supported:" << fullFilePath;

                    QDesktopServices::openUrl(
                                QUrl::fromLocalFile(fullFilePath));

                    QCustomNetworkReply *reply =
                            new QCustomNetworkReply (
                                request.url(), emptyString, emptyString);
                    return reply;
                }
            } else {
                qDebug() << "File not found:" << fullFilePath;

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
                request.url().authority() == PSEUDO_DOMAIN and
                (!request.url().path().contains(scriptAjaxMarker))) {

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

        qDebug() << "Link requested:"
                 << request.url().toString();

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
    QRegExp scriptAjaxMarker;
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
    void closeInteractiveScriptSignal();
    void closeWindowSignal();

public slots:
    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            emit changeTitleSignal();
        }
    }

    // ==============================
    // STARTING SCRIPTS:
    // ==============================
    void qStartScriptSlot(QUrl url, QByteArray postDataArray)
    {
        QString scriptFullFilePath = QDir::toNativeSeparators
                ((qApp->property("application").toString()) +
                 url.path());

        QUrlQuery scriptQuery(url);
        QString scriptType = scriptQuery.queryItemValue("type");

        // Start the interactive script:
        if (scriptType == "interactive" and
                (!interactiveScriptHandler.isOpen())) {

            interactiveScriptFullFilePath = scriptFullFilePath;

            interactiveScriptOutputTarget =
                    scriptQuery.queryItemValue("target");
            if (interactiveScriptOutputTarget.length() == 0) {
                qDebug() << "Target DOM element is not defined"
                         << "for interactive script:"
                         << interactiveScriptFullFilePath;
            }

            interactiveScriptCloseCommand =
                    scriptQuery.queryItemValue("close_command");
            if (interactiveScriptCloseCommand.length() == 0) {
                qDebug() << "Close command is not defined"
                         << "for interactive script:"
                         << interactiveScriptFullFilePath;
            }

            interactiveScriptClosedConfirmation =
                    scriptQuery.queryItemValue("close_confirmation");
            if (interactiveScriptClosedConfirmation.length() == 0) {
                qDebug() << "Closed confirmation is not defined"
                         << "for interactive script:"
                         << interactiveScriptFullFilePath;
            }

            if (interactiveScriptOutputTarget.length() > 0 and
                    interactiveScriptCloseCommand.length() > 0 and
                    interactiveScriptClosedConfirmation.length() > 0) {
                interactiveScriptHandler.start(
                            (qApp->property("perlInterpreter").toString()),
                            QStringList()
                            << "-M-ops=fork"
                            << interactiveScriptFullFilePath,
                            QProcess::Unbuffered | QProcess::ReadWrite);

                qDebug() << "Interactive script"
                         << interactiveScriptFullFilePath
                         << "started.";

                if (postDataArray.length() > 0) {
                    postDataArray.append(QString("\n").toLatin1());
                    interactiveScriptHandler.write(postDataArray);
                }
            }
        }

        // Transmitt data to the interactive script:
        if (scriptFullFilePath == interactiveScriptFullFilePath and
                interactiveScriptHandler.isOpen() and
                postDataArray.length() > 0) {
            postDataArray.append(QString("\n").toLatin1());
            interactiveScriptHandler.write(postDataArray);
        }

        // Start noninteractive script:
        if (scriptFullFilePath != interactiveScriptFullFilePath) {
            QNonInteractiveScriptHandler *nonInteractiveScriptHandler =
                    new QNonInteractiveScriptHandler(url, postDataArray);

            // Signals and slots for all local noninteractive scripts:
            QObject::connect(nonInteractiveScriptHandler,
                             SIGNAL(displayScriptOutputSignal(QString,
                                                              QString)),
                             this,
                             SLOT(qDisplayScriptOutputSlot(QString,
                                                           QString)));
            QObject::connect(nonInteractiveScriptHandler,
                             SIGNAL(scriptFinishedSignal(QString,
                                                         QString,
                                                         QString,
                                                         QString)),
                             this,
                             SLOT(qScriptFinishedSlot(QString,
                                                      QString,
                                                      QString,
                                                      QString)));
        }
    }

    // ==============================
    // HANDLING THE INTERACTIVE SCRIPT:
    // ==============================
    void qInteractiveScriptOutputSlot()
    {
        QString output = interactiveScriptHandler.readAllStandardOutput();

        // JavaScript bridge to insert output from the interactive script:
        qJavaScriptInjector(currentFrame());

        QString outputInsertionJavaScript =
                "pebOutputInsertion(\"" +
                interactiveScriptOutputTarget +
                "\" , \"" +
                output +
                "\"); null";

        currentFrame()->evaluateJavaScript(outputInsertionJavaScript);

        // Handling the interactive script closed confirmation:
        if (output.contains(interactiveScriptClosedConfirmation)) {
            interactiveScriptHandler.close();

            qDebug() << "Interactive script"
                     << interactiveScriptFullFilePath
                     << "terminated normally.";

            emit closeWindowSignal();
        }
    }

    void qInteractiveScriptErrorSlot()
    {
        QString interactiveScriptErrors =
                interactiveScriptHandler.readAllStandardError();

        qDebug() << "Interactive script"
                 << interactiveScriptFullFilePath << "errors:"
                 << interactiveScriptErrors;
    }

    void qCloseInteractiveScriptSlot()
    {
        QByteArray interactiveScriptCloseCommandArray;
        interactiveScriptCloseCommandArray
                .append(QString(interactiveScriptCloseCommand).toLatin1());
        interactiveScriptCloseCommandArray.append(QString("\n").toLatin1());
        interactiveScriptHandler.write(interactiveScriptCloseCommandArray);

        int maximumTimeMilliseconds = 5 * 1000;
        QTimer::singleShot(maximumTimeMilliseconds,
                           this, SLOT(qInteractiveScriptTimeoutSlot()));
    }

    void qInteractiveScriptTimeoutSlot()
    {
        if (interactiveScriptHandler.isOpen()) {
            interactiveScriptHandler.close();

            qDebug() << "Interactive script"
                     << interactiveScriptFullFilePath
                     << "timed out after close command was issued and"
                     << "was forcefully terminated.";

            emit closeWindowSignal();
        }
    }

    // ==============================
    // HANDLING NONINTERACTIVE SCRIPTS:
    // ==============================
    void qDisplayScriptOutputSlot(QString output, QString target)
    {
        if (target.length() > 0) {
            // JavaScript bridge to insert output from noninteractive scripts:
            qJavaScriptInjector(currentFrame());

            QString outputInsertionJavaScript =
                    "pebOutputInsertion(\"" +
                    target +
                    "\" , \"" +
                    output +
                    "\"); null";

            currentFrame()->evaluateJavaScript(outputInsertionJavaScript);
        } else {
            QPage::currentFrame()->setHtml(output, QUrl(PSEUDO_DOMAIN));
        }
    }

    void qScriptFinishedSlot(QString scriptAccumulatedOutput,
                             QString scriptAccumulatedErrors,
                             QString scriptFullFilePath,
                             QString scriptOutputTarget)
    {
        if (pageStatus == "untrusted") {
            QString errorMessage =
                    "<p>Displaying output from local Perl scripts after "
                    "untrusted content is loaded in the same window "
                    "is prohibited.<br>"
                    "Go to <a href='" +
                    qApp->property("startPage").toString() +
                    "'>start page</a> "
                    "to unlock local Perl scripts.</p>";
            qDebug() << "Displaying output from local Perl scripts stopped "
                     << "after untrusted content is loaded:"
                     << QPage::currentFrame()->
                        baseUrl().toString();

            QFileReader *resourceReader =
                    new QFileReader(QString(":/html/error.html"));
            QString htmlErrorContents = resourceReader->fileContents;

            htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
            QPage::currentFrame()->setHtml(htmlErrorContents);

            qDebug() << errorMessage;
        }

        if (pageStatus == "trusted") {
            // If noninteractive script has no errors and
            // no target DOM element:
            if (scriptAccumulatedOutput.length() > 0 and
                    scriptAccumulatedErrors.length() == 0 and
                    scriptOutputTarget.length() == 0) {

                qDisplayScriptOutputSlot(scriptAccumulatedOutput, emptyString);
            }

            if (scriptAccumulatedErrors.length() > 0) {
                if (scriptAccumulatedOutput.length() == 0) {
                    if (scriptOutputTarget.length() == 0) {
                        // If noninteractive script has no output and
                        // only errors and
                        // no target DOM element is defined,
                        // all HTML formatted errors will be displayed
                        // in the same window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            false);
                    } else {
                        // If noninteractive script has no output and
                        // only errors and
                        // a target DOM element is defined,
                        // all HTML formatted errors will be displayed
                        // in a new window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            true);
                    }
                } else {
                    // If noninteractive script has some output and errors,
                    // HTML formatted errors will be displayed in a new window:
                    qFormatScriptErrors(scriptAccumulatedErrors,
                                        scriptFullFilePath,
                                        true);
                    qDisplayScriptOutputSlot(scriptAccumulatedOutput,
                                             emptyString);
                }
            }
        }
    }

    void qFormatScriptErrors(QString errors,
                             QString scriptFullFilePath,
                             bool newWindow)
    {
        QString scriptErrorTitle;
        if (errors.contains("trapped")) {
            scriptErrorTitle = "Insecure code was blocked:";
        } else {
            scriptErrorTitle = "Errors were found during script execution:";
        }

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
                    reply->url().fileName()
                    .contains(htmlFileNameExtensionMarker)) {
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
                if (trustedDomains.contains(reply->url().authority())) {
                    pageStatus = "trusted";
                    emit pageStatusSignal(pageStatus);
                }

                if (!trustedDomains.contains(reply->url().authority())) {
                    pageStatus = "untrusted";
                    emit pageStatusSignal(pageStatus);
                }
            }

            if (pageStatus == "trusted") {
                if (!trustedDomains.contains(reply->url().authority())) {
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
        qDebug() << "Mixed content is detected. Offending URL:"
                 << url.toString();

        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
        QPage::mainFrame()->setHtml(htmlErrorContents);
    }

    // ==============================
    // JAVASCRIPT INJECTOR:
    // ==============================
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
                    if (interactiveScriptHandler.isOpen()){
                        emit closeInteractiveScriptSignal();
                    } else {
                        emit closeWindowSignal();
                    }
                }
            }

            if (closeWarning == "none") {
                if (interactiveScriptHandler.isOpen()){
                    emit closeInteractiveScriptSignal();
                } else {
                    emit closeWindowSignal();
                }
            }
        }

        if (textIsEntered == false) {
            if (interactiveScriptHandler.isOpen()){
                emit closeInteractiveScriptSignal();
            } else {
                emit closeWindowSignal();
            }
        }
    }

    void qCloseWindowTransmitterSlot()
    {
        emit closeWindowSignal();
    }

    // ==============================
    // PERL DEBUGGER INTERACTION:
    // Implementation of an idea proposed by Valcho Nedelchev
    // ==============================
    void qStartPerlDebuggerSlot()
    {
#if PERL_DEBUGGER_INTERACTION == 1
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

            if (!debuggerScriptToDebug.contains(
                        qApp->property("application").toString())) {
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

            qDebug() << QDateTime::currentMSecsSinceEpoch()
                     << "msecs from epoch: command sent to Perl debugger:"
                     << debuggerLastCommand;
        }
#endif
    }

    void qDebuggerOutputSlot()
    {
#if PERL_DEBUGGER_INTERACTION == 1
        // Read debugger output:
        QString debuggerOutput = debuggerHandler.readAllStandardOutput();

        // Append last output of the debugger to
        // the accumulated debugger output:
        debuggerAccumulatedOutput.append(debuggerOutput);

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "output from Perl debugger received.";
        // qDebug() << "Debugger raw output:" << endl
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
#if PERL_DEBUGGER_INTERACTION == 1
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

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "Perl debugger output formatter script started.";
#endif
    }

    void qDebuggerHtmlFormatterOutputSlot()
    {
#if PERL_DEBUGGER_INTERACTION == 1
        QString debuggerHtmlOutput =
                debuggerOutputHandler.readAllStandardOutput();

        // Append last output of the debugger formatter to
        // the accumulated debugger formatter output:
        debuggerAccumulatedHtmlOutput.append(debuggerHtmlOutput);

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "output from Perl debugger formatter received.";
#endif
    }

    void qDebuggerHtmlFormatterErrorsSlot()
    {
#if PERL_DEBUGGER_INTERACTION == 1
        QString debuggerOutputFormatterErrors =
                debuggerOutputHandler.readAllStandardError();

        qDebug() << "Perl debugger formatter error:"
                 << debuggerOutputFormatterErrors;
#endif
    }

    void qDebuggerHtmlFormatterFinishedSlot()
    {
#if PERL_DEBUGGER_INTERACTION == 1
        debuggerFrame->setHtml(debuggerAccumulatedHtmlOutput,
                               QUrl(PSEUDO_DOMAIN));

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "output from Perl debugger formatter displayed.";

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
        qJavaScriptInjector(frame);

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
        qJavaScriptInjector(frame);

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
        qJavaScriptInjector(frame);

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

    QString interactiveScriptFullFilePath;
    QProcess interactiveScriptHandler;
    QString interactiveScriptOutputTarget;
    QString interactiveScriptCloseCommand;
    QString interactiveScriptClosedConfirmation;

    QWebFrame *debuggerFrame;
    bool debuggerJustStarted;
    QString debuggerScriptToDebug;
    QString debuggerLastCommand;
    QProcess debuggerHandler;
    QString debuggerAccumulatedOutput;
    QProcess debuggerOutputHandler;
    QString debuggerAccumulatedHtmlOutput;
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
            // the local HTML page where request originated:
            mainPage->qJavaScriptInjector(mainPage->currentFrame());

            QString inodeSelectedJavaScript =
                    "pebInodeSelection(\"" +
                    target +
                    "\" , \"" +
                    userSelectedInodesFormatted +
                    "\"); null";

            mainPage->currentFrame()->
                    evaluateJavaScript(inodeSelectedJavaScript);

            qDebug() << "User selected inode:"
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
        qDebug() << "Printing requested.";

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
        qDebug() << "QWebInspector started.";

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

        qDebug() << "New window opened.";

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
        qDebug() << qApp->applicationName().toLatin1().constData()
                 << qApp->applicationVersion().toLatin1().constData()
                 << "terminated normally.";

        QApplication::exit();
    }

public:
    QExitHandler();
};

#endif // PEB_H
