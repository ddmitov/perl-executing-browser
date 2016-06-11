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

#include <QApplication>
#include <QShortcut>
#include <QDateTime>
#include <QTranslator>
#include <QDebug>
#include <qglobal.h>
#include "peb.h"

#ifndef Q_OS_WIN
#include <unistd.h> // for isatty()
#endif

#ifdef Q_OS_WIN
#include <windows.h> // for isUserAdmin()
#endif

// ==============================
// DETECT WINDOWS USER PRIVILEGES SUBROUTINE:
// ==============================
#ifdef Q_OS_WIN
BOOL isUserAdmin()
{
    BOOL bResult;
    SID_IDENTIFIER_AUTHORITY ntAuthority = SECURITY_NT_AUTHORITY;
    PSID administratorsGroup;
    bResult = AllocateAndInitializeSid(
                &ntAuthority, 2, SECURITY_BUILTIN_DOMAIN_RID,
                DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
                &administratorsGroup);
    if (bResult) {
        if (!CheckTokenMembership(NULL, administratorsGroup, &bResult)) {
            bResult = FALSE;
        }
        FreeSid(administratorsGroup);
    }
    return(bResult);
}
#endif

// ==============================
// READ EMBEDDED HTML TEMPLATE
// FOR ERROR MESSAGES:
// ==============================
QString readHtmlErrorTemplate()
{
    QString htmlErrorFileName(":/html/error.html");
    QFile htmlErrorFile(htmlErrorFileName);
    htmlErrorFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream htmlErrorStream(&htmlErrorFile);
    QString htmlErrorContents = htmlErrorStream.readAll();
    htmlErrorFile.close();

    return htmlErrorContents;
}

// ==============================
// MESSAGE HANDLER FOR REDIRECTING
// PROGRAM MESSAGES TO A LOG FILE:
// ==============================
// Implementation of an idea proposed by Valcho Nedelchev.
void customMessageHandler(QtMsgType type,
                          const QMessageLogContext &context,
                          const QString &message)
{
    Q_UNUSED(context);
    QString dateAndTime =
            QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
    QString text = QString("[%1] ").arg(dateAndTime);

    switch (type) {
#if QT_VERSION >= 0x050500
    case QtInfoMsg:
        text += QString("{Info} %1").arg(message);
        break;
#endif
    case QtDebugMsg:
        text += QString("{Log} %1").arg(message);
        break;
    case QtWarningMsg:
        text += QString("{Warning} %1").arg(message);
        break;
    case QtCriticalMsg:
        text += QString("{Critical} %1").arg(message);
        break;
    case QtFatalMsg:
        text += QString("{Fatal} %1").arg(message);
        abort();
        break;
    }

    // A separate log file is created for every browser session.
    // Application start date and time are appended to the binary file name.
    QFile logFile(QDir::toNativeSeparators
                  (qApp->property("logDirFullPath").toString()
                   + QDir::separator()
                   + QFileInfo(QApplication::applicationFilePath()).baseName()
                   + "-started-at-"
                   + qApp->property("applicationStartDateAndTime").toString()
                   + ".log"));
    logFile.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
    QTextStream textStream(&logFile);
    textStream << text << endl;
}

// ==============================
// MAIN APPLICATION DEFINITION:
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    // ==============================
    // SET BASIC APPLICATION VARIABLES:
    // ==============================
    application.setApplicationName("Perl Executing Browser");
    application.setApplicationVersion("0.1");
    bool startedAsRoot = false;

    // ==============================
    // SET UTF-8 ENCODING APPLICATION-WIDE:
    // ==============================
    // Use UTF-8 encoding within the application:
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // DETECT USER PRIVILEGES:
    // ==============================
#ifndef Q_OS_WIN
    // Linux and Mac:
    int userEuid = geteuid();

    if (userEuid == 0) {
        startedAsRoot = true;
    }
#endif

#ifdef Q_OS_WIN
    // Windows:
    if (isUserAdmin()) {
        startedAsRoot = true;
    }
#endif

    // ==============================
    // DETECT START FROM TERMINAL:
    // ==============================
    // If the browser is started from terminal,
    // it will start another copy of itself and close the first one.
    // This is necessary for a working interaction with the Perl debugger.
#ifndef Q_OS_WIN
    if (PERL_DEBUGGER_INTERACTION == 1) {
        if (isatty(fileno(stdin))) {
            if (userEuid > 0) {
                // Fork another instance of the browser:
                int pid = fork();
                if (pid < 0) {
                    return 1;
                    QApplication::exit();
                }

                if (pid == 0) {
                    // Detach all standard I/O descriptors:
                    close(0);
                    close(1);
                    close(2);
                    // Enter a new session:
                    setsid();
                    // New instance is now detached from terminal:
                    QProcess anotherInstance;
                    anotherInstance.startDetached(
                                QApplication::applicationFilePath());
                    if (anotherInstance.waitForStarted(-1)) {
                        return 1;
                        QApplication::exit();
                    }
                } else {
                    // The parent instance should be closed now:
                    return 1;
                    QApplication::exit();
                }
            }
        }
    }
#endif

    // ==============================
    // SETTINGS FILE:
    // ==============================
    // Settings file is loaded from the directory of the binary file:
    QDir settingsDir =
            QDir::toNativeSeparators(application.applicationDirPath());
#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        settingsDir.cdUp();
        settingsDir.cdUp();
    }
#endif

    // Get the name of the settings file directory:
    QString settingsDirName =
            settingsDir.absolutePath().toLatin1();
    settingsDirName.append(QDir::separator());

    // Get the name of the settings file.
    // Settings file takes the name of the binary,
    // but with an '.ini' file extension:
    QString settingsFileName =
            QDir::toNativeSeparators
            (settingsDirName
             + QFileInfo(QApplication::applicationFilePath()).baseName()
             + ".ini");

    // Define INI file format for settings:
    QSettings settings(settingsFileName, QSettings::IniFormat);

    // ==============================
    // READ SETTINGS FROM SETTINGS FILE:
    // ==============================
    // PERL INTERPRETER:
    QString perlInterpreterSetting =
            settings.value("perl").toString();
    QString perlInterpreter = QDir::toNativeSeparators(
                settingsDirName + perlInterpreterSetting);

    QFile perlInterpreterFile(perlInterpreter);
    if (!perlInterpreterFile.exists()) {
        perlInterpreter = "";
    }

    application.setProperty("perlInterpreter", perlInterpreter);

    // START FULLSCREEN:
    QString startFullscreenSetting =
            settings.value("start_fullscreen").toString();

    // ==============================
    // CHECK BROWSER FILES AND FOLDERS:
    // ==============================
    // LOGGING:
    // If 'logs' directory is found in the directory of the browser binary,
    // all program messages will be redirected to log files,
    // otherwise no log files will be created and
    // program messages could be seen inside Qt Creator.
    QString logDirFullPath = settingsDirName + "logs";
    QDir logDir(logDirFullPath);
    if (logDir.exists()) {
        application.setProperty("logDirFullPath", logDirFullPath);
        // Application start date and time for logging:
        QString applicationStartDateAndTime =
                QDateTime::currentDateTime().toString("yyyy-MM-dd--hh-mm-ss");
        application.setProperty("applicationStartDateAndTime",
                                applicationStartDateAndTime);
        // Install message handler for redirecting all messages to a log file:
        qInstallMessageHandler(customMessageHandler);
    }

    // APPLICATION DIRECTORY:
    QString applicationDirName = QDir::toNativeSeparators(
                settingsDirName
                + "resources"
                + QDir::separator()
                + "app");
    application.setProperty("application", applicationDirName);

    // APPLICATION ICON:
    QString iconPathName = QDir::toNativeSeparators(
                settingsDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app.png");
    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);
    if (iconFile.exists()) {
        application.setProperty("iconPathName", iconPathName);
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon
        // in case no external icon file is found:
        //application.setProperty("iconPathName", ":/icons/camel.png");
        icon.load(":/icons/camel.png");
        QApplication::setWindowIcon(icon);
    }

    // ==============================
    // READ INTERNALLY COMPILED JAVASCRIPT:
    // ==============================
    QFile file;
    file.setFileName(":/scripts/js/check-user-input-before-close.js");
    file.open(QIODevice::ReadOnly);
    QString checkUserInputBeforeCloseJS = file.readAll();
    file.close();

    application.setProperty("checkUserInputBeforeCloseJS",
                            checkUserInputBeforeCloseJS);

    // ==============================
    // MAIN GUI CLASSES INITIALIZATION:
    // ==============================
    QMainBrowserWindow mainWindow;
    mainWindow.webViewWidget = new QWebViewWidget();

    // Connect signal and slot for setting the main window title:
    QObject::connect(mainWindow.webViewWidget,
                     SIGNAL(titleChanged(QString)),
                     &mainWindow, SLOT(setMainWindowTitleSlot(QString)));

    // Connect signal and slot for actions taken before application exit:
    QObject::connect(qApp, SIGNAL(aboutToQuit()),
                     &mainWindow, SLOT(qExitApplicationSlot()));

    // Display embedded HTML error message if application is started by
    // a user with administrative privileges:
    if (startedAsRoot == true) {
        QString htmlErrorContents = readHtmlErrorTemplate();
        QString errorMessage =
                "Using "
                + application.applicationName().toLatin1() + " "
                + application.applicationVersion().toLatin1() + " "
                + "with administrative privileges is not allowed.";
        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

        mainWindow.webViewWidget->setHtml(htmlErrorContents);

        qDebug() << "Using"
                 << application.applicationName().toLatin1().constData()
                 << application.applicationVersion().toLatin1().constData()
                 << "with administrative privileges is not allowed.";
    }

    // Display start page:
    if (startedAsRoot == false) {
        // ==============================
        // LOG BASIC PROGRAM INFORMATION AND SETTINGS:
        // ==============================
        qDebug() << application.applicationName().toLatin1().constData()
                 << application.applicationVersion().toLatin1().constData()
                 << "started.";
        qDebug() << "Qt version:" << QT_VERSION_STR;
        qDebug() << "Executable:" << application.applicationFilePath();
        qDebug()  <<"Local pseudo-domain:" << PSEUDO_DOMAIN;
#ifndef Q_OS_WIN
        if (PERL_DEBUGGER_INTERACTION == 0) {
            qDebug() << "Perl debugger interaction is disabled.";
        }
        if (PERL_DEBUGGER_INTERACTION == 1) {
            qDebug() << "Perl debugger interaction is enabled.";
        }
#endif
        qDebug() << "Settings:"
                 << QDir::toNativeSeparators(settingsFileName);
        qDebug() << "Perl interpreter:" << perlInterpreter;
        if (startFullscreenSetting == "enable") {
            qDebug() << "Start in fullscreen is enabled.";
        }

        // Start page existence check and loading:
        QFile staticStartPageFile(applicationDirName + QDir::separator()
                                  + "index.html");
        if (staticStartPageFile.exists()) {
            mainWindow.webViewWidget->setUrl(
                        QUrl("http://" + QString(PSEUDO_DOMAIN)
                             + "/index.html"));
        } else {
            QFile dynamicStartPageFile(applicationDirName + QDir::separator()
                                       + "index.pl");
            if (dynamicStartPageFile.exists()) {
                mainWindow.webViewWidget->setUrl(
                            QUrl("http://" + QString(PSEUDO_DOMAIN)
                                 + "/index.pl"));
            } else {
                QString htmlErrorContents = readHtmlErrorTemplate();
                QString errorMessage = "Start page was not found.";
                htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

                mainWindow.webViewWidget->setHtml(htmlErrorContents);

                qDebug() << "Start page was not found.";
            }
        }
    }

    mainWindow.setCentralWidget(mainWindow.webViewWidget);
    mainWindow.setWindowIcon(icon);

    if (startFullscreenSetting == "enable") {
        mainWindow.showFullScreen();
    } else {
        mainWindow.showMaximized();
    }

    return application.exec();
}

// ==============================
// MAIN WINDOW CLASS CONSTRUCTOR:
// ==============================
QMainBrowserWindow::QMainBrowserWindow(QWidget *parent)
    : QMainWindow(parent)
{
    // !!! No need to implement code here, but must be declared !!!
}

// ==============================
// FILE DETECTOR CLASS CONSTRUCTOR:
// ==============================
QFileDetector::QFileDetector()
    : QObject(0)
{
    perlShebang.setPattern("#!/.{1,}perl");

    // Regular expressions for file type detection by extension:
    plExtension.setPattern("pl");
    plExtension.setCaseSensitivity(Qt::CaseInsensitive);

    htmlExtensions.setPattern("htm");
    htmlExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    xmlExtension.setPattern("xml");
    xmlExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jsonExtension.setPattern("json");
    jsonExtension.setCaseSensitivity(Qt::CaseInsensitive);

    cssExtension.setPattern("css");
    cssExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jsExtension.setPattern("js");
    jsExtension.setCaseSensitivity(Qt::CaseInsensitive);

    ttfExtension.setPattern("ttf");
    ttfExtension.setCaseSensitivity(Qt::CaseInsensitive);

    eotExtension.setPattern("eot");
    eotExtension.setCaseSensitivity(Qt::CaseInsensitive);

    woffExtensions.setPattern("woff");
    woffExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    svgExtension.setPattern("svg");
    svgExtension.setCaseSensitivity(Qt::CaseInsensitive);

    pngExtension.setPattern("png");
    pngExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jpgExtensions.setPattern("jpe{0,1}g");
    jpgExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    gifExtension.setPattern("gif");
    gifExtension.setCaseSensitivity(Qt::CaseInsensitive);

    fileExists = true;
}

// ==============================
// CUSTOM NETWORK REPLY CONSTRUCTOR:
// ==============================
struct QCustomNetworkReplyPrivate
{
    QByteArray data;
    int offset;
};

QCustomNetworkReply::QCustomNetworkReply(const QUrl &url, QString &data)
    : QNetworkReply()
{
    setFinished(true);
    open(ReadOnly | Unbuffered);

    reply = new QCustomNetworkReplyPrivate;
    reply->offset = 0;

    setUrl(url);

    setHeader(QNetworkRequest::ContentLengthHeader,
              QVariant(reply->data.size()));
    setHeader(QNetworkRequest::LastModifiedHeader,
              QVariant(QDateTime::currentDateTimeUtc()));

    QTimer::singleShot(0, this, SIGNAL(metaDataChanged()));

    setAttribute(QNetworkRequest::HttpStatusCodeAttribute, 200);
    setAttribute(QNetworkRequest::HttpReasonPhraseAttribute, "OK");

    reply->data = data.toUtf8();

    QTimer::singleShot(0, this, SIGNAL(readyRead()));
    QTimer::singleShot(0, this, SIGNAL(finished()));
}

QCustomNetworkReply::~QCustomNetworkReply()
{
    delete reply;
}

qint64 QCustomNetworkReply::size() const
{
    return reply->data.size();
}

void QCustomNetworkReply::abort()
{
    // !!! No need to implement code here, but must be declared !!!
}

qint64 QCustomNetworkReply::bytesAvailable() const
{
    return size();
}

bool QCustomNetworkReply::isSequential() const
{
    return true;
}

qint64 QCustomNetworkReply::read(char *data, qint64 maxSize)
{
    return readData(data, maxSize);
}

qint64 QCustomNetworkReply::readData(char *data, qint64 maxSize)
{
    if (reply->offset >= reply->data.size()) {
        return -1;
    }

    qint64 number = qMin(maxSize, (qint64) reply->data.size() - reply->offset);
    memcpy(data, reply->data.constData() + reply->offset, number);
    reply->offset += number;
    return number;
}

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
QPage::QPage()
    : QWebPage(0)
{
    QWebSettings::globalSettings()->
            setDefaultTextEncoding(QString("utf-8"));
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PluginsEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanOpenWindows, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessFileUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::XSSAuditingEnabled, true);

    // Disable cache:
    QWebSettings::setMaximumPagesInCache(0);
    QWebSettings::setObjectCacheCapacities(0, 0, 0);

    // Connect signals and slots for actions taken after page is loaded:
    QObject::connect(this, SIGNAL(loadFinished(bool)),
                     this, SLOT(qPageLoadedSlot(bool)));

    // Connect signals and slots for all local cgi-like perl scripts:
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qScriptOutputSlot()));
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardError()),
                     this, SLOT(qScriptErrorsSlot()));
    QObject::connect(&scriptHandler,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qScriptFinishedSlot()));

    alertTitle = "Alert";
    confirmTitle = "Confirmation";
    promptTitle = "Prompt";

    okLabel = "Ok";
    yesLabel = "Yes";
    noLabel = "No";

#ifndef Q_OS_WIN
    // Connect signals and slots for the perl debugger:
    if (PERL_DEBUGGER_INTERACTION == 1) {
        QObject::connect(&debuggerHandler, SIGNAL(readyReadStandardOutput()),
                         this, SLOT(qDebuggerOutputSlot()));

        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(readyReadStandardOutput()),
                         this,
                         SLOT(qDebuggerHtmlFormatterOutputSlot()));
        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(readyReadStandardError()),
                         this,
                         SLOT(qDebuggerHtmlFormatterErrorsSlot()));
        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(finished(int, QProcess::ExitStatus)),
                         this,
                         SLOT(qDebuggerHtmlFormatterFinishedSlot()));

        // Explicit initialization of important perl-debugger-related value:
        debuggerJustStarted = false;
    }
#endif
}

// ==============================
// WEB VIEW CLASS CONSTRUCTOR:
// ==============================
QWebViewWidget::QWebViewWidget()
    : QWebView(0)
{
    // Configure keyboard shortcuts:
#ifndef QT_NO_PRINTER
    QShortcut *printShortcut = new QShortcut(QKeySequence("Ctrl+P"), this);
    QObject::connect(printShortcut, SIGNAL(activated()),
                     this, SLOT(qPrintSlot()));
#endif

    QShortcut *qWebInspestorShortcut =
            new QShortcut(QKeySequence("Ctrl+I"), this);
    QObject::connect(qWebInspestorShortcut, SIGNAL(activated()),
                     this, SLOT(qStartQWebInspector()));

    // Start new window maximized:
    showMaximized();

    // Start QPage instance:
    mainPage = new QPage();

    // Connect signals and slots for
    // displaying script errors, printing and changing window title:
    QObject::connect(mainPage, SIGNAL(displayErrorsSignal(QString)),
                     this, SLOT(qDisplayErrorsSlot(QString)));

    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));

    QObject::connect(mainPage, SIGNAL(changeTitleSignal()),
                     this, SLOT(qChangeTitleSlot()));

    // Install QPage instance inside every QWebViewWidget instance:
    setPage(mainPage);

    // Use modified Network Access Manager:
    QAccessManager *networkAccessManager =
            new QAccessManager();
    mainPage->setNetworkAccessManager(networkAccessManager);

    // Connect signal and slot for starting local scripts:
    QObject::connect(networkAccessManager,
                     SIGNAL(startScriptSignal(QUrl, QByteArray)),
                     mainPage,
                     SLOT(qStartScriptSlot(QUrl, QByteArray)));

    // Disable history:
    QWebHistory *history = mainPage->history();
    history->setMaximumItemCount(0);

    // Cookies and HTTPS support:
    QNetworkCookieJar *cookieJar = new QNetworkCookieJar;
    networkAccessManager->setCookieJar(cookieJar);
    QObject::connect(networkAccessManager,
                     SIGNAL(sslErrors(QNetworkReply*, QList<QSslError>)),
                     this,
                     SLOT(qSslErrorsSlot(QNetworkReply*, QList<QSslError>)));

    // Configure scroll bars:
    mainPage->mainFrame()->setScrollBarPolicy(Qt::Horizontal,
                                              Qt::ScrollBarAsNeeded);
    mainPage->mainFrame()->setScrollBarPolicy(Qt::Vertical,
                                              Qt::ScrollBarAsNeeded);
}

// ==============================
// MANAGE CLICKING OF LINKS:
// ==============================
bool QPage::acceptNavigationRequest(QWebFrame *frame,
                                   const QNetworkRequest &request,
                                   QWebPage::NavigationType navigationType)
{
    // PRINTING:
#ifndef QT_NO_PRINTER
    // Print preview from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=preview")) {

        emit printPreviewSignal();

        return false;
    }

    // Print page from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=print")) {

        emit printSignal();

        return false;
    }
#endif

    // About Qt dialog box:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "about.function" and
            request.url().query() == ("type=qt")) {

        QApplication::aboutQt();

        return false;
    }

    // About browser dialog box:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "about.function" and
            request.url().query() == ("type=browser")) {

        frame->load(QUrl("qrc:/html/about.html"));

        return false;
    }

    // PERL DEBUGGER INTERACTION:
    // Implementation of an idea proposed by Valcho Nedelchev.
#ifndef Q_OS_WIN
    if (PERL_DEBUGGER_INTERACTION == 1) {
        if ((navigationType == QWebPage::NavigationTypeLinkClicked or
             navigationType == QWebPage::NavigationTypeFormSubmitted) and
                request.url().fileName() == "perl-debugger.function") {
                targetFrame = frame;

            // Select a Perl script for debugging:
            if (request.url().query().contains("action=select-file")) {

                QFileDialog selectScriptToDebugDialog (qApp->activeWindow());
                selectScriptToDebugDialog
                        .setFileMode(QFileDialog::ExistingFile);
                selectScriptToDebugDialog.setViewMode(QFileDialog::Detail);
                selectScriptToDebugDialog.setWindowModality(Qt::WindowModal);
                debuggerScriptToDebug = selectScriptToDebugDialog
                        .getOpenFileName
                        (qApp->activeWindow(),
                         "Select Perl File",
                         QDir::currentPath(),
                         "Perl scripts (*.pl);;All files (*)");
                selectScriptToDebugDialog.close();
                selectScriptToDebugDialog.deleteLater();

                if (debuggerScriptToDebug.length() > 1) {
                    qDebug() << "File to load in the Perl Debugger:"
                             << debuggerScriptToDebug;

                    // Get Perl debugger command (if any):
                    debuggerLastCommand = request.url().query().toLatin1()
                            .replace("action=select-file", "")
                            .replace("&command=", "")
                            .replace("+", " ");

                    qDebug() << "Debugger command:"
                             << debuggerLastCommand;

                    // Close any still open Perl debugger session:
                    debuggerHandler.close();

                    // Start the Perl debugger:
                    qStartPerlDebuggerSlot();
                    return false;
                } else {
                    return false;
                }
            }
            // Get Perl debugger command:
            debuggerLastCommand = request.url().query().toLatin1()
                    .replace("command=", "")
                    .replace("+", " ");

            qDebug() << "Debugger command:"
                     << debuggerLastCommand;

            qStartPerlDebuggerSlot();
            return false;
        }
    }
#endif

    return QWebPage::acceptNavigationRequest(frame, request, navigationType);
}
