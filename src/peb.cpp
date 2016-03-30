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

#include <QApplication>
#include <QShortcut>
#include <QDateTime>
#include <QTranslator>
#include <QDebug>
#include <qglobal.h>
#include "peb.h"

#ifndef Q_OS_WIN
#include <iostream> // for std::cout
#include <unistd.h> // for isatty()
#endif

#ifdef Q_OS_WIN
#include <windows.h>
#include <stdio.h>

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
void customMessageHandler(QtMsgType type,
                          const QMessageLogContext &context,
                          const QString &message)
{
    Q_UNUSED(context);
    QString dateAndTime =
            QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
    QString text = QString("[%1] ").arg(dateAndTime);

    switch (type) {
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

    if ((qApp->property("logMode").toString()) == "single_file") {
        QFile logFile(QDir::toNativeSeparators
                      (qApp->property("logDirFullPath").toString()
                       + QDir::separator()
                       + QFileInfo(
                           QApplication::applicationFilePath()).baseName()
                       + ".log"));
        logFile.open(QIODevice::WriteOnly
                     | QIODevice::Append
                     | QIODevice::Text);
        QTextStream textStream(&logFile);
        textStream << text << endl;
    }

    if ((qApp->property("logMode").toString()) == "per_session_file") {
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
    QString applicationName = APPLICATION_NAME;
    if (applicationName.contains("_")) {
        applicationName.replace("_", " ");
    }
    application.setApplicationName(applicationName);
    application.setApplicationVersion(APPLICATION_VERSION);

    // ==============================
    // SET UTF-8 ENCODING APPLICATION-WIDE:
    // ==============================
    // Use UTF-8 encoding within the application:
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // GET COMMAND LINE ARGUMENTS:
    // ==============================
    QStringList commandLineArguments = QCoreApplication::arguments();
    QString allArguments;
    foreach (QString argument, commandLineArguments) {
        allArguments.append(argument);
        allArguments.append(" ");
    }
    allArguments.replace(QRegExp("\\s$"), "");

    // ==============================
    // DISPLAY COMMAND LINE HELP:
    // ==============================
    foreach (QString argument, commandLineArguments) {
        if (argument.contains("--help") or argument.contains("-H")) {
#ifndef Q_OS_WIN
            // Linux & Mac:
            std::cout << " " << std::endl
                      << application.applicationName().toLatin1().constData()
                      << " v." << application.applicationVersion()
                         .toLatin1().constData()
                      << std::endl
                      << "Application file path: "
                      << QDir::toNativeSeparators(
                             QApplication::applicationFilePath())
                         .toLatin1().constData()
                      << std::endl
                      << "Qt version: " << QT_VERSION_STR << std::endl
                      << " " << std::endl
                      << "Usage:" << std::endl
                      << "  peb --option=value -o=value" << std::endl
                      << " " << std::endl
                      << "Command line options:" << std::endl
                      << "  --fullscreen    -F    "
                      << "start browser in fullscreen mode"
                      << std::endl;
            std::cout << "  --help          -H    this help"
                      << std::endl
                      << " " << std::endl;
#endif

#ifdef Q_OS_WIN
            // Windows:
            QMessageBox commandLineHelp;
            commandLineHelp.setWindowModality(Qt::WindowModal);
            commandLineHelp.setIcon(QMessageBox::Information);
            commandLineHelp.setWindowTitle(
                        (QApplication::tr("Command-Line Options")));
            commandLineHelp.setText(
                        "  --fullscreen -F<br>"
                        + (QApplication::tr(
                               "start browser in fullscreen mode"))
                        + "<br><br>"
                        + "  --help -H<br>"
                        + (QApplication::tr("this help")));
            commandLineHelp.setDefaultButton(QMessageBox::Ok);
            commandLineHelp.exec();
#endif
            return 1;
            QApplication::exit();
        }
    }

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
    if (isatty(fileno(stdin))) {
        std::cout << " " << std::endl
                  << application.applicationName().toLatin1().constData()
                  << " v." << application.applicationVersion()
                     .toLatin1().constData()
                  << std::endl
                  << "Command line: "
                  << allArguments.toLatin1().constData() << std::endl
                  << "Qt version: " << QT_VERSION_STR << std::endl
                  << "License: " << QLibraryInfo::licensedProducts()
                     .toLatin1().constData() << std::endl
                  << "Libraries Path: "
                  << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                     .toLatin1().constData() << std::endl;

        // Prevent starting as root from command line:
        if (userEuid == 0) {
            std::cout << "Started from terminal with root privileges. Aborting!"
                      << std::endl
                      << " " << std::endl;
            return 1;
            QApplication::exit();
        } else {
            std::cout << "Started from terminal with normal user privileges."
                      << std::endl;
            if (PERL_DEBUGGER_INTERACTION == 1) {
                std::cout << "Will start another instance of "
                          << "the program and quit this one."
                          << std::endl;
            }
            std::cout << " " << std::endl;
        }

        if (PERL_DEBUGGER_INTERACTION == 1) {
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
                            commandLineArguments);
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
    // DEFINE SETTINGS FILE VARIABLES:
    // ==============================
    QString settingsDirName;
    QString settingsFileName;

    // ==============================
    // GET BASIC APPLICATION INFO:
    // ==============================
    // Application start date and time for temporary folder name:
    QString applicationStartDateAndTime =
            QDateTime::currentDateTime().toString("yyyy-MM-dd--hh-mm-ss");
    application
            .setProperty("applicationStartDateAndTime",
                         applicationStartDateAndTime);

    // Get the name of the browser binary:
    QString applicationBinaryName =
            QFileInfo(QApplication::applicationFilePath()).baseName();

    // ==============================
    // SETTINGS FILES:
    // ==============================
    // Settings file is loaded from the directory of the binary file:
    if (settingsDirName.length() == 0 and settingsFileName.length() == 0) {
        QDir settingsDir =
                QDir::toNativeSeparators(application.applicationDirPath());
#ifdef Q_OS_MAC
        if (BUNDLE == 1) {
            settingsDir.cdUp();
            settingsDir.cdUp();
        }
#endif
        settingsDirName = settingsDir.absolutePath().toLatin1();
        settingsFileName = QDir::toNativeSeparators
                (settingsDirName + QDir::separator()
                 + applicationBinaryName + ".ini");
    }

    application.setProperty("settingsFileName", settingsFileName);

    if (!settingsDirName.endsWith(QDir::separator())) {
        settingsDirName.append(QDir::separator());
    }
    application.setProperty("settingsDirName", settingsDirName);

    QFile settingsFile(settingsFileName);

    // Check if settings file exists:
    if (!settingsFile.exists()) {
        QString title = QApplication::tr("Missing configuration file");
        QString text = QApplication::tr("Configuration file") +
                "<br>" +
                settingsFileName +
                "<br>" +
                QApplication::tr("is missing.") +
                "<br>" +
                QApplication::tr("Please restore it.");
        QMessageBox missingConfigurationFileMessageBox;
        missingConfigurationFileMessageBox.setWindowModality(Qt::WindowModal);
        missingConfigurationFileMessageBox
                .setIconPixmap(QString(":/icons/camel-icon-32.png"));
        missingConfigurationFileMessageBox.setWindowTitle(title);
        missingConfigurationFileMessageBox.setText(text);
        missingConfigurationFileMessageBox.setDefaultButton(QMessageBox::Ok);
        missingConfigurationFileMessageBox.exec();

        return 1;
        QApplication::exit();
    }

    // Define INI file format for storing settings:
    QSettings settings(settingsFileName, QSettings::IniFormat);

    // ==============================
    // BROWSER SETTINGS:
    // ==============================
    // Perl interpreter:
    QString perlInterpreterSetting = settings
            .value("browser/perl").toString();

    if (perlInterpreterSetting.length() == 0) {
        qDebug()  <<"No Perl interpreter is set in browser settings file.";
    }

    QString perlInterpreter;

    if (perlInterpreterSetting == "system") {
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

            if (perlInterpreter.length() == 0) {
                qDebug()  <<"No Perl interpreter is available on PATH";
            }
        }
    } else {
        QDir interpreterFile(perlInterpreterSetting);
        if (interpreterFile.isRelative()) {
            perlInterpreter =
                    QDir::toNativeSeparators(settingsDirName
                                             + perlInterpreterSetting);
        }
        if (interpreterFile.isAbsolute()) {
            perlInterpreter = QDir::toNativeSeparators(perlInterpreterSetting);
        }

        QFile perlInterpreterBinary(perlInterpreterSetting);

        if (perlInterpreterSetting.length() > 0 and
                !perlInterpreterBinary.exists()) {
            qDebug()  << "Perl interpreter from browser settings file"
                      << "is missing";
        }
    }

    application.setProperty("perlInterpreter", perlInterpreter);

    // PERLLIB environment variable:
    QString perlLibSetting = settings.value("browser/perllib").toString();
    QDir perlLibDir(QDir::toNativeSeparators(perlLibSetting));
    QString perlLib;
    if (perlLibDir.isRelative()) {
        perlLib = settingsDirName + perlLibSetting;
    }
    if (perlLibDir.isAbsolute()) {
        perlLib = perlLibSetting;
    }
    application.setProperty("perlLib", perlLib);

    // Logging enable/disable switch:
    QString logging = settings.value("browser/logging").toString();
    // Install message handler for redirecting all debug messages to a log file:
    if (logging == "enable") {
        qInstallMessageHandler(customMessageHandler);
    }

    // Logging mode - 'per_session_file' or 'single_file'.
    // 'single_file' means that only one single log file is created.
    // 'per_session' means that a separate log file is
    // created for every browser session. Application start date and time are
    // appended to the file name in this scenario.
    QString logMode = settings.value("browser/logging_mode").toString();
    application.setProperty("logMode", logMode);

    // Log files directory:
    QString logDirName = settings
            .value("browser/logging_directory").toString();
    QDir logDir(logDirName);
    QString logDirFullPath;
    if (!logDir.exists()) {
        logDir.mkpath(".");
    }
    if (logDir.isRelative()) {
        logDirFullPath = QDir::toNativeSeparators(settingsDirName + logDirName);
    }
    if (logDir.isAbsolute()) {
        logDirFullPath = QDir::toNativeSeparators(logDirName);
    }
    application.setProperty("logDirFullPath", logDirFullPath);

    // ==============================
    // PACKAGE SETTINGS:
    // ==============================
    // Package root directory:
    QString rootDirName;
    QString rootDirNameSetting = settings.value("package/root").toString();

    QDir rootDir(rootDirNameSetting);
    if (rootDir.isRelative()) {
        rootDirName = QDir::toNativeSeparators(
                    settingsDirName + rootDirNameSetting);
    }
    if (rootDir.isAbsolute()) {
        rootDirName = QDir::toNativeSeparators(rootDirNameSetting);
    }

    application.setProperty("rootDirName", rootDirName);

    // Start page -
    // path must be relative to the root directory of the current package.
    // HTML file or script are equally usable as a start page:
    QString startPagePath = settings.value("package/start_page").toString();
    application.setProperty("startPagePath", startPagePath);

    // Check if start page exists:
    QFile startPageFile(rootDirName + QDir::separator() + startPagePath);
    if (!startPageFile.exists()) {
        QString title = QApplication::tr("Missing start page");
        QString text = QApplication::tr("Start page is missing for") +
                "<br>" +
                application.applicationDisplayName() +
                QApplication::tr(" version ") +
                application.applicationVersion();
        QMessageBox missingStartPageMessageBox;
        missingStartPageMessageBox.setWindowModality(Qt::WindowModal);
        missingStartPageMessageBox.setIcon(QMessageBox::Critical);
        missingStartPageMessageBox.setWindowTitle(title);
        missingStartPageMessageBox.setText(text);
        missingStartPageMessageBox.setDefaultButton(QMessageBox::Ok);
        missingStartPageMessageBox.exec();

        return 1;
        QApplication::exit();
    }

    // Display or hide STDERR from scripts:
    QString displayStderr =
            settings.value("package/perl_display_stderr").toString();
    application.setProperty("displayStderr", displayStderr);

    // Fullscreen:
    QString fullscreen = settings.value("package/fullscreen").toString();
    application.setProperty("fullscreen", fullscreen);

    // Icon:
    QString iconPathNameSetting = settings.value("package/icon").toString();
    QString iconPathName;

    if (iconPathNameSetting.length() > 0) {
        iconPathName = QDir::toNativeSeparators(
                    rootDirName + QDir::separator() + iconPathNameSetting);
    }

    QFile iconFile(iconPathName);
    QPixmap icon(32, 32);
    if (iconFile.exists()) {
        application.setProperty("iconPathName", iconPathName);
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon
        // in case no external icon file is found:
        application.setProperty("iconPathName", ":/icons/camel-icon-32.png");
        icon.load(":/icons/camel-icon-32.png");
        QApplication::setWindowIcon(icon);
    }

    // Translation:
    QString translation =
            settings.value("package/translation").toString();
    QTranslator translator;
    if (translation != "none") {
        translator.load("peb_" + translation, ":/translations");
    }
    application.installTranslator(&translator);

    // Warn on exit:
    QString warnOnExit = settings
            .value("package/warn_on_exit_if_text_is_entered")
            .toString();
    application
            .setProperty("warnOnExitIfTextIsEntered", warnOnExit);

    // Web Inspector enable/disable switch:
    QString webInspector = settings
            .value("package/web_inspector").toString();
    application.setProperty("webInspector", webInspector);

    // ==============================
    // COMMAND LINE SETTING OVERRIDES:
    // ==============================
    // Command line arguments override
    // configuration file settings with the same name:
    foreach (QString argument, commandLineArguments) {
        if(argument.contains("--fullscreen") or argument.contains("-F")) {
            fullscreen = "fullscreen";
            application.setProperty("windowSize", fullscreen);
        }
    }

    // ==============================
    // LOG BASIC PROGRAM INFORMATION:
    // ==============================
    qDebug() << application.applicationName().toLatin1().constData()
             << "version"
             << application.applicationVersion().toLatin1().constData()
             << "started.";
    qDebug() << "Command line:" << allArguments.toLatin1().constData();
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug() << "License:"
             << QLibraryInfo::licensedProducts().toLatin1().constData();
    qDebug() << "Libraries Path:"
             << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                .toLatin1().constData();
    qDebug()  <<"Local pseudo-domain:" << PSEUDO_DOMAIN;
    if (SCRIPT_CENSORING == 0) {
        qDebug() << "Script censoring is disabled.";
    }
    if (SCRIPT_CENSORING == 1) {
        qDebug() << "Script censoring is enabled.";
    }
    if (PERL_DEBUGGER_INTERACTION == 0) {
        qDebug() << "Perl debugger interaction is disabled.";
    }
    if (PERL_DEBUGGER_INTERACTION == 1) {
        qDebug() << "Perl debugger interaction is enabled.";
    }
    qDebug() << "";
    qDebug() << "Settings file name:" << settingsFileName;
    qDebug() << "";

    // ==============================
    // MAIN GUI CLASS INITIALIZATION:
    // ==============================
    QWebViewWindow window;

    QObject::connect(qApp, SIGNAL(lastWindowClosed()),
                     &window, SLOT(qExitApplicationSlot()));

    window.setWindowIcon(icon);
    window.qLoadStartPageSlot();
    window.show();

    // ==============================
    // LOG ALL SETTINGS:
    // ==============================
    qDebug() << "";
    qDebug() << "Perl interpreter" << perlInterpreter;
    qDebug() << "PERLLIB folder:" << perlLib;
    qDebug() << "Logging:" << logging;
    qDebug() << "Logging mode:" << logMode;
    qDebug() << "Logfiles directory:" << logDirFullPath;

    qDebug() << "";
    qDebug() << "Package root folder:" << rootDirName;
    qDebug() << "Package start page:" << startPagePath;
    qDebug() << "Display STDERR from scripts:" << displayStderr;
    qDebug() << "Fullscreen:" << fullscreen;
    qDebug() << "Icon:" << iconPathName;
    qDebug() << "Translation:" << translation;
    qDebug() << "Warn on exit:" << warnOnExit;
    qDebug() << "Web Inspector from keyboard shortcut:" << webInspector;
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
    // DOCUMENT_ROOT:
    scriptEnvironment.insert("DOCUMENT_ROOT",
                             qApp->property("rootDirName").toString());

    // PERLLIB:
    scriptEnvironment.insert("PERLLIB", qApp->property("perlLib").toString());
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
    if ((qApp->property("webInspector").toString()) == "enable") {
        QWebSettings::globalSettings()->
                setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    }
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessFileUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::XSSAuditingEnabled, true);

    //QWebPage::setForwardUnsupportedContent(true);
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

    // READ INTERNALLY COMPILED JS SCRIPT:
    QFile file;
    file.setFileName(":/scripts/js/check-user-input-before-quit.js");
    file.open(QIODevice::ReadOnly);
    checkUserInputBeforeQuitJavaScript = file.readAll();
    file.close();
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

    if ((qApp->property("webInspector").toString()) == "enable") {
        QShortcut *qWebInspestorShortcut =
                new QShortcut(QKeySequence("Ctrl+I"), this);
        QObject::connect(qWebInspestorShortcut, SIGNAL(activated()),
                         this, SLOT(qStartQWebInspector()));
    }

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

    // To disable history:
    // QWebHistory *history = mainPage->history();
    // history->setMaximumItemCount(0);

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

    windowClosingStarted = false;
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
                         + tr("Perl modules (*.pm);;")
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
