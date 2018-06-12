/****************************************************************************
** Meta object code from reading C++ file 'webkit-main-window.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../webkit-main-window.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'webkit-main-window.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_QMainBrowserWindow_t {
    QByteArrayData data[12];
    char stringdata0[177];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QMainBrowserWindow_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QMainBrowserWindow_t qt_meta_stringdata_QMainBrowserWindow = {
    {
QT_MOC_LITERAL(0, 0, 18), // "QMainBrowserWindow"
QT_MOC_LITERAL(1, 19, 28), // "startMainWindowClosingSignal"
QT_MOC_LITERAL(2, 48, 0), // ""
QT_MOC_LITERAL(3, 49, 13), // "qDisplayError"
QT_MOC_LITERAL(4, 63, 12), // "errorMessage"
QT_MOC_LITERAL(5, 76, 20), // "qLocalServerPingSlot"
QT_MOC_LITERAL(6, 97, 22), // "setMainWindowTitleSlot"
QT_MOC_LITERAL(7, 120, 5), // "title"
QT_MOC_LITERAL(8, 126, 10), // "closeEvent"
QT_MOC_LITERAL(9, 137, 12), // "QCloseEvent*"
QT_MOC_LITERAL(10, 150, 5), // "event"
QT_MOC_LITERAL(11, 156, 20) // "qExitApplicationSlot"

    },
    "QMainBrowserWindow\0startMainWindowClosingSignal\0"
    "\0qDisplayError\0errorMessage\0"
    "qLocalServerPingSlot\0setMainWindowTitleSlot\0"
    "title\0closeEvent\0QCloseEvent*\0event\0"
    "qExitApplicationSlot"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QMainBrowserWindow[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    1,   45,    2, 0x0a /* Public */,
       5,    0,   48,    2, 0x0a /* Public */,
       6,    1,   49,    2, 0x0a /* Public */,
       8,    1,   52,    2, 0x0a /* Public */,
      11,    0,   55,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, 0x80000000 | 9,   10,
    QMetaType::Void,

       0        // eod
};

void QMainBrowserWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QMainBrowserWindow *_t = static_cast<QMainBrowserWindow *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->startMainWindowClosingSignal(); break;
        case 1: _t->qDisplayError((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->qLocalServerPingSlot(); break;
        case 3: _t->setMainWindowTitleSlot((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->closeEvent((*reinterpret_cast< QCloseEvent*(*)>(_a[1]))); break;
        case 5: _t->qExitApplicationSlot(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QMainBrowserWindow::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QMainBrowserWindow::startMainWindowClosingSignal)) {
                *result = 0;
            }
        }
    }
}

const QMetaObject QMainBrowserWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_QMainBrowserWindow.data,
      qt_meta_data_QMainBrowserWindow,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QMainBrowserWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QMainBrowserWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QMainBrowserWindow.stringdata0))
        return static_cast<void*>(const_cast< QMainBrowserWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int QMainBrowserWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void QMainBrowserWindow::startMainWindowClosingSignal()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
