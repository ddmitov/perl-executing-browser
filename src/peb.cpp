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
#include <iostream> // for std::cout
#endif

#ifdef Q_OS_WIN
#include <windows.h>
#endif

#ifdef Q_OS_WIN
// ==============================
// DETECT WINDOWS USER PRIVILEGES SUBROUTINE:
// ==============================
BOOL IsUserAdmin(void)
{
    BOOL bResult;
    SID_IDENTIFIER_AUTHORITY NtAuthority = SECURITY_NT_AUTHORITY;
    PSID AdministratorsGroup;
    bResult = AllocateAndInitializeSid(
                &NtAuthority, 2, SECURITY_BUILTIN_DOMAIN_RID,
                DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
                &AdministratorsGroup);
    if (bResult) {
        if (!CheckTokenMembership(NULL, AdministratorsGroup, &bResult)) {
            bResult = FALSE;
        }
        FreeSid(AdministratorsGroup);
    }
    return(bResult);
}
#endif

// ==============================
// MESSAGE HANDLER FOR REDIRECTING
// ALL DEBUG MESSAGES TO A LOG FILE:
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
                   + QFileInfo(
                       QApplication::applicationFilePath()).baseName()
                   + "-started-at-"
                   + qApp->property(
                       "applicationStartDateAndTime").toString()
                   + ".log"));
    logFile.open(QIODevice::WriteOnly
                 | QIODevice::Append
                 | QIODevice::Text);
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

    // ==============================
    // SET UTF-8 ENCODING APPLICATION-WIDE:
    // ==============================
    // Use UTF-8 encoding within the application:
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // DETECT USER PRIVILEGES AND
    // APPLICATION START FROM TERMINAL:
    // ==============================
#ifndef Q_OS_WIN
    // Detect user privileges - Linux and Mac:
    int userEuid;
    userEuid = geteuid();

    // If the browser is started from terminal,
    // it will start another copy of itself and close the first one.
    // This is necessary for a working interaction with the Perl debugger.
    if (PERL_DEBUGGER_INTERACTION == 1) {
        if (isatty(fileno(stdin))) {
            // Prevent starting as root from command line:
            if (userEuid == 0) {
                std::cout << " " << std::endl
                          << "Starting with root privileges is not allowed!"
                          << std::endl
                          << " " << std::endl;
                return 1;
                QApplication::exit();
            }

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
                                QApplication::applicationFilePath(),
                                QCoreApplication::arguments());
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

    // Prevent starting as root in graphical mode:
    if (userEuid == 0) {
        QString title = (QApplication::tr("Started as root"));
        QString text = (QApplication::tr("Browser was started as root.")
                        + "<br>"
                        + QApplication::tr("This is not a good idea!")
                        + "<br>"
                        + QApplication::tr("Going to quit now."));
        QMessageBox startedAsRootMessageBox;
        startedAsRootMessageBox.setWindowModality(Qt::WindowModal);
        startedAsRootMessageBox.setIcon(QMessageBox::Critical);
        startedAsRootMessageBox.setWindowTitle(title);
        startedAsRootMessageBox.setText(text);
        startedAsRootMessageBox.setDefaultButton(QMessageBox::Ok);
        startedAsRootMessageBox.exec();

        return 1;
        QApplication::exit();
    }
#endif

#ifdef Q_OS_WIN
    // Detect user privileges - Windows:
    if (IsUserAdmin()) {
        QMessageBox startedAsRootMessageBox;
        startedAsRootMessageBox.setWindowModality(Qt::WindowModal);
        startedAsRootMessageBox.setIcon(QMessageBox::Critical);
        startedAsRootMessageBox.setWindowTitle(
                    QApplication::tr(
                        "Started by administrator"));
        startedAsRootMessageBox.setText(
                    QApplication::tr(
                        "Browser was started with administrative privileges.")
                    + "<br>"
                    + QApplication::tr("This is not a good idea!")
                    + "&nbsp;"
                    + QApplication::tr("Going to quit now."));
        startedAsRootMessageBox.setDefaultButton(QMessageBox::Ok);
        startedAsRootMessageBox.exec();

        return 1;
        QApplication::exit();
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
    // SETTINGS:
    // ==============================
    // Perl interpreter:
    QString perlInterpreterSetting =
            settings.value("perl").toString();
    QString perlInterpreter;
    if (perlInterpreterSetting.length() > 0) {
        if (perlInterpreterSetting == "system") {
            // Find the full path to the Perl interpreter on PATH:
            QProcess systemPerlTester;
            systemPerlTester.start("perl",
                                   QStringList()
                                   << "-e"
                                   << "print $^X;");

            if (systemPerlTester.waitForFinished()) {
                QByteArray testingScriptResultArray =
                        systemPerlTester.readAllStandardOutput();
                perlInterpreter =
                        QString::fromLatin1(testingScriptResultArray);
            }
        } else {
            QDir interpreterFile(perlInterpreterSetting);
            // Local Perl interpreter given as a relative filepath:
            if (interpreterFile.isRelative()) {
                perlInterpreter =
                        QDir::toNativeSeparators(
                            settingsDirName + perlInterpreterSetting);

                QFile perlInterpreterFile(perlInterpreter);
                if (!perlInterpreterFile.exists()) {
                    perlInterpreter = "";
                }
            }
            // Perl interpreter given as a full filepath:
            if (interpreterFile.isAbsolute()) {
                perlInterpreter =
                        QDir::toNativeSeparators(perlInterpreterSetting);

                QFile perlInterpreterFile(perlInterpreter);
                if (!perlInterpreterFile.exists()) {
                    perlInterpreter = "";
                }
            }
        }
    }
    application.setProperty("perlInterpreter", perlInterpreter);

    // Logging:
    QString loggingSetting =
            settings.value("logging").toString();
    QString logDirFullPath = settingsDirName + "logs";
    if (loggingSetting == "enable") {
        // Application start date and time for logging:
        QString applicationStartDateAndTime =
                QDateTime::currentDateTime().toString("yyyy-MM-dd--hh-mm-ss");
        application
                .setProperty("applicationStartDateAndTime",
                             applicationStartDateAndTime);
        // Install message handler for
        // redirecting all debug messages to a log file:
        qInstallMessageHandler(customMessageHandler);
        // Log files directory:
        QDir logDir(logDirFullPath);
        if (!logDir.exists()) {
            logDir.mkpath(".");
        }
        application.setProperty("logDirFullPath", logDirFullPath);
    }

    // Package directory:
    QString packageDirName = QDir::toNativeSeparators(
                settingsDirName
                + "package"
                + QDir::separator());

    // Package application directory:
    QString applicationDirName = QDir::toNativeSeparators(
                packageDirName
                + "application");
    application.setProperty("application", applicationDirName);

    // Package data directory:
    QString dataDirName = QDir::toNativeSeparators(
                packageDirName
                + "data");
    application.setProperty("data", dataDirName);

    // Package start page -
    // path must be relative to the root directory of the current package.
    // HTML file or script are equally usable as a start page:
    QString startPageSetting =
            settings.value("start_page").toString();
    application.setProperty("startPagePath", startPageSetting);

    // Start fullscreen:
    QString startFullscreenSetting =
            settings.value("start_fullscreen").toString();
    application.setProperty("fullscreen", startFullscreenSetting);

    // Package icon:
    QString iconPathName = QDir::toNativeSeparators(
                settingsDirName
                + QDir::separator()
                + "package"
                + QDir::separator()
                + "package.png");
    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);
    if (iconFile.exists()) {
        application.setProperty("iconPathName", iconPathName);
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon
        // in case no external icon file is found:
        application.setProperty("iconPathName", ":/icons/camel-icon-32.png");
        icon.load(":/icons/camel.png");
        QApplication::setWindowIcon(icon);
    }

    // Translation:
    QString translationSetting =
            settings.value("translation").toString();
    QTranslator translator;
    if (translationSetting.length() > 0) {
        // Check for a valid translation.
        // Future valid translations have to be added here.
        if (translationSetting == "bg_BG") {
            translator.load("peb_" + translationSetting, ":/translations");
        } else {
            translationSetting = "";
        }
    }
    application.installTranslator(&translator);

    // ==============================
    // LOG BASIC PROGRAM INFORMATION:
    // ==============================
    qDebug() << application.applicationName().toLatin1().constData()
             << "version"
             << application.applicationVersion().toLatin1().constData()
             << "started.";
    qDebug() << "Executable:" << application.applicationFilePath();
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug()  <<"Local pseudo-domain:" << PSEUDO_DOMAIN;
    if (PERL_DEBUGGER_INTERACTION == 0) {
        qDebug() << "Perl debugger interaction is disabled.";
    }
    if (PERL_DEBUGGER_INTERACTION == 1) {
        qDebug() << "Perl debugger interaction is enabled.";
    }
    qDebug() << "";

    // ==============================
    // MAIN GUI CLASS INITIALIZATION:
    // ==============================
    QWebViewWindow window;

    QObject::connect(qApp, SIGNAL(lastWindowClosed()),
                     &window, SLOT(qExitApplicationSlot()));

    // Start page existence check and loading:
    QFile startPageFile(applicationDirName
                        + QDir::separator()
                        + startPageSetting);
    if (startPageFile.exists()) {
        window.qLoadStartPageSlot();
    } else {
        if (translationSetting.length() > 0) {
            window.setUrl(QUrl("qrc:/html/error_"
                               + translationSetting
                               +".htm"));
        } else {
            window.setUrl(QUrl("qrc:/html/error.htm"));
            qDebug()  <<"Start page is not found.";
        }
    }

    window.setWindowIcon(icon);
    window.show();

    // ==============================
    // LOG ALL SETTINGS:
    // ==============================
    qDebug() << "";
    qDebug() << "Settings file:" << settingsFileName;
    qDebug() << "Perl interpreter:" << perlInterpreter;
    if (loggingSetting == "enable") {
        qDebug() << "Logging is enabled.";
    }
    qDebug() << "Package application directory:" << applicationDirName;
    qDebug() << "Package data directory:" << dataDirName;
    qDebug() << "Package start page:"
             << applicationDirName + QDir::separator() + startPageSetting;
    if (startFullscreenSetting == "enable") {
        qDebug() << "Start in fullscreen is enabled.";
    }
    if (translationSetting.length() > 0) {
        qDebug() << "Translation:" << translationSetting;
    }
    qDebug() << "";

    return application.exec();
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
// SCRIPT ENVIRONMENT CLASS CONSTRUCTOR:
// ==============================
QScriptEnvironment::QScriptEnvironment()
    : QObject(0)
{
    // Set PEB_DATA_DIR environment variable:
    scriptEnvironment.insert("PEB_DATA_DIR", qApp->property("data").toString());
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
    // !!! no need to implement code here, but must be declared !!!
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
            setAttribute(QWebSettings::PluginsEnabled, true);
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
            setAttribute(QWebSettings::AcceleratedCompositingEnabled, true);
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

    // SIGNALS AND SLOTS FOR THE PERL DEBUGGER:
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

        // EXPLICIT INITIALIZATION OF IMPORTANT PERL-DEBUGGER-RELATED VALUE:
        debuggerJustStarted = false;
    }

    // SIGNALS AND SLOTS FOR ALL LOCAL PERL SCRIPTS:
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qScriptOutputSlot()));
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardError()),
                     this, SLOT(qScriptErrorsSlot()));
    QObject::connect(&scriptHandler,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qScriptFinishedSlot()));

    // SCRIPT ENVIRONMENT:
    QScriptEnvironment initialScriptEnvironment;
    scriptEnvironment = initialScriptEnvironment.scriptEnvironment;

    // DEFAULT FRAME FOR LOCAL CONTENT:
    targetFrame = QPage::mainFrame();

    // ICON FOR DIALOGS:
    icon.load(qApp->property("iconPathName").toString());
}

// ==============================
// WEB VIEW CLASS CONSTRUCTOR:
// ==============================
QWebViewWindow::QWebViewWindow()
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

    // Configure screen dimensions:
    if ((qApp->property("fullscreen").toString()) == "enable") {
        showFullScreen();
    } else {
        showMaximized();
    }

    // No context menu:
    setContextMenuPolicy(Qt::NoContextMenu);

    mainPage = new QPage();

    // Connect signals and slots:
    QObject::connect(mainPage, SIGNAL(displayErrorsSignal(QString)),
                     this, SLOT(qDisplayErrorsSlot(QString)));

    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));
    QObject::connect(mainPage, SIGNAL(saveAsPdfSignal()),
                     this, SLOT(qSaveAsPdfSlot()));

    QObject::connect(mainPage, SIGNAL(loadFinished(bool)),
                     this, SLOT(qPageLoadedSlot(bool)));

    setPage(mainPage);

    // Use modified Network Access Manager with every window of the program:
    QAccessManager *networkAccessManager =
            new QAccessManager();
    mainPage->setNetworkAccessManager(networkAccessManager);

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

    // Icon for windows:
    icon.load(qApp->property("iconPathName").toString());

    // READ INTERNALLY COMPILED JS SCRIPT:
    QFile file;
    file.setFileName(":/scripts/js/check-user-input-before-close.js");
    file.open(QIODevice::ReadOnly);
    checkUserInputBeforeCloseJavaScript = file.readAll();
    file.close();
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

    // Save as PDF from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=pdf")) {

        emit saveAsPdfSignal();

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

        frame->load(QUrl("qrc:/html/about.htm"));

        return false;
    }

    // PERL DEBUGGER INTERACTION:
    // Implementation of an idea proposed by Valcho Nedelchev.
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
                selectScriptToDebugDialog.setWindowIcon(icon);
                debuggerScriptToDebug = selectScriptToDebugDialog
                        .getOpenFileName
                        (qApp->activeWindow(),
                         tr("Select Perl File"),
                         QDir::currentPath(),
                         tr("Perl scripts (*.pl);;")
                         + tr("All files (*)"));
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

    return QWebPage::acceptNavigationRequest(frame, request, navigationType);
}
