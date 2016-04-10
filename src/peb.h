/*
 Perl Executing Browser

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
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
#include <QtNetwork/QNetworkAccessManager>
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
#include <QDesktopWidget>
#include <qglobal.h>

// ==============================
// PRINT SUPPORT:
// ==============================
#ifndef QT_NO_PRINTER
#include <QPrintPreviewDialog>
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
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
            fileExists = false;
            qDebug() << QDir::toNativeSeparators(fullFilePath) <<
                        "is missing.";
        }
    }

public:
    QFileDetector();
    bool fileExists;
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
// NETWORK ACCESS MANAGER
// CLASS DEFINITION:
// ==============================
class QAccessManager : public QNetworkAccessManager
{
    Q_OBJECT

signals:
    void startScriptSignal(QUrl url, QByteArray postDataArray);

protected:
    virtual QNetworkReply *createRequest(Operation operation,
                                         const QNetworkRequest &request,
                                         QIODevice *outgoingData = 0)
    {
        // Local AJAX GET and POST requests:
        if ((operation == GetOperation or
             operation == PostOperation) and
                request.url().authority() == PSEUDO_DOMAIN and
                request.url().path().contains("ajax")) {

            QString scriptFullFilePath = QDir::toNativeSeparators
                    ((qApp->property("root").toString())
                     + request.url().path());

            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(scriptFullFilePath);

            if (fileDetector.fileExists == true) {
                QString queryString = request.url().query();

                QByteArray postDataArray;
                if (outgoingData) {
                    postDataArray = outgoingData->readAll();
                }
                QString postData(postDataArray);

                qDebug() << "AJAX script started:" << scriptFullFilePath;

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
                scriptHandler.setWorkingDirectory("");

                QEventLoop scriptHandlerWaitingLoop;

                QObject::connect(&scriptHandler,
                                 SIGNAL(finished(int, QProcess::ExitStatus)),
                                 &scriptHandlerWaitingLoop,
                                 SLOT(quit()));
                QTimer::singleShot(2000, &scriptHandlerWaitingLoop,
                                   SLOT(quit()));

                QString scriptResultString;
                QString scriptErrorString;

                if (!scriptHandler.isOpen()) {
                    // 'censor.pl' is compiled into the resources of
                    // the binary file and called from there.
                    QString censorScriptFileName(
                                ":/scripts/perl/censor.pl");
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
                        qDebug() << "AJAX script timed out or gave no output:"
                                 << scriptFullFilePath;
                    } else {
                        qDebug() << "AJAX script finished:"
                                 << scriptFullFilePath;
                    }

                    if (scriptErrorString.length() > 0) {
                        qDebug() << "AJAX script gave errors:"
                                 << scriptFullFilePath;
                    }
                } else {
                    qDebug() << "AJAX script already started:"
                             << scriptFullFilePath;
                }

                QWebSettings::clearMemoryCaches();

                scriptEnvironment.remove("REQUEST_METHOD");

                if (queryString.length() > 0) {
                    scriptEnvironment.remove("QUERY_STRING");
                }

                if (postData.length() > 0) {
                    scriptEnvironment.remove("CONTENT_LENGTH");
                }

                QCustomNetworkReply *reply =
                        new QCustomNetworkReply (request.url(),
                                                 scriptResultString);
                return reply;
            }

            if (fileDetector.fileExists == false) {
                QNetworkRequest emptyNetworkRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest(emptyNetworkRequest));
            }
        }

        // GET requests to the browser pseudodomain -
        // local files and CGI-like scripts:
        if (operation == GetOperation and
                request.url().authority() == PSEUDO_DOMAIN and
                (!request.url().path().contains("ajax"))) {

            // Get the full file path and file extension:
            QString fullFilePath = QDir::toNativeSeparators
                    ((qApp->property("root").toString())
                     + request.url().path());

            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(fullFilePath);

            if (fileDetector.fileExists == true) {
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

                // Handle local HTML, CSS, JS, fonts or supported image files:
                if (interpreter.contains ("browser")) {

                    qDebug() << "Link requested:"
                             << request.url().toString();

                    QString localFileName(QDir::toNativeSeparators(
                                              (qApp->property("root")
                                               .toString())
                                              + request.url().path()));
                    QFile localFile(localFileName);
                    localFile.open(QIODevice::ReadOnly);
                    QTextStream stream(&localFile);
                    QString localFileContents = stream.readAll();
                    localFile.close();

                    QCustomNetworkReply *reply =
                            new QCustomNetworkReply (request.url(),
                                                     localFileContents);
                    return reply;
                }

                // Unsupported local files:
                if (interpreter.contains("undefined")) {

                    qDebug() << "File type not supported by browser:"
                             << fullFilePath;

                    QDesktopServices::openUrl(QUrl::fromLocalFile(
                                                  fullFilePath));

                    QNetworkRequest emptyNetworkRequest;
                    return QNetworkAccessManager::createRequest
                            (QNetworkAccessManager::GetOperation,
                             QNetworkRequest(emptyNetworkRequest));
                }
            }

            if (fileDetector.fileExists == false) {
                QNetworkRequest emptyNetworkRequest;
                return QNetworkAccessManager::createRequest
                        (QNetworkAccessManager::GetOperation,
                         QNetworkRequest(emptyNetworkRequest));
            }
        }

        // POST requests to the browser pseudodomain - CGI-like scripts:
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

        qDebug() << "Link requested:"
                 << request.url().toString();

        return QNetworkAccessManager::createRequest
                (QNetworkAccessManager::GetOperation,
                 QNetworkRequest(request));
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

public slots:
    void qStartScriptSlot(QUrl url, QByteArray postDataArray)
    {
        scriptFullFilePath = QDir::toNativeSeparators
                ((qApp->property("root").toString())
                 + url.path());

        QString queryString = url.query();
        QString postData(postDataArray);

        qDebug() << "Script started:" << scriptFullFilePath;

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
        scriptHandler.setWorkingDirectory("");

        if (!scriptHandler.isOpen()) {
            // 'censor.pl' is compiled into the resources of
            // the binary file and called from there.
            QString censorScriptFileName(
                        ":/scripts/perl/censor.pl");
            QFile censorScriptFile(censorScriptFileName);
            censorScriptFile.open(QIODevice::ReadOnly
                                  | QIODevice::Text);
            QTextStream censorStream(&censorScriptFile);
            QString censorScriptContents = censorStream.readAll();
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

            runningScriptsInCurrentWindowList
                    .append(scriptFullFilePath);

            if (postData.length() > 0) {
                scriptHandler.write(postDataArray);
            }
        } else {
            qDebug() << "Script already started:" << scriptFullFilePath;
        }

        QWebSettings::clearMemoryCaches();

        scriptEnvironment.remove("REQUEST_METHOD");

        if (queryString.length() > 0) {
            scriptEnvironment.remove("QUERY_STRING");
        }

        if (postData.length() > 0) {
            scriptEnvironment.remove("CONTENT_LENGTH");
        }
    }

    void qScriptOutputSlot()
    {
        QString output = scriptHandler.readAllStandardOutput();

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: output from" << scriptFullFilePath;
        // qDebug() << "Script output:" << endl << output;

        scriptAccumulatedOutput.append(output);

        if (!QPage::mainFrame()->childFrames().contains(targetFrame)) {
            targetFrame = QPage::currentFrame();
        }

        targetFrame->setHtml(scriptAccumulatedOutput,
                             QUrl(PSEUDO_DOMAIN));
    }

    void qScriptErrorsSlot()
    {
        QString error = scriptHandler.readAllStandardError();
        scriptAccumulatedErrors.append(error);
        scriptAccumulatedErrors.append("\n");

        // qDebug() << "Script error:" << endl << error;
    }

    void qScriptFinishedSlot()
    {
        if (!QPage::mainFrame()->childFrames().contains(targetFrame)) {
            targetFrame = QPage::currentFrame();
        }

        targetFrame->setHtml(scriptAccumulatedOutput,
                             QUrl(PSEUDO_DOMAIN));

        if (scriptAccumulatedErrors.length() > 0) {

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

        scriptHandler.close();
        qDebug() << "Script finished:" << scriptFullFilePath;
        runningScriptsInCurrentWindowList.removeOne(scriptFullFilePath);

        scriptAccumulatedOutput = "";
        scriptAccumulatedErrors = "";
    }

    // ==============================
    // PERL DEBUGGER INTERACTION.
    // Implementation of an idea proposed by Valcho Nedelchev.
    // ==============================
    void qStartPerlDebuggerSlot()
    {
        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Read and store in memory
            // the Perl debugger output formatter script:
            QFile debuggerOutputFormatterFile(":/scripts/perl/dbgformatter.pl");
            debuggerOutputFormatterFile.open(QFile::ReadOnly | QFile::Text);
            debuggerOutputFormatterScript =
                    QString(debuggerOutputFormatterFile.readAll());
            debuggerOutputFormatterFile.close();

            qDebug() << "File passed to Perl debugger:"
                     << QDir::toNativeSeparators(debuggerScriptToDebug);

            // Perl interpreter to be used for debugging:
            QString debuggerInterpreter =
                    (qApp->property("perlInterpreter").toString());

            // Clean accumulated debugger output from previous debugger session:
            debuggerAccumulatedOutput = "";

            if (debuggerHandler.isOpen()) {
                QByteArray debuggerCommand;
                debuggerCommand.append(debuggerLastCommand.toLatin1());
                debuggerCommand.append(QString("\n").toLatin1());
                debuggerHandler.write(debuggerCommand);
            } else {
                debuggerJustStarted = true;

                // scriptEnvironment.insert("PERLDB_OPTS", "ReadLine=0");
                debuggerHandler.setProcessEnvironment(scriptEnvironment);

                QFileInfo scriptAbsoluteFilePath(debuggerScriptToDebug);
                QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
                debuggerHandler.setWorkingDirectory(scriptDirectory);

                debuggerHandler.setProcessChannelMode(QProcess::MergedChannels);
                debuggerHandler.start(debuggerInterpreter, QStringList()
                                      << "-d" <<
                                      QDir::toNativeSeparators(
                                          debuggerScriptToDebug),
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
            // qDebug() << "Debugger raw output:" << endl
            //          << debuggerOutput;

            // Formatting of Perl debugger output is started only after
            // the final command prompt comes out of the debugger:
            if (debuggerJustStarted == true) {
                if ((debuggerLastCommand.length() > 0) and
                        (debuggerAccumulatedOutput.contains(
                             QRegExp ("DB\\<\\d{1,5}\\>.*DB\\<\\d{1,5}\\>")))) {
                    debuggerJustStarted = false;
                    if (debuggerOutputHandler.isOpen()) {
                        debuggerOutputHandler.close();
                    }
                    qDebuggerStartHtmlFormatter();
                }


                if ((debuggerLastCommand.length() == 0) and
                        (debuggerAccumulatedOutput
                         .contains(QRegExp ("DB\\<\\d{1,5}\\>")))) {
                    debuggerJustStarted = false;
                    if (debuggerOutputHandler.isOpen()) {
                        debuggerOutputHandler.close();
                    }
                    qDebuggerStartHtmlFormatter();
                }
            }

            if ((debuggerJustStarted == false) and
                    (debuggerAccumulatedOutput
                     .contains(QRegExp ("DB\\<\\d{1,5}\\>")))) {
                if (debuggerOutputHandler.isOpen()) {
                    debuggerOutputHandler.close();
                }
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
                    .replace("PEBLIB_PATH",
                             QApplication::applicationDirPath()
                             + QDir::separator()
                             + "peblib");

            debuggerOutputFormatterScript
                    .replace("SCRIPT", debuggerScriptToDebug);
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
    }

    void qDebuggerHtmlFormatterErrorsSlot()
    {
        QString debuggerOutputFormatterErrors =
                debuggerOutputHandler.readAllStandardError();

        qDebug() << "Perl debugger formatter error:"
                 << debuggerOutputFormatterErrors;
    }

    void qDebuggerHtmlFormatterFinishedSlot()
    {
        targetFrame->setHtml(debuggerAccumulatedHtmlOutput,
                              QUrl(PSEUDO_DOMAIN));

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch:"
                 << "output from Perl debugger formatter displayed.";

        // qDebug() << "Perl debugger formatter output:" << endl
        //          << debuggerAccumulatedHtmlOutput;

        debuggerOutputHandler.close();
        debuggerAccumulatedHtmlOutput = "";
    }

public:
    QPage();
    QString scriptFullFilePath;
    QProcess scriptHandler;
    QStringList runningScriptsInCurrentWindowList;
    QString checkUserInputBeforeCloseJavaScript;

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
    QWebView *newWindow;
    QWebFrame *targetFrame;

    QProcessEnvironment scriptEnvironment;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;

    bool debuggerJustStarted;
    QString debuggerScriptToDebug;
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
class QWebViewWindow : public QWebView
{
    Q_OBJECT

public slots:
    void qLoadStartPageSlot()
    {
        setUrl(QUrl("http://" + QString(PSEUDO_DOMAIN) + "/"
                    + qApp->property("startPagePath").toString()));
    }

    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            setWindowTitle(QWebViewWindow::title());
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
        QWebViewWindow::print(printer);
#endif
    }

    void qPrintSlot()
    {
#ifndef QT_NO_PRINTER

        qDebug() << "Printing requested.";

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
            QWebViewWindow::print(&printer);
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
            QWebViewWindow::print(&pdfPrinter);
        }
#endif
    }

    void qDisplayErrorsSlot(QString errors)
    {
        errorsWindow = new QWebViewWindow();
        errorsWindow->setHtml(errors, QUrl(PSEUDO_DOMAIN));
        errorsWindow->setFocus();
        errorsWindow->show();
    }

    void qToggleFullScreenSlot()
    {
        if (isFullScreen()) {
            showMaximized();
        } else {
            showFullScreen();
        }
    }

    void qStartQWebInspector()
    {
        qDebug() << "QWebInspector started.";

        QWebInspector *inspector = new QWebInspector;
        inspector->setPage(QWebViewWindow::page());
        inspector->adjustSize();
        inspector->show();
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
            } else {
                event->ignore();
            }
        } else {
            mainPage->currentFrame()->evaluateJavaScript(
                        mainPage->checkUserInputBeforeCloseJavaScript);
            QVariant jsResult =
                    mainPage->currentFrame()->evaluateJavaScript(
                        "checkUserInputBeforeClose()");
            QString textIsEntered = jsResult.toString();

            if (textIsEntered == "no") {
                event->accept();
            }

            if (textIsEntered == "yes") {
                QVariant jsResult =
                        mainPage->currentFrame()->evaluateJavaScript(
                            "pebCloseConfirmation()");
                QString jsQuitDecision = jsResult.toString();

                if (jsQuitDecision.length() == 0) {
                    event->accept();
                }

                if (jsQuitDecision.length() > 0) {
                    if (jsQuitDecision == "yes") {
                        event->accept();
                    }
                    if (jsQuitDecision == "no") {
                        event->ignore();
                    }
                }
            }
        }
    }

    void qExitApplicationSlot()
    {
        qDebug() << qApp->applicationName().toLatin1().constData()
                 << qApp->applicationVersion().toLatin1().constData()
                 << "terminated normally.";

        QApplication::exit();
    }

    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        foreach (QSslError error, errors) {
            qDebug() << "SSL error:" << error;
        }

        reply->ignoreSslErrors();
    }

public:
    QWebViewWindow();

    QWebView *createWindow(QWebPage::WebWindowType type)
    {
        qDebug() << "New window requested.";

        Q_UNUSED(type);
        QWebView *window = new QWebViewWindow();
        window->setWindowIcon(icon);
        window->setAttribute(Qt::WA_DeleteOnClose, true);
        window->showMaximized();

        return window;
    }

private:
    QPage *mainPage;
    QWebView *newWindow;
    QWebView *errorsWindow;

    QPixmap icon;
};

#endif // PEB_H
