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
// WINDOWS USER PRIVILEGES DETECTION SUBROUTINE:
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
    // BASIC APPLICATION VARIABLES:
    // ==============================
    application.setApplicationName("Perl Executing Browser");
    application.setApplicationVersion("0.2");
    bool startedAsRoot = false;

    // ==============================
    // UTF-8 ENCODING APPLICATION-WIDE:
    // ==============================
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // USER PRIVILEGES DETECTION:
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
    // START FROM TERMINAL:
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
    // BINARY FILE DIRECTORY:
    // ==============================
    QDir binaryDir = QDir::toNativeSeparators(application.applicationDirPath());

#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        binaryDir.cdUp();
        binaryDir.cdUp();
    }
#endif

    QString binaryDirName = binaryDir.absolutePath().toLatin1();

    // ==============================
    // PERL INTERPRETER:
    // ==============================
    QString perlExecutable;

#ifndef Q_OS_WIN
    perlExecutable = "perl";
#endif

#ifdef Q_OS_WIN
    perlExecutable = "perl.exe";
#endif

    QString perlInterpreterFullPath;
    QString privatePerlInterpreterFullPath = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "perl" + QDir::separator()
                + "bin" + QDir::separator()
                + perlExecutable);

    QFile privatePerlInterpreterFile(privatePerlInterpreterFullPath);
    if (!privatePerlInterpreterFile.exists()) {
        // Find the full path to the Perl interpreter on PATH:
        QProcess systemPerlTester;
        systemPerlTester.start("perl",
                               QStringList()
                               << "-e"
                               << "print $^X;");

        QByteArray testingScriptResultArray;
        if (systemPerlTester.waitForFinished()) {
            testingScriptResultArray = systemPerlTester.readAllStandardOutput();
        }
        perlInterpreterFullPath = QString::fromLatin1(testingScriptResultArray);
    } else {
        perlInterpreterFullPath = privatePerlInterpreterFullPath;
    }

    application.setProperty("perlInterpreter", perlInterpreterFullPath);

    // ==============================
    // APPLICATION DIRECTORY:
    // ==============================
    QString applicationDirName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app");

    application.setProperty("application", applicationDirName);

    // ==============================
    // APPLICATION ICON:
    // ==============================
    QString iconPathName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app.png");

    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);
    if (iconFile.exists()) {
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon
        // in case no external icon file is found:
        icon.load(":/icons/camel.png");
        QApplication::setWindowIcon(icon);
    }

    // ==============================
    // TRUSTED DOMAINS:
    // ==============================
    QString trustedDomainsFilePath =
            applicationDirName + QDir::separator() + "trusted-domains.json";
    QFile trustedDomainsFile(trustedDomainsFilePath);
    QStringList trustedDomainsList;

    if (trustedDomainsFile.exists()) {
        QFileReader *resourceReader =
                new QFileReader(QString(trustedDomainsFilePath));
        QString trustedDomainsContents = resourceReader->fileContents;

        QJsonDocument trustedDomainsJsonDocument =
                QJsonDocument::fromJson(trustedDomainsContents.toUtf8());

        if (!trustedDomainsJsonDocument.isNull()) {
            QJsonObject trustedDomainsJsonObject =
                    trustedDomainsJsonDocument.object();

            if (!trustedDomainsJsonObject.isEmpty()) {
                QJsonArray trustedDomainsArray =
                        trustedDomainsJsonObject["trusted-domains"].toArray();

                if (!trustedDomainsArray.isEmpty()) {
                    foreach (QVariant trustedDomain, trustedDomainsArray) {
                        trustedDomainsList.append(trustedDomain.toString());
                    }
                }
            }
        }

        trustedDomainsList.append(PSEUDO_DOMAIN);
        application.setProperty("trustedDomains", trustedDomainsList);
    }

    // ==============================
    // LOGGING:
    // ==============================
    // If 'logs' directory is found in the directory of the browser binary,
    // all program messages will be redirected to log files,
    // otherwise no log files will be created and
    // program messages could be seen inside Qt Creator.
    QString logDirFullPath = binaryDirName + QDir::separator() + "logs";
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

    // ==============================
    // MAIN GUI CLASSES INITIALIZATION:
    // ==============================
    QMainBrowserWindow mainWindow;
    mainWindow.webViewWidget = new QWebViewWidget();

    // Application property necessary when
    // closing the main window is requested using
    // the special window closing URL.
    qApp->setProperty("mainWindowCloseRequested", false);

    // Signal and slot for setting the main window title:
    QObject::connect(mainWindow.webViewWidget,
                     SIGNAL(titleChanged(QString)),
                     &mainWindow, SLOT(setMainWindowTitleSlot(QString)));

    // Signal and slot for actions taken before application exit:
    QObject::connect(qApp, SIGNAL(aboutToQuit()),
                     &mainWindow, SLOT(qExitApplicationSlot()));

    // ==============================
    // ADMINISTRATIVE PRIVILEGES ERROR MESSAGE:
    // ==============================
    if (startedAsRoot == true) {
        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

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

    // ==============================
    // MISSING PERL INTERPRETER ERROR MESSAGE:
    // ==============================
    if (perlInterpreterFullPath.length() == 0) {
        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        QString errorMessage = privatePerlInterpreterFullPath + "<br>"
                + "is not found and "
                + "no Perl interpreter is available on PATH.";
        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

        mainWindow.webViewWidget->setHtml(htmlErrorContents);

        qDebug() << application.applicationName().toLatin1().constData()
                 << application.applicationVersion().toLatin1().constData()
                 << "started.";
        qDebug() << "Qt version:" << QT_VERSION_STR;
        qDebug() << "Executable:" << application.applicationFilePath();
        qDebug() << "No Perl interpreter is found.";
    }

    if (startedAsRoot == false and perlInterpreterFullPath.length() > 0) {
        // ==============================
        // LOG BASIC PROGRAM INFORMATION AND SETTINGS:
        // ==============================
        qDebug() << application.applicationName().toLatin1().constData()
                 << application.applicationVersion().toLatin1().constData()
                 << "started.";
        qDebug() << "Qt version:" << QT_VERSION_STR;
        qDebug() << "Executable:" << application.applicationFilePath();
        qDebug()  <<"Local pseudo-domain:" << PSEUDO_DOMAIN;
        foreach (QString trustedDomain, trustedDomainsList) {
            qDebug() << "Trusted domain:" << trustedDomain;
        }
        if (PERL_DEBUGGER_INTERACTION == 0) {
            qDebug() << "Perl debugger interaction is disabled.";
        }
        if (PERL_DEBUGGER_INTERACTION == 1) {
            qDebug() << "Perl debugger interaction is enabled.";
        }
        qDebug() << "Perl interpreter:" << perlInterpreterFullPath;

        // ==============================
        // START PAGE EXISTENCE CHECK AND LOADING:
        // ==============================
        QString startPage;
        QFile staticStartPageFile(
                    applicationDirName + QDir::separator() + "index.html");

        if (staticStartPageFile.exists()) {
            startPage = "http://" + QString(PSEUDO_DOMAIN) + "/index.html";

            application.setProperty("startPage", startPage);

            mainWindow.webViewWidget->setUrl(QUrl(startPage));
        } else {
            QFile dynamicStartPageFile(
                        applicationDirName + QDir::separator() + "index.pl");
            if (dynamicStartPageFile.exists()) {
                startPage = "http://" + QString(PSEUDO_DOMAIN) + "/index.pl";

                application.setProperty("startPage", startPage);

                mainWindow.webViewWidget->setUrl(QUrl(startPage));
            } else {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                QString errorMessage = "No start page is found.";
                htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
                mainWindow.webViewWidget->setHtml(htmlErrorContents);

                qDebug() << "No start page is found.";
            }
        }
    }

    mainWindow.setCentralWidget(mainWindow.webViewWidget);
    mainWindow.setWindowIcon(icon);
    mainWindow.showMaximized();
    return application.exec();
}

// ==============================
// FILE READER CONSTRUCTOR:
// Usefull for both files inside binary resources and files on disk
// ==============================
QFileReader::QFileReader(QString filePath)
    : QObject(0)
{
    QString fileName(filePath);
    QFile file(fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream fileStream(&file);
    fileContents = fileStream.readAll();
    file.close();
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
// CUSTOM NETWORK REPLY CONSTRUCTOR:
// ==============================
struct QCustomNetworkReplyPrivate
{
    QByteArray data;
    int offset;
};

QCustomNetworkReply::QCustomNetworkReply(
        const QUrl &url, const QString &data, const QString &mime)
    : QNetworkReply()
{
    setFinished(true);
    open(ReadOnly | Unbuffered);

    reply = new QCustomNetworkReplyPrivate;
    reply->offset = 0;

    setUrl(url);

    if (data.length() > 0) {
        setHeader(QNetworkRequest::ContentLengthHeader,
                  QVariant(reply->data.size()));
        setHeader(QNetworkRequest::LastModifiedHeader,
                  QVariant(QDateTime::currentDateTimeUtc()));
        setHeader(QNetworkRequest::ContentTypeHeader, mime);
    }

    QTimer::singleShot(0, this, SIGNAL(metaDataChanged()));

    if (data.length() > 0) {
        setAttribute(QNetworkRequest::HttpStatusCodeAttribute, 200);
        setAttribute(QNetworkRequest::HttpReasonPhraseAttribute, "OK");
        reply->data = data.toUtf8();
    } else {
        setAttribute(QNetworkRequest::HttpStatusCodeAttribute, 204);
    }

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
// LONG RUNNING SCRIPT HANDLER CONSTRUCTOR:
// ==============================
QLongRunScriptHandler::QLongRunScriptHandler(QUrl url, QByteArray postDataArray)
    : QObject(0)
{
    // Signals and slots for local long running Perl scripts:
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qLongrunScriptOutputSlot()));
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardError()),
                     this, SLOT(qLongrunScriptErrorsSlot()));
    QObject::connect(&scriptHandler,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qLongrunScriptFinishedSlot()));

    QUrlQuery scriptQuery(url);
    scriptOutputTarget = scriptQuery.queryItemValue("target");
    scriptQuery.removeQueryItem("target");
    // qDebug() << "Script output target:" << scriptOutputTarget;

    scriptFullFilePath = QDir::toNativeSeparators
            ((qApp->property("application").toString()) + url.path());

    QString queryString = scriptQuery.toString();
    QString postData(postDataArray);

    QProcessEnvironment scriptEnvironment =
            QProcessEnvironment::systemEnvironment();

    if (queryString.length() > 0) {
        scriptEnvironment.insert("REQUEST_METHOD", "GET");
        scriptEnvironment.insert("QUERY_STRING", queryString);
        // qDebug() << "Query string:" << queryString;
    }

    if (postData.length() > 0) {
        scriptEnvironment.insert("REQUEST_METHOD", "POST");
        QString postDataSize = QString::number(postData.size());
        scriptEnvironment.insert("CONTENT_LENGTH", postDataSize);
        // qDebug() << "POST data:" << postData;
    }

    scriptHandler.setProcessEnvironment(scriptEnvironment);

    QFileReader *resourceReader =
            new QFileReader(QString(scriptFullFilePath));
    QString fileContents = resourceReader->fileContents;

    scriptHandler.start((qApp->property("perlInterpreter").toString()),
                        QStringList()
                        << "-M-ops=fork"
                        << "-e"
                        << fileContents,
                        QProcess::Unbuffered | QProcess::ReadWrite);

    if (postData.length() > 0) {
        scriptHandler.write(postDataArray);
    }

    qDebug() << "Script started:" << scriptFullFilePath;
}

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
QPage::QPage()
    : QWebPage(0)
{
    // QWebPage settings:
    QNetworkProxyFactory::setUseSystemConfiguration(true);
    QWebSettings::globalSettings()->
            setDefaultTextEncoding(QString("utf-8"));
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PluginsEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavaEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanOpenWindows, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanAccessClipboard, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessFileUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::XSSAuditingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::DeveloperExtrasEnabled, true);

    // No download of files:
    setForwardUnsupportedContent(false);

    // Disabled cache:
    QWebSettings::setMaximumPagesInCache(0);
    QWebSettings::setObjectCacheCapacities(0, 0, 0);

    // Disabled history:
    QWebHistory *history = this->history();
    history->setMaximumItemCount(0);

    // Initialization of a modified Network Access Manager:
    QAccessManager *networkAccessManager = new QAccessManager();

    // Cookies and HTTPS support:
    QNetworkCookieJar *cookieJar = new QNetworkCookieJar;
    networkAccessManager->setCookieJar(cookieJar);

    // Using the modified Network Access Manager:
    setNetworkAccessManager(networkAccessManager);

    // Signal and slot for SSL errors:
    QObject::connect(networkAccessManager,
                     SIGNAL(sslErrors(QNetworkReply*, QList<QSslError>)),
                     this,
                     SLOT(qSslErrorsSlot(QNetworkReply*, QList<QSslError>)));

    // Signal and slot for other network errors:
    QObject::connect(networkAccessManager,
                     SIGNAL(finished(QNetworkReply*)),
                     this,
                     SLOT(qNetworkReply(QNetworkReply*)));

    // Signal and slot for the detection of page status:
    QObject::connect(this,
                     SIGNAL(pageStatusSignal(QString)),
                     networkAccessManager,
                     SLOT(qPageStatusSlot(QString)));

    // Signals and slots for actions taken after page is loaded:
    QObject::connect(this, SIGNAL(loadFinished(bool)),
                     this, SLOT(qPageLoadedSlot(bool)));

    // Signal and slot for starting local scripts:
    QObject::connect(networkAccessManager,
                     SIGNAL(startScriptSignal(QUrl, QByteArray)),
                     this,
                     SLOT(qStartScriptSlot(QUrl, QByteArray)));

    // Signal and slot for closing window from URL:
    QObject::connect(networkAccessManager,
                     SIGNAL(closeWindowSignal()),
                     this,
                     SLOT(qCloseWindowFromURLTransmitterSlot()));

    // Scroll bars:
    mainFrame()->setScrollBarPolicy(Qt::Horizontal,
                                              Qt::ScrollBarAsNeeded);
    mainFrame()->setScrollBarPolicy(Qt::Vertical,
                                              Qt::ScrollBarAsNeeded);

    // Regular expression for detection of HTML file extensions:
    htmlFileNameExtensionMarker.setPattern(".htm{0,1}");
    htmlFileNameExtensionMarker.setCaseSensitivity(Qt::CaseInsensitive);

    // Default labels for JavaScript 'Alert', 'Confirm' and 'Prompt' dialogs:
    alertTitle = "Alert";
    confirmTitle = "Confirmation";
    promptTitle = "Prompt";

    okLabel = "Ok";
    cancelLabel = "Cancel";
    yesLabel = "Yes";
    noLabel = "No";

    // Signals and slots for the perl debugger:
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
}

// ==============================
// WEB VIEW CLASS CONSTRUCTOR:
// ==============================
QWebViewWidget::QWebViewWidget()
    : QWebView(0)
{
    // Keyboard shortcuts:
#ifndef QT_NO_PRINTER
    QShortcut *printShortcut = new QShortcut(QKeySequence("Ctrl+P"), this);
    QObject::connect(printShortcut, SIGNAL(activated()),
                     this, SLOT(qPrintSlot()));
#endif

    QShortcut *qWebInspestorShortcut =
            new QShortcut(QKeySequence("Ctrl+I"), this);
    QObject::connect(qWebInspestorShortcut, SIGNAL(activated()),
                     this, SLOT(qStartQWebInspector()));

    // Starting of a QPage instance:
    mainPage = new QPage();

    // Signal and slot for displaying script errors:
    QObject::connect(mainPage, SIGNAL(displayScriptErrorsSignal(QString)),
                     this, SLOT(qDisplayScriptErrorsSlot(QString)));

    // Signals and slots for printing:
    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));

    // Signal and slot for changing window title:
    QObject::connect(mainPage, SIGNAL(changeTitleSignal()),
                     this, SLOT(qChangeTitleSlot()));

    // Signal and slot for selecting files or folders from URL:
    QObject::connect(mainPage, SIGNAL(selectInodeSignal(QNetworkRequest)),
                     this, SLOT(qSelectInodesSlot(QNetworkRequest)));

    // Signal and slot for closing window from URL:
    QObject::connect(mainPage, SIGNAL(closeWindowSignal()),
                     this, SLOT(qCloseWindowFromURLSlot()));

    // Installing of the started QPage instance:
    setPage(mainPage);

    // Initialization of a variable necessary for
    // user input check before closing a new window
    // (any window opened after the initial one):
    windowCloseRequested = false;
}

// ==============================
// CLICKING OF LINKS MANAGEMENT:
// ==============================
bool QPage::acceptNavigationRequest(QWebFrame *frame,
                                    const QNetworkRequest &request,
                                    QWebPage::NavigationType navigationType)
{
    // ==============================
    // Untrusted domains called from a trusted page
    // are loaded in new browser windows:
    // ==============================
    QStringList trustedDomains =
            qApp->property("trustedDomains").toStringList();

    if (pageStatus == "trusted" and
            (!trustedDomains.contains(request.url().authority())) and
            (request.url().fileName().length() == 0 or
             request.url().fileName().contains(htmlFileNameExtensionMarker))) {
        QWebPage *page =
                QPage::createWindow(QWebPage::WebBrowserWindow);
        page->mainFrame()->load(request.url());

        return false;
    }

    if (request.url().authority() == PSEUDO_DOMAIN) {
        // ==============================
        // Start page is displayed only in
        // the main frame of a browser window:
        // ==============================
        if (navigationType == QWebPage::NavigationTypeLinkClicked and
                request.url() == qApp->property("startPage").toString()) {
            mainFrame()->setUrl(request.url());
        }

        if (pageStatus == "trusted") {
            // ==============================
            // User selected single file:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-file.function") {
                if (request.url().query().replace("target=", "").length() > 0) {
                    emit selectInodeSignal(request);
                }

                return false;
            }

            // ==============================
            // User selected multiple files:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-files.function") {
                if (request.url().query().replace("target=", "").length() > 0) {
                    emit selectInodeSignal(request);
                }

                return false;
            }

            // ==============================
            // User selected new file name:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "new-file-name.function") {
                if (request.url().query().replace("target=", "").length() > 0) {
                    emit selectInodeSignal(request);
                }

                return false;
            }

            // ==============================
            // User selected directory:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-directory.function") {
                if (request.url().query().replace("target=", "").length() > 0) {
                    emit selectInodeSignal(request);
                }

                return false;
            }

#ifndef QT_NO_PRINTER
            // ==============================
            // Print preview from URL:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "print.function" and
                    request.url().query() == "action=preview") {

                emit printPreviewSignal();

                return false;
            }

            // ==============================
            // Print page from URL:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "print.function" and
                    request.url().query() == "action=print") {
                emit printSignal();

                return false;
            }
#endif

            // ==============================
            // About browser dialog box:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "about.function" and
                    request.url().query() == "type=browser") {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/about.html"));
                QString aboutPageContents = resourceReader->fileContents;

                aboutPageContents
                        .replace("VERSION_STRING",
                                 QApplication::applicationVersion().toLatin1());

                frame->setHtml(aboutPageContents);

                return false;
            }

            // ==============================
            // About Qt dialog box:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "about.function" and
                    request.url().query() == "type=qt") {
                QApplication::aboutQt();

                return false;
            }

            // ==============================
            // PERL DEBUGGER INTERACTION:
            // Implementation of an idea proposed by Valcho Nedelchev.
            // ==============================
            if (PERL_DEBUGGER_INTERACTION == 1) {
                if ((navigationType == QWebPage::NavigationTypeLinkClicked or
                     navigationType == QWebPage::NavigationTypeFormSubmitted)
                        and
                        request.url().fileName() == "perl-debugger.function") {
                    debuggerFrame = frame;

                    // Get a Perl debugger command (if any):
                    QUrlQuery scriptQuery(request.url());
                    debuggerLastCommand = scriptQuery.queryItemValue("command");

                    // Select a Perl script for debugging:
                    if (request.url().query().contains("action=select-file")) {

                        QFileDialog selectScriptToDebugDialog(
                                    qApp->activeWindow());
                        selectScriptToDebugDialog
                                .setFileMode(QFileDialog::ExistingFile);
                        selectScriptToDebugDialog
                                .setViewMode(QFileDialog::Detail);
                        selectScriptToDebugDialog
                                .setWindowModality(Qt::WindowModal);

                        debuggerScriptToDebug = selectScriptToDebugDialog
                                .getOpenFileName
                                (qApp->activeWindow(),
                                 "Select Perl File",
                                 QDir::currentPath(),
                                 "Perl scripts (*.pl);;All files (*)");

                        selectScriptToDebugDialog.close();
                        selectScriptToDebugDialog.deleteLater();

                        if (debuggerScriptToDebug.length() > 1) {
                            debuggerScriptToDebug =
                                    QDir::toNativeSeparators(
                                        debuggerScriptToDebug);

                            // Close any still open Perl debugger session:
                            debuggerHandler.close();

                            // Start the Perl debugger:
                            qStartPerlDebuggerSlot();
                            return false;
                        } else {
                            return false;
                        }
                    }

                    qStartPerlDebuggerSlot();
                    return false;
                }
            }
        }

        if (pageStatus == "untrusted") {
            qMixedContentWarning(request.url());
        }
    }

    return QWebPage::acceptNavigationRequest(frame, request, navigationType);
}
