/****************************************************************************
** Meta object code from reading C++ file 'webkit-view.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../webkit-view.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'webkit-view.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_QViewWidget_t {
    QByteArrayData data[18];
    char stringdata0[256];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_QViewWidget_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_QViewWidget_t qt_meta_stringdata_QViewWidget = {
    {
QT_MOC_LITERAL(0, 0, 11), // "QViewWidget"
QT_MOC_LITERAL(1, 12, 24), // "startWindowClosingSignal"
QT_MOC_LITERAL(2, 37, 0), // ""
QT_MOC_LITERAL(3, 38, 15), // "qPageLoadedSlot"
QT_MOC_LITERAL(4, 54, 16), // "contextMenuEvent"
QT_MOC_LITERAL(5, 71, 18), // "QContextMenuEvent*"
QT_MOC_LITERAL(6, 90, 5), // "event"
QT_MOC_LITERAL(7, 96, 10), // "qCutAction"
QT_MOC_LITERAL(8, 107, 11), // "qCopyAction"
QT_MOC_LITERAL(9, 119, 12), // "qPasteAction"
QT_MOC_LITERAL(10, 132, 16), // "qSelectAllAction"
QT_MOC_LITERAL(11, 149, 22), // "qStartPrintPreviewSlot"
QT_MOC_LITERAL(12, 172, 17), // "qPrintPreviewSlot"
QT_MOC_LITERAL(13, 190, 9), // "QPrinter*"
QT_MOC_LITERAL(14, 200, 7), // "printer"
QT_MOC_LITERAL(15, 208, 10), // "qPrintSlot"
QT_MOC_LITERAL(16, 219, 19), // "qStartQWebInspector"
QT_MOC_LITERAL(17, 239, 16) // "qCloseWindowSlot"

    },
    "QViewWidget\0startWindowClosingSignal\0"
    "\0qPageLoadedSlot\0contextMenuEvent\0"
    "QContextMenuEvent*\0event\0qCutAction\0"
    "qCopyAction\0qPasteAction\0qSelectAllAction\0"
    "qStartPrintPreviewSlot\0qPrintPreviewSlot\0"
    "QPrinter*\0printer\0qPrintSlot\0"
    "qStartQWebInspector\0qCloseWindowSlot"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_QViewWidget[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   74,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       3,    0,   75,    2, 0x0a /* Public */,
       4,    1,   76,    2, 0x0a /* Public */,
       7,    0,   79,    2, 0x0a /* Public */,
       8,    0,   80,    2, 0x0a /* Public */,
       9,    0,   81,    2, 0x0a /* Public */,
      10,    0,   82,    2, 0x0a /* Public */,
      11,    0,   83,    2, 0x0a /* Public */,
      12,    1,   84,    2, 0x0a /* Public */,
      15,    0,   87,    2, 0x0a /* Public */,
      16,    0,   88,    2, 0x0a /* Public */,
      17,    0,   89,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 5,    6,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 13,   14,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void QViewWidget::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        QViewWidget *_t = static_cast<QViewWidget *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->startWindowClosingSignal(); break;
        case 1: _t->qPageLoadedSlot(); break;
        case 2: _t->contextMenuEvent((*reinterpret_cast< QContextMenuEvent*(*)>(_a[1]))); break;
        case 3: _t->qCutAction(); break;
        case 4: _t->qCopyAction(); break;
        case 5: _t->qPasteAction(); break;
        case 6: _t->qSelectAllAction(); break;
        case 7: _t->qStartPrintPreviewSlot(); break;
        case 8: _t->qPrintPreviewSlot((*reinterpret_cast< QPrinter*(*)>(_a[1]))); break;
        case 9: _t->qPrintSlot(); break;
        case 10: _t->qStartQWebInspector(); break;
        case 11: _t->qCloseWindowSlot(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (QViewWidget::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&QViewWidget::startWindowClosingSignal)) {
                *result = 0;
            }
        }
    }
}

const QMetaObject QViewWidget::staticMetaObject = {
    { &QWebView::staticMetaObject, qt_meta_stringdata_QViewWidget.data,
      qt_meta_data_QViewWidget,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *QViewWidget::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *QViewWidget::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_QViewWidget.stringdata0))
        return static_cast<void*>(const_cast< QViewWidget*>(this));
    return QWebView::qt_metacast(_clname);
}

int QViewWidget::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWebView::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void QViewWidget::startWindowClosingSignal()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
