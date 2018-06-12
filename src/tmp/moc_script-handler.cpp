/****************************************************************************
** Meta object code from reading C++ file 'script-handler.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../script-handler.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'script-handler.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_QScriptHandler_t {
    QByteArrayData data[11];
    char stringdata0[178];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QScriptHandler_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QScriptHandler_t qt_meta_stringdata_QScriptHandler = {
    {
QT_MOC_LITERAL(0, 0, 14), // "QScriptHandler"
QT_MOC_LITERAL(1, 15, 25), // "displayScriptOutputSignal"
QT_MOC_LITERAL(2, 41, 0), // ""
QT_MOC_LITERAL(3, 42, 8), // "scriptId"
QT_MOC_LITERAL(4, 51, 6), // "output"
QT_MOC_LITERAL(5, 58, 20), // "scriptFinishedSignal"
QT_MOC_LITERAL(6, 79, 18), // "scriptFullFilePath"
QT_MOC_LITERAL(7, 98, 23), // "scriptAccumulatedErrors"
QT_MOC_LITERAL(8, 122, 17), // "qScriptOutputSlot"
QT_MOC_LITERAL(9, 140, 17), // "qScriptErrorsSlot"
QT_MOC_LITERAL(10, 158, 19) // "qScriptFinishedSlot"

    },
    "QScriptHandler\0displayScriptOutputSignal\0"
    "\0scriptId\0output\0scriptFinishedSignal\0"
    "scriptFullFilePath\0scriptAccumulatedErrors\0"
    "qScriptOutputSlot\0qScriptErrorsSlot\0"
    "qScriptFinishedSlot"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QScriptHandler[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    2,   39,    2, 0x06 /* Public */,
       5,    3,   44,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       8,    0,   51,    2, 0x0a /* Public */,
       9,    0,   52,    2, 0x0a /* Public */,
      10,    0,   53,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    3,    4,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    3,    6,    7,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void QScriptHandler::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QScriptHandler *_t = static_cast<QScriptHandler *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->displayScriptOutputSignal((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: _t->scriptFinishedSignal((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 2: _t->qScriptOutputSlot(); break;
        case 3: _t->qScriptErrorsSlot(); break;
        case 4: _t->qScriptFinishedSlot(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QScriptHandler::*_t)(QString , QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QScriptHandler::displayScriptOutputSignal)) {
                *result = 0;
            }
        }
        {
            typedef void (QScriptHandler::*_t)(QString , QString , QString );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QScriptHandler::scriptFinishedSignal)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject QScriptHandler::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_QScriptHandler.data,
      qt_meta_data_QScriptHandler,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QScriptHandler::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QScriptHandler::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QScriptHandler.stringdata0))
        return static_cast<void*>(const_cast< QScriptHandler*>(this));
    return QObject::qt_metacast(_clname);
}

int QScriptHandler::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
    return _id;
}

// SIGNAL 0
void QScriptHandler::displayScriptOutputSignal(QString _t1, QString _t2)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void QScriptHandler::scriptFinishedSignal(QString _t1, QString _t2, QString _t3)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
