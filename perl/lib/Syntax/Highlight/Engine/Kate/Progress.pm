# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'progress.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.08
#kate version 2.4
#kate author Rares Stanciulescu (rstanciu@operamail.com)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::Progress;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Alert' => 'Alert',
      'Attributes' => 'DataType',
      'Comment' => 'Comment',
      'Data_Type' => 'DataType',
      'Decimal' => 'DecVal',
      'Function' => 'Function',
      'Handles' => 'DecVal',
      'Identifier' => 'Others',
      'Integer' => 'BaseN',
      'Methods' => 'Others',
      'Normal Text' => 'Normal',
      'Operators' => 'DecVal',
      'Phrases' => 'Keyword',
      'Preprocvar' => 'Char',
      'Properties' => 'Others',
      'Region Marker' => 'RegionMarker',
      'Statements' => 'Keyword',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Char',
      'Widgets' => 'Keyword',
   });
   $self->listAdd('attributes',
      'ACCELERATOR',
      'ACTIVE',
      'ACTOR',
      'ADM-DATA',
      'AFTER-BUFFER',
      'AFTER-ROWID',
      'AFTER-TABLE',
      'ALLOW-COLUMN-SEARCHING',
      'ALWAYS-ON-TOP',
      'AMBIGUOUS',
      'APPL-ALERT-BOXES',
      'APPSERVER-INFO',
      'APPSERVER-PASSWORD',
      'APPSERVER-USERID',
      'ASYNC-REQUEST-COUNT',
      'ASYNC-REQUEST-HANDLE',
      'ASYNCHRONOUS',
      'ATTR-SPACE',
      'ATTRIBUTE-NAMES',
      'AUTO-COMPLETION',
      'AUTO-DELETE',
      'AUTO-ENDKEY',
      'AUTO-GO',
      'AUTO-INDENT',
      'AUTO-RESIZE',
      'AUTO-RETURN',
      'AUTO-VALIDATE',
      'AUTO-ZAP',
      'AVAILABLE',
      'AVAILABLE-FORMATS',
      'BACKGROUND',
      'BASE-ADE',
      'BASIC-LOGGING',
      'BATCH-MODE',
      'BEFORE-BUFFER',
      'BEFORE-ROWID',
      'BEFORE-TABLE',
      'BGCOLOR',
      'BLANK',
      'BLOCK-ITERATION-DISPLAY',
      'BORDER-BOTTOM-CHARS',
      'BORDER-BOTTOM-PIXELS',
      'BORDER-LEFT-CHARS',
      'BORDER-LEFT-PIXELS',
      'BORDER-RIGHT-CHARS',
      'BORDER-RIGHT-PIXELS',
      'BORDER-TOP-CHARS',
      'BORDER-TOP-PIXELS',
      'BOX',
      'BOX-SELECTABLE',
      'BUFFER-CHARS',
      'BUFFER-FIELD',
      'BUFFER-HANDLE',
      'BUFFER-LINES',
      'BUFFER-NAME',
      'BUFFER-VALUE',
      'BYTES-READ',
      'BYTES-WRITTEN',
      'CACHE',
      'CALL-NAME',
      'CALL-TYPE',
      'CAN-CREATE',
      'CAN-DELETE',
      'CAN-READ',
      'CAN-WRITE',
      'CANCEL-BUTTON',
      'CANCELLED',
      'CAREFUL-PAINT',
      'CASE-SENSITIVE',
      'CENTERED',
      'CHARSET',
      'CHECKED',
      'CHILD-BUFFER',
      'CHILD-NUM',
      'CLIENT-CONNECTION-ID',
      'CLIENT-TYPE',
      'CODE',
      'CODEPAGE',
      'COL',
      'COLUMN',
      'COLUMN-BGCOLOR',
      'COLUMN-DCOLOR',
      'COLUMN-FGCOLOR',
      'COLUMN-FONT',
      'COLUMN-LABEL',
      'COLUMN-MOVABLE',
      'COLUMN-PFCOLOR',
      'COLUMN-READ-ONLY',
      'COLUMN-RESIZABLE',
      'COLUMN-SCROLLING',
      'COM-HANDLE',
      'COMPLETE',
      'CONTEXT-HELP',
      'CONTEXT-HELP-FILE',
      'CONTEXT-HELP-ID',
      'CONTROL-BOX',
      'CONVERT-D-COLORS',
      'CPCASE',
      'CPCOLL',
      'CPINTERNAL',
      'CPLOG',
      'CPPRINT',
      'CPRCODEIN',
      'CPRCODEOUT',
      'CPSTREAM',
      'CPTERM',
      'CRC-VALUE',
      'CURRENT-CHANGED',
      'CURRENT-COLUMN',
      'CURRENT-ITERATION',
      'CURRENT-RESULT-ROW',
      'CURRENT-ROW-MODIFIED',
      'CURRENT-WINDOW',
      'CURSOR-CHAR',
      'CURSOR-LINE',
      'CURSOR-OFFSET',
      'DATA-ENTRY-RETURN',
      'DATA-SOURCE',
      'DATA-TYPE',
      'DATASET',
      'DATE-FORMAT',
      'DB-REFERENCES',
      'DBNAME',
      'DCOLOR',
      'DDE-ERROR',
      'DDE-ID',
      'DDE-ITEM',
      'DDE-NAME',
      'DDE-TOPIC',
      'DEBLANK',
      'DEBUG-ALERT',
      'DECIMALS',
      'DEFAULT',
      'DEFAULT-BUFFER-HANDLE',
      'DEFAULT-BUTTON',
      'DEFAULT-COMMIT',
      'DELIMITER',
      'DISABLE-AUTO-ZAP',
      'DISPLAY',
      'DISPLAY-TIMEZONE',
      'DISPLAY-TYPE',
      'DOWN',
      'DRAG-ENABLED',
      'DROP-TARGET',
      'DYNAMIC',
      'EDGE-CHARS',
      'EDGE-PIXELS',
      'EDIT-CAN-PASTE',
      'EDIT-CAN-UNDO',
      'EMPTY',
      'ENCODING',
      'END-USER-PROMPT',
      'ENTRY-TYPES-LIST',
      'ERROR',
      'ERROR-COLUMN',
      'ERROR-OBJECT-DETAIL',
      'ERROR-ROW',
      'ERROR-STRING',
      'EVENT-PROCEDURE',
      'EVENT-PROCEDURE-CONTEXT',
      'EVENT-TYPE',
      'EXPAND',
      'EXPANDABLE',
      'EXTENT',
      'FGCOLOR',
      'FILE-CREATE-DATE',
      'FILE-CREATE-TIME',
      'FILE-MOD-DATE',
      'FILE-MOD-TIME',
      'FILE-NAME',
      'FILE-OFFSET',
      'FILE-SIZE',
      'FILE-TYPE',
      'FILL-MODE',
      'FILL-WHERE-STRING',
      'FILLED',
      'FIRST-ASYNC-REQUEST',
      'FIRST-BUFFER',
      'FIRST-CHILD',
      'FIRST-COLUMN',
      'FIRST-DATA-SOURCE',
      'FIRST-DATASET',
      'FIRST-PROCEDURE',
      'FIRST-QUERY',
      'FIRST-SERVER',
      'FIRST-SERVER-SOCKET',
      'FIRST-SOCKET',
      'FIRST-TAB-ITEM',
      'FIT-LAST-COLUMN',
      'FLAT-BUTTON',
      'FOCUSED-ROW',
      'FOCUSED-ROW-SELECTED',
      'FONT',
      'FOREGROUND',
      'FORMAT',
      'FORWARD-ONLY',
      'FRAME',
      'FRAME-COL',
      'FRAME-NAME',
      'FRAME-ROW',
      'FRAME-SPACING',
      'FRAME-X',
      'FRAME-Y',
      'FREQUENCY',
      'FULL-HEIGHT-CHARS',
      'FULL-HEIGHT-PIXELS',
      'FULL-PATHNAME',
      'FULL-WIDTH-CHARS',
      'FULL-WIDTH-PIXELS',
      'GRAPHIC-EDGE',
      'GRID-FACTOR-HORIZONTAL',
      'GRID-FACTOR-VERTICAL',
      'GRID-SNAP',
      'GRID-UNIT-HEIGHT-CHARS',
      'GRID-UNIT-HEIGHT-PIXELS',
      'GRID-UNIT-WIDTH-CHARS',
      'GRID-UNIT-WIDTH-PIXELS',
      'GRID-VISIBLE',
      'HANDLER',
      'HAS-LOBS',
      'HAS-RECORDS',
      'HEIGHT-CHARS',
      'HEIGHT-PIXELS',
      'HELP',
      'HIDDEN',
      'HORIZONTAL',
      'HTML-CHARSET',
      'HWND',
      'ICFPARAMETER',
      'ICON',
      'IGNORE-CURRENT-MODIFIED',
      'IMAGE',
      'IMAGE-DOWN',
      'IMAGE-INSENSITIVE',
      'IMAGE-UP',
      'IMMEDIATE-DISPLAY',
      'IN-HANDLE',
      'INDEX',
      'INDEX-INFORMATION',
      'INIT',
      'INITIAL',
      'INNER-CHARS',
      'INNER-LINES',
      'INPUT-VALUE',
      'INSTANTIATING-PROCEDURE',
      'INTERNAL-ENTRIES',
      'IS-OPEN',
      'IS-PARAMETER-SET',
      'ITEMS-PER-ROW',
      'KEEP-CONNECTION-OPEN',
      'KEEP-FRAME-Z-ORDER',
      'KEEP-SECURITY-CACHE',
      'KEY',
      'LABEL',
      'LABEL-BGCOLOR',
      'LABEL-DCOLOR',
      'LABEL-FGCOLOR',
      'LABEL-FONT',
      'LABELS',
      'LANGUAGES',
      'LARGE',
      'LARGE-TO-SMALL',
      'LAST-ASYNC-REQUEST',
      'LAST-CHILD',
      'LAST-PROCEDURE',
      'LAST-SERVER',
      'LAST-SERVER-SOCKET',
      'LAST-SOCKET',
      'LAST-TAB-ITEM',
      'LENGTH',
      'LINE',
      'LIST-ITEM-PAIRS',
      'LIST-ITEMS',
      'LITERAL-QUESTION',
      'LOCAL-HOST',
      'LOCAL-NAME',
      'LOCAL-PORT',
      'LOCATOR-COLUMN-NUMBER',
      'LOCATOR-LINE-NUMBER',
      'LOCATOR-PUBLIC-ID',
      'LOCATOR-SYSTEM-ID',
      'LOCATOR-TYPE',
      'LOCKED',
      'LOG-ENTRY-TYPES',
      'LOG-THRESHOLD',
      'LOGFILE-NAME',
      'LOGGING-LEVEL',
      'MANDATORY',
      'MANUAL-HIGHLIGHT',
      'MAX-BUTTON',
      'MAX-CHARS',
      'MAX-DATA-GUESS',
      'MAX-HEIGHT-CHARS',
      'MAX-HEIGHT-PIXELS',
      'MAX-VALUE',
      'MAX-WIDTH-CHARS',
      'MAX-WIDTH-PIXELS',
      'MD-VALUE',
      'MENU-BAR',
      'MENU-KEY',
      'MENU-MOUSE',
      'MESSAGE-AREA',
      'MESSAGE-AREA-FONT',
      'MIN-BUTTON',
      'MIN-COLUMN-WIDTH-CHARS',
      'MIN-COLUMN-WIDTH-PIXELS',
      'MIN-HEIGHT-CHARS',
      'MIN-HEIGHT-PIXELS',
      'MIN-SCHEMA-MARSHAL',
      'MIN-VALUE',
      'MIN-WIDTH-CHARS',
      'MIN-WIDTH-PIXELS',
      'MODIFIED',
      'MOUSE-POINTER',
      'MOVABLE',
      'MULTIPLE',
      'MULTITASKING-INTERVAL',
      'MUST-UNDERSTAND',
      'NAME',
      'NAMESPACE-PREFIX',
      'NAMESPACE-URI',
      'NEEDS-APPSERVER-PROMPT',
      'NEEDS-PROMPT',
      'NEW',
      'NEW-ROW',
      'NEXT-COLUMN',
      'NEXT-SIBLING',
      'NEXT-TAB-ITEM',
      'NO-CURRENT-VALUE',
      'NO-EMPTY-SPACE',
      'NO-FOCUS',
      'NO-SCHEMA-MARSHAL',
      'NO-VALIDATE',
      'NODE-VALUE',
      'NUM-BUFFERS',
      'NUM-BUTTONS',
      'NUM-CHILD-RELATIONS',
      'NUM-CHILDREN',
      'NUM-COLUMNS',
      'NUM-DROPPED-FILES',
      'NUM-ENTRIES',
      'NUM-FIELDS',
      'NUM-FORMATS',
      'NUM-HEADER-ENTRIES',
      'NUM-ITEMS',
      'NUM-ITERATIONS',
      'NUM-LINES',
      'NUM-LOCKED-COLUMNS',
      'NUM-LOG-FILES',
      'NUM-MESSAGES',
      'NUM-PARAMETERS',
      'NUM-RELATIONS',
      'NUM-REPLACED',
      'NUM-RESULTS',
      'NUM-SELECTED-ROWS',
      'NUM-SELECTED-WIDGETS',
      'NUM-SOURCE-BUFFERS',
      'NUM-TABS',
      'NUM-TO-RETAIN',
      'NUM-TOP-BUFFERS',
      'NUM-VISIBLE-COLUMNS',
      'NUMERIC-DECIMAL-POINT',
      'NUMERIC-FORMAT',
      'NUMERIC-SEPARATOR',
      'ON-FRAME-BORDER',
      'ORIGIN-HANDLE',
      'ORIGIN-ROWID',
      'OVERLAY',
      'OWNER',
      'OWNER-DOCUMENT',
      'PAGE-BOTTOM',
      'PAGE-TOP',
      'PARAMETER',
      'PARENT',
      'PARENT-BUFFER',
      'PARENT-RELATION',
      'PARSE-STATUS',
      'PASSWORD-FIELD',
      'PATHNAME',
      'PERSISTENT',
      'PERSISTENT-CACHE-DISABLED',
      'PERSISTENT-PROCEDURE',
      'PFCOLOR',
      'PIXELS-PER-COLUMN',
      'PIXELS-PER-ROW',
      'POPUP-MENU',
      'POPUP-ONLY',
      'POSITION',
      'PREPARE-STRING',
      'PREPARED',
      'PREV-COLUMN',
      'PREV-SIBLING',
      'PREV-TAB-ITEM',
      'PRIMARY',
      'PRINTER-CONTROL-HANDLE',
      'PRINTER-HDC',
      'PRINTER-NAME',
      'PRINTER-PORT',
      'PRIVATE-DATA',
      'PROCEDURE-NAME',
      'PROGRESS-SOURCE',
      'PROXY',
      'PROXY-PASSWORD',
      'PROXY-USERID',
      'PUBLIC-ID',
      'PUBLISHED-EVENTS',
      'QUERY',
      'QUERY-OFF-END',
      'QUIT',
      'RADIO-BUTTONS',
      'READ-ONLY',
      'RECID',
      'RECORD-LENGTH',
      'REFRESHABLE',
      'REJECTED',
      'RELATION-FIELDS',
      'RELATIONS-ACTIVE',
      'REMOTE',
      'REMOTE-HOST',
      'REMOTE-PORT',
      'REPOSITION',
      'RESIZABLE',
      'RESIZE',
      'RETAIN-SHAPE',
      'RETURN-INSERTED',
      'RETURN-VALUE',
      'RETURN-VALUE-DATA-TYPE',
      'ROW',
      'ROW-HEIGHT-CHARS',
      'ROW-HEIGHT-PIXELS',
      'ROW-MARKERS',
      'ROW-RESIZABLE',
      'ROW-STATE',
      'ROWID',
      'SAVE-WHERE-STRING',
      'SCHEMA-CHANGE',
      'SCHEMA-PATH',
      'SCREEN-LINES',
      'SCREEN-VALUE',
      'SCROLL-BARS',
      'SCROLLABLE',
      'SCROLLBAR-HORIZONTAL',
      'SCROLLBAR-VERTICAL',
      'SELECTABLE',
      'SELECTED',
      'SELECTION-END',
      'SELECTION-START',
      'SELECTION-TEXT',
      'SENSITIVE',
      'SEPARATOR-FGCOLOR',
      'SEPARATORS',
      'SERVER',
      'SERVER-CONNECTION-BOUND',
      'SERVER-CONNECTION-BOUND-REQUEST',
      'SERVER-CONNECTION-CONTEXT',
      'SERVER-CONNECTION-ID',
      'SERVER-OPERATING-MODE',
      'SHOW-IN-TASKBAR',
      'SIDE-LABEL-HANDLE',
      'SIDE-LABELS',
      'SKIP-DELETED-RECORD',
      'SMALL-ICON',
      'SMALL-TITLE',
      'SOAP-FAULT-ACTOR',
      'SOAP-FAULT-CODE',
      'SOAP-FAULT-DETAIL',
      'SOAP-FAULT-STRING',
      'SORT',
      'STARTUP-PARAMETERS',
      'STATUS-AREA',
      'STATUS-AREA-FONT',
      'STOP',
      'STOPPED',
      'STREAM',
      'STRETCH-TO-FIT',
      'STRING-VALUE',
      'SUBTYPE',
      'SUPER-PROCEDURES',
      'SUPPRESS-NAMESPACE-PROCESSING',
      'SUPPRESS-WARNINGS',
      'SYSTEM-ALERT-BOXES',
      'SYSTEM-ID',
      'TAB-POSITION',
      'TAB-STOP',
      'TABLE',
      'TABLE-CRC-LIST',
      'TABLE-HANDLE',
      'TABLE-LIST',
      'TABLE-NUMBER',
      'TEMP-DIRECTORY',
      'TEXT-SELECTED',
      'THREE-D',
      'TIC-MARKS',
      'TIME-SOURCE',
      'TITLE',
      'TITLE-BGCOLOR',
      'TITLE-DCOLOR',
      'TITLE-FGCOLOR',
      'TITLE-FONT',
      'TOGGLE-BOX',
      'TOOLTIP',
      'TOOLTIPS',
      'TOP-ONLY',
      'TRACKING-CHANGES',
      'TRANS-INIT-PROCEDURE',
      'TRANSACTION',
      'TRANSPARENT',
      'TYPE',
      'UNDO',
      'UNIQUE-ID',
      'UNIQUE-MATCH',
      'URL',
      'URL-PASSWORD',
      'URL-USERID',
      'VALIDATE-EXPRESSION',
      'VALIDATE-MESSAGE',
      'VALIDATION-ENABLED',
      'VALUE',
      'VIEW-FIRST-COLUMN-ON-REOPEN',
      'VIRTUAL-HEIGHT',
      'VIRTUAL-HEIGHT-CHARS',
      'VIRTUAL-HEIGHT-PIXELS',
      'VIRTUAL-WIDTH',
      'VIRTUAL-WIDTH-CHARS',
      'VIRTUAL-WIDTH-PIXELS',
      'VISIBLE',
      'WARNING',
      'WHERE-STRING',
      'WIDGET-ENTER',
      'WIDGET-LEAVE',
      'WIDTH-CHARS',
      'WIDTH-PIXELS',
      'WINDOW',
      'WINDOW-STATE',
      'WINDOW-SYSTEM',
      'WORD-WRAP',
      'WORK-AREA-HEIGHT-PIXELS',
      'WORK-AREA-WIDTH-PIXELS',
      'WORK-AREA-X',
      'WORK-AREA-Y',
      'X',
      'XML-SCHEMA-PATH',
      'XML-SUPPRESS-NAMESPACE-PROCESSING',
      'Y',
      'YEAR-OFFSET',
   );
   $self->listAdd('envvariables',
      'APPPROGRAM',
      'APPPROGRAM',
      'APPURL',
      'AUTH_TYPE',
      'CLASSPATH',
      'CONTENT_LENGTH',
      'CONTENT_TYPE',
      'DLC',
      'EVTLEVEL',
      'GATEWAY_INTERFACE',
      'HOSTURL',
      'HTTPS',
      'HTTP_ACCEPT',
      'HTTP_COOKIE',
      'HTTP_REFERER',
      'HTTP_REFERER',
      'HTTP_REFERER',
      'HTTP_USER_AGENT',
      'JDKCP',
      'JDKHOME',
      'JFCCP',
      'JFHOME',
      'JIT',
      'JRECP',
      'JREHOME',
      'JVMEXE',
      'OUTPUT-CONTENT-TYPE',
      'PATH',
      'PATH_INFO',
      'PATH_TRANSLATED',
      'PROCFG',
      'PROCONV',
      'PROEXE',
      'PROGRESSCP',
      'PROLOAD',
      'PROMSGS',
      'PROPATH',
      'PROSRV',
      'PROSTARTUP',
      'PROTERMCAP',
      'QUERY_STRING',
      'REMOTE_ADDR',
      'REMOTE_HOST',
      'REMOTE_IDENT',
      'REMOTE_USER',
      'REQUEST_METHOD',
      'SCRIPT_NAME',
      'SELFURL',
      'SERVER_NAME',
      'SERVER_PORT',
      'SERVER_PROTOCOL',
      'SERVER_SOFTWARE',
      'TERM',
      'TERMINAL',
      'WEB_SRC_PATH',
   );
   $self->listAdd('functions',
      'ABSOLUTE',
      'ACCUM',
      'ADD-INTERVAL',
      'ALIAS',
      'AMBIGUOUS',
      'ASC',
      'AVAILABLE',
      'BASE64-DECODE',
      'BASE64-ENCODE',
      'CAN-DO',
      'CAN-FIND',
      'CAN-QUERY',
      'CAN-SET',
      'CAPS',
      'CHR',
      'CODEPAGE-CONVERT',
      'COMPARE',
      'CONNECTED',
      'COUNT-OF',
      'CURRENT-CHANGED',
      'CURRENT-LANGUAGE',
      'CURRENT-RESULT-ROW',
      'CURRENT-VALUE',
      'DATA-SOURCE-MODIFIED',
      'DATASERVERS',
      'DATE',
      'DATETIME',
      'DATETIME-TZ',
      'DAY',
      'DBCODEPAGE',
      'DBCOLLATION',
      'DBNAME',
      'DBPARAM',
      'DBRESTRICTIONS',
      'DBTASKID',
      'DBTYPE',
      'DBVERSION',
      'DECIMAL',
      'DECRYPT',
      'DYNAMIC-CURRENT-VALUE',
      'DYNAMIC-FUNCTION',
      'DYNAMIC-NEXT-VALUE',
      'ENCODE',
      'ENCRYPT',
      'ENTERED',
      'ENTRY',
      'ERROR',
      'ETIME',
      'EXP',
      'EXTENT',
      'FILL',
      'FIRST',
      'FIRST-OF',
      'FIX-CODEPAGE',
      'FRAME-COL',
      'FRAME-DB',
      'FRAME-DOWN',
      'FRAME-FIELD',
      'FRAME-FILE',
      'FRAME-INDEX',
      'FRAME-LINE',
      'FRAME-NAME',
      'FRAME-ROW',
      'FRAME-VALUE',
      'GATEWAYS',
      'GENERATE-PBE-KEY',
      'GENERATE-PBE-SALT',
      'GENERATE-RANDOM-KEY',
      'GET-BITS',
      'GET-BYTE',
      'GET-BYTE-ORDER',
      'GET-BYTES',
      'GET-CODEPAGE',
      'GET-CODEPAGES',
      'GET-COLLATION',
      'GET-COLLATIONS',
      'GET-DOUBLE',
      'GET-FLOAT',
      'GET-LONG',
      'GET-POINTER-VALUE',
      'GET-SHORT',
      'GET-SIZE',
      'GET-STRING',
      'GET-UNSIGNED-SHORT',
      'GO-PENDING',
      'INDEX',
      'INTEGER',
      'INTERVAL',
      'IS-ATTR-SPACE',
      'IS-CODEPAGE-FIXED',
      'IS-COLUMN-CODEPAGE',
      'IS-LEAD-BYTE',
      'ISO-DATE',
      'KBLABEL',
      'KEYCODE',
      'KEYFUNCTION',
      'KEYLABEL',
      'KEYWORD',
      'KEYWORD-ALL',
      'LAST',
      'LAST-OF',
      'LASTKEY',
      'LC',
      'LDBNAME',
      'LEFT-TRIM',
      'LENGTH',
      'LIBRARY',
      'LINE-COUNTER',
      'LIST-EVENTS',
      'LIST-QUERY-ATTRS',
      'LIST-SET-ATTRS',
      'LIST-WIDGETS',
      'LOCKED',
      'LOG',
      'LOGICAL',
      'LOOKUP',
      'MAXIMUM',
      'MD5-DIGEST',
      'MEMBER',
      'MESSAGE-LINES',
      'MINIMUM',
      'MONTH',
      'MTIME',
      'NEW',
      'NEXT-VALUE',
      'NORMALIZE',
      'NOT ENTERED',
      'NOW',
      'NUM-ALIASES',
      'NUM-DBS',
      'NUM-ENTRIES',
      'NUM-RESULTS',
      'OPSYS',
      'OS-DRIVES',
      'OS-ERROR',
      'OS-GETENV',
      'PAGE-NUMBER',
      'PAGE-SIZE',
      'PDBNAME',
      'PROC-HANDLE',
      'PROC-STATUS',
      'PROGRAM-NAME',
      'PROGRESS',
      'PROMSGS',
      'PROPATH',
      'PROVERSION',
      'QUERY-OFF-END',
      'QUOTER',
      'R-INDEX',
      'RANDOM',
      'RAW',
      'RECID',
      'RECORD-LENGTH',
      'REJECTED',
      'REPLACE',
      'RETRY',
      'RETURN-VALUE',
      'RGB-VALUE',
      'RIGHT-TRIM',
      'ROUND',
      'ROW-STATE',
      'ROWID',
      'SCREEN-LINES',
      'SDBNAME',
      'SEARCH',
      'SEEK',
      'SETUSERID',
      'SHA1-DIGEST',
      'SQRT',
      'SSL-SERVER-NAME',
      'STRING',
      'SUBSTITUTE',
      'SUBSTRING',
      'SUPER',
      'TERMINAL',
      'TIME',
      'TIMEZONE',
      'TO-ROWID',
      'TODAY',
      'TRANSACTION',
      'TRIM',
      'TRUNCATE',
      'USERID',
      'VALID-EVENT',
      'VALID-HANDLE',
      'WEEKDAY',
      'WIDGET-HANDLE',
      'YEAR',
   );
   $self->listAdd('handles',
      'ACTIVE-WINDOW',
      'BUFFER',
      'BUFFER-FIELD',
      'CALL',
      'CLIPBOARD',
      'CODEBASE-LOCATOR',
      'COLOR-TABLE',
      'COM-SELF',
      'COMPILER',
      'CURRENT-WINDOW',
      'DATA-RELATION',
      'DATE-SOURCE',
      'DEBUGGER',
      'DEFAULT-WINDOW',
      'ERROR-STATUS',
      'FILE-INFO',
      'FOCUS',
      'FONT-TABLE',
      'LAST-EVENT',
      'LOG-MANAGER',
      'PRODATASET',
      'QUERY',
      'RCODE-INFO',
      'SAX-ATTRIBUTES',
      'SAX-READER',
      'SELF',
      'SERVER SOCKET',
      'SESSION',
      'SOAP-FAULT',
      'SOAP-FAULT-DETAIL',
      'SOAP-HEADER',
      'SOAP-HEADER-ENTRYREF',
      'SOCKET',
      'SOURCE-PROCEDURE',
      'TARGET-PROCEDURE',
      'TEMP-TABLE',
      'THIS-PROCEDURE',
      'TRANSACTION',
      'WEB-CONTEXT',
      'X-DOCUMENT',
      'X-NODEREF',
   );
   $self->listAdd('methods',
      'ACCEPT-CHANGES',
      'ACCEPT-ROW-CHANGES',
      'ADD-BUFFER',
      'ADD-CALC-COLUMN',
      'ADD-COLUMNS-FROM',
      'ADD-EVENTS-PROCEDURE',
      'ADD-FIELDS-FROM',
      'ADD-FIRST',
      'ADD-HEADER-ENTRY',
      'ADD-INDEX-FIELD',
      'ADD-LAST',
      'ADD-LIKE-COLUMN',
      'ADD-LIKE-FIELD',
      'ADD-LIKE-INDEX',
      'ADD-NEW-FIELD',
      'ADD-NEW-INDEX',
      'ADD-RELATION',
      'ADD-SOURCE-BUFFER',
      'ADD-SUPER-PROCEDURE',
      'APPEND-CHILD',
      'APPLY-CALLBACK',
      'ATTACH-DATA-SOURCE',
      'BUFFER-COMPARE',
      'BUFFER-COPY',
      'BUFFER-CREATE',
      'BUFFER-DELETE',
      'BUFFER-FIELD',
      'BUFFER-RELEASE',
      'BUFFER-VALIDATE',
      'CANCEL-BREAK',
      'CANCEL-REQUESTS',
      'CLEAR',
      'CLEAR-SELECTION',
      'CLONE-NODE',
      'CONNECT',
      'CONNECTED',
      'CONVERT-TO-OFFSET',
      'CREATE-LIKE',
      'CREATE-NODE',
      'CREATE-NODE-NAMESPACE',
      'CREATE-RESULT-LIST-ENTRY',
      'DEBUG',
      'DELETE',
      'DELETE-CHAR',
      'DELETE-CURRENT-ROW',
      'DELETE-HEADER-ENTRY',
      'DELETE-LINE',
      'DELETE-NODE',
      'DELETE-RESULT-LIST-ENTRY',
      'DELETE-SELECTED-ROW',
      'DELETE-SELECTED-ROWS',
      'DESELECT-FOCUSED-ROW',
      'DESELECT-ROWS',
      'DESELECT-SELECTED-ROW',
      'DETACH-DATA-SOURCE',
      'DISABLE',
      'DISABLE-CONNECTIONS',
      'DISABLE-DUMP-TRIGGERS',
      'DISABLE-LOAD-TRIGGERS',
      'DISCONNECT',
      'DISPLAY-MESSAGE',
      'DUMP-LOGGING-NOW',
      'EDIT-CLEAR',
      'EDIT-COPY',
      'EDIT-CUT',
      'EDIT-PASTE',
      'EDIT-UNDO',
      'EMPTY-DATASET',
      'EMPTY-TEMP-TABLE',
      'ENABLE',
      'ENABLE-CONNECTIONS',
      'ENABLE-EVENTS',
      'END-FILE-DROP',
      'ENTRY',
      'EXPORT',
      'FETCH-SELECTED-ROW',
      'FILL',
      'FIND-BY-ROWID',
      'FIND-CURRENT',
      'FIND-FIRST',
      'FIND-LAST',
      'FIND-UNIQUE',
      'GET-ATTRIBUTE',
      'GET-ATTRIBUTE-NODE',
      'GET-BLUE-VALUE',
      'GET-BROWSE-COLUMN',
      'GET-BUFFER-HANDLE',
      'GET-BYTES-AVAILABLE',
      'GET-CHANGES',
      'GET-CHILD',
      'GET-CHILD-RELATION',
      'GET-CURRENT',
      'GET-DATASET-BUFFER',
      'GET-DOCUMENT-ELEMENT',
      'GET-DROPPED-FILE',
      'GET-DYNAMIC',
      'GET-FIRST',
      'GET-GREEN-VALUE',
      'GET-HEADER-ENTRY',
      'GET-INDEX-BY-NAMESPACE-NAME',
      'GET-INDEX-BY-QNAME',
      'GET-ITERATION',
      'GET-LAST',
      'GET-LOCALNAME-BY-INDEX',
      'GET-MESSAGE',
      'GET-NEXT',
      'GET-NODE',
      'GET-NUMBER',
      'GET-PARENT',
      'GET-PREV',
      'GET-PRINTERS',
      'GET-QNAME-BY-INDEX',
      'GET-RED-VALUE',
      'GET-RELATION',
      'GET-REPOSITIONED-ROW',
      'GET-RGB-VALUE',
      'GET-SELECTED-WIDGET',
      'GET-SERIALIZED',
      'GET-SIGNATURE',
      'GET-SOCKET-OPTION',
      'GET-SOURCE-BUFFER',
      'GET-TAB-ITEM',
      'GET-TEXT-HEIGHT-CHARS',
      'GET-TEXT-HEIGHT-PIXELS',
      'GET-TEXT-WIDTH-CHARS',
      'GET-TEXT-WIDTH-PIXELS',
      'GET-TOP-BUFFER',
      'GET-TYPE-BY-INDEX',
      'GET-TYPE-BY-NAMESPACE-NAME',
      'GET-TYPE-BY-QNAME',
      'GET-URI-BY-INDEX',
      'GET-VALUE-BY-INDEX',
      'GET-VALUE-BY-NAMESPACE-NAME',
      'GET-VALUE-BY-QNAME',
      'GET-WAIT-STATE',
      'IMPORT-NODE',
      'INDEX-INFORMATION',
      'INITIALIZE-DOCUMENT-TYPE',
      'INITIATE',
      'INSERT',
      'INSERT-BACKTAB',
      'INSERT-BEFORE',
      'INSERT-FILE',
      'INSERT-ROW',
      'INSERT-STRING',
      'INSERT-TAB',
      'INVOKE',
      'IS-ROW-SELECTED',
      'IS-SELECTED',
      'LOAD',
      'LOAD-ICON',
      'LOAD-IMAGE',
      'LOAD-IMAGE-DOWN',
      'LOAD-IMAGE-INSENSITIVE',
      'LOAD-IMAGE-UP',
      'LOAD-MOUSE-POINTER',
      'LOAD-SMALL-ICON',
      'LONGCHAR-TO-NODE-VALUE',
      'LOOKUP',
      'LoadControls',
      'MAX-HEIGHT',
      'MAX-WIDTH',
      'MEMPTR-TO-NODE-VALUE',
      'MERGE-CHANGES',
      'MERGE-ROW-CHANGES',
      'MOVE-AFTER-TAB-ITEM',
      'MOVE-BEFORE-TAB-ITEM',
      'MOVE-COLUMN',
      'MOVE-TO-BOTTOM',
      'MOVE-TO-EOF',
      'MOVE-TO-TOP',
      'NODE-VALUE-TO-LONGCHAR',
      'NODE-VALUE-TO-MEMPTR',
      'NORMALIZE',
      'QUERY-CLOSE',
      'QUERY-OPEN',
      'QUERY-PREPARE',
      'RAW-TRANSFER',
      'READ',
      'READ-FILE',
      'REFRESH',
      'REJECT-CHANGES',
      'REJECT-ROW-CHANGES',
      'REMOVE-ATTRIBUTE',
      'REMOVE-CHILD',
      'REMOVE-EVENTS-PROCEDURE',
      'REMOVE-SUPER-PROCEDURE',
      'REPLACE',
      'REPLACE-CHILD',
      'REPLACE-SELECTION-TEXT',
      'REPOSITION-BACKWARD',
      'REPOSITION-FORWARD',
      'REPOSITION-TO-ROW',
      'REPOSITION-TO-ROWID',
      'SAVE',
      'SAVE-FILE',
      'SAVE-ROW-CHANGES',
      'SAX-PARSE',
      'SAX-PARSE-FIRST',
      'SAX-PARSE-NEXT',
      'SCROLL-TO-CURRENT-ROW',
      'SCROLL-TO-ITEM',
      'SCROLL-TO-SELECTED-ROW',
      'SEARCH',
      'SELECT-ALL',
      'SELECT-FOCUSED-ROW',
      'SELECT-NEXT-ROW',
      'SELECT-PREV-ROW',
      'SELECT-ROW',
      'SET-ACTOR',
      'SET-ATTRIBUTE',
      'SET-ATTRIBUTE-NODE',
      'SET-BLUE-VALUE',
      'SET-BREAK',
      'SET-BUFFERS',
      'SET-CALLBACK-PROCEDURE',
      'SET-COMMIT',
      'SET-CONNECT-PROCEDURE',
      'SET-DYNAMIC',
      'SET-GREEN-VALUE',
      'SET-INPUT-SOURCE',
      'SET-MUST-UNDERSTAND',
      'SET-NODE',
      'SET-NUMERIC-FORMAT',
      'SET-PARAMETER',
      'SET-READ-RESPONSE-PROCEDURE',
      'SET-RED-VALUE',
      'SET-REPOSITIONED-ROW',
      'SET-RGB-VALUE',
      'SET-ROLLBACK',
      'SET-SELECTION',
      'SET-SERIALIZED',
      'SET-SOCKET-OPTION',
      'SET-WAIT-STATE',
      'STOP-PARSING',
      'SYNCHRONIZE',
      'TEMP-TABLE-PREPARE',
      'VALIDATE',
      'WRITE',
   );
   $self->listAdd('mytypes',
      'BLOB',
      'BUFFER',
      'CHAR',
      'CHARACTER',
      'CLOB',
      'COM-HANDLE',
      'DATE',
      'DATETIME',
      'DATETIME-TZ',
      'DECI',
      'DECIMAL',
      'HANDLE',
      'INTE',
      'INTEGER',
      'LOGI',
      'LOGICAL',
      'LONG',
      'LONGCHAR',
      'LONGCHAR',
      'MEMPTR',
      'RAW',
      'RECID',
      'ROWID',
      'SHORT',
      'STREAM',
      'TEMP-TABLE',
      'WIDGET-HANDLE',
   );
   $self->listAdd('operators',
      '*',
      '+',
      '-',
      '/',
      '<',
      '<=',
      '<>',
      '=',
      '>',
      '>=',
      'AND',
      'BEGINS',
      'EQ',
      'FALSE',
      'GE',
      'GT',
      'LE',
      'LT',
      'MATCHES',
      'MODULO',
      'NE',
      'NO',
      'NOT',
      'OR',
      'TRUE',
      'YES',
   );
   $self->listAdd('phrases',
      'ALERT-BOX',
      'APPEND',
      'AS',
      'AT',
      'BEFORE-HIDE',
      'BINARY',
      'BREAK',
      'BY',
      'COLON-ALIGNED',
      'COLOR',
      'COMBO-BOX',
      'CONVERT',
      'DEFINED',
      'EACH',
      'EDITING',
      'EDITOR',
      'ENDKEY',
      'ERROR',
      'EXCLUSIVE-LOCK',
      'FIRST',
      'FORMAT',
      'FORWARD',
      'FRAME',
      'GLOBAL',
      'GROUP',
      'IMAGE',
      'IN',
      'KEEP-TAB-ORDER',
      'LAST',
      'NO-BOX',
      'NO-CONVERT',
      'NO-ECHO',
      'NO-ERROR',
      'NO-FILL',
      'NO-LABEL',
      'NO-LABELS',
      'NO-LOCK',
      'NO-MAP',
      'NO-MESSAGE',
      'NO-PAUSE',
      'NO-UNDERLINE',
      'NO-UNDO',
      'OF',
      'OUT',
      'PRESELECT',
      'PREV',
      'PRIVATE',
      'QUERY-TUNING',
      'QUIT',
      'RADIO-SET',
      'RECORD',
      'SELECTION-LIST',
      'SHARE-LOCK',
      'SHARED',
      'SIZE',
      'SKIP',
      'SLIDER',
      'STOP',
      'TARGET',
      'TRIGGER',
      'UNBUFFERED',
      'UNFORMATTED',
      'UNIQUE',
      'VIEW-AS',
      'WHERE',
      'WIDGET',
      'WITH',
   );
   $self->listAdd('preprocvar',
      'ANALYZE-RESUME',
      'ANALYZE-SUSPEND',
      'BATCH-MODE',
      'ENDIF',
      'FILE-NAME',
      'GLOBAL-DEFINE',
      'LINE-NUMBER',
      'OPSYS',
      'OUT',
      'SCOPED-DEFINE',
      'SEQUENCE',
      'UNDEFINE',
      'WEBSTREAM',
      'WINDOW-SYSTEM',
   );
   $self->listAdd('properties',
      'CONTROL-NAME',
      'CONTROLS',
      'HEIGHT',
      'HONORPROKEYS',
      'HONORRETURNKEY',
      'LEFT',
      'NAME',
      'TAG',
      'TOP',
      'WIDTH',
   );
   $self->listAdd('statements',
      'ACCUMULATE',
      'ADVISE',
      'ALIAS',
      'ALIAS',
      'APPLY',
      'ASSIGN',
      'AUTOMATIC',
      'BELL',
      'BROWSE',
      'BROWSE',
      'BUFFER',
      'BUFFER',
      'BUFFER-COMPARE',
      'BUFFER-COPY',
      'BUTTON',
      'CACHE',
      'CALL',
      'CHOOSE',
      'CLEAR',
      'CLEAR',
      'CLOSE',
      'CLOSE',
      'COLOR',
      'COLOR',
      'COMPILE',
      'CONNECT',
      'COPY-LOB',
      'CREATE',
      'CURRENT-LANGUAGE',
      'CURRENT-VALUE',
      'CURSOR',
      'DATA-SOURCE',
      'DATA-SOURCE',
      'DATABASE',
      'DATASET',
      'DATASET',
      'DDE',
      'DEF',
      'DEFINE',
      'DELETE',
      'DICTIONARY',
      'DISABLE',
      'DISCONNECT',
      'DISPLAY',
      'DOS',
      'DOWN',
      'DYNAMIC-CURRENT-VALUE',
      'ELSE',
      'EMPTY',
      'ENABLE',
      'ENTRY',
      'EVENTS',
      'EXECUTE',
      'EXPORT',
      'EXTERNAL',
      'FIND',
      'FONT',
      'FORM',
      'FRAME',
      'FRAME-VALUE',
      'FROM',
      'GET',
      'GET',
      'GET-DIR',
      'GET-FILE',
      'GET-KEY-VALUE',
      'HIDE',
      'IF',
      'IMAGE',
      'IMPORT',
      'INITIATE',
      'INPUT',
      'INPUT-OUTPUT',
      'INSERT',
      'LEAVE',
      'LENGTH',
      'LOAD',
      'LOAD-PICTURE',
      'MENU',
      'MESSAGE',
      'NEXT',
      'NEXT-PROMPT',
      'OBJECT',
      'OBJECT',
      'OPEN',
      'OS-APPEND',
      'OS-COMMAND',
      'OS-COPY',
      'OS-CREATE-DIR',
      'OS-DELETE',
      'OS-RENAME',
      'OTHERWISE',
      'OUTPUT',
      'OVERLAY',
      'PAGE',
      'PARAM',
      'PARAMETER',
      'PAUSE',
      'PRINTER-SETUP',
      'PROCESS',
      'PROMPT-FOR',
      'PROMSGS',
      'PROPATH',
      'PUBLISH',
      'PUT',
      'PUT-BITS',
      'PUT-BYTE',
      'PUT-BYTES',
      'PUT-DOUBLE',
      'PUT-FLOAT',
      'PUT-KEY-VALUE',
      'PUT-LONG',
      'PUT-SHORT',
      'PUT-STRING',
      'PUT-UNSIGNED-SHORT',
      'QUERY',
      'QUERY',
      'QUERY',
      'QUERY',
      'QUIT',
      'RAW',
      'RAW-TRANSFER',
      'READKEY',
      'RECTANGLE',
      'RELEASE',
      'REPOSITION',
      'REQUEST',
      'RETURN',
      'RETURNS',
      'RUN',
      'SAVE',
      'SAX-READER',
      'SCREEN',
      'SCROLL',
      'SEEK',
      'SEND',
      'SERVER',
      'SERVER-SOCKET',
      'SET',
      'SET-BYTE-ORDER',
      'SET-POINTER-VALUE',
      'SET-SIZE',
      'SHOW-STATS',
      'SOAP-HEADER',
      'SOAP-HEADER-ENTRYREF',
      'SOCKET',
      'STATUS',
      'STOP',
      'STORED-PROCEDURE',
      'STORED-PROCEDURE',
      'STREAM',
      'SUB-MENU',
      'SUBSCRIBE',
      'SUBSTRING',
      'SUPER',
      'SYSTEM-DIALOG',
      'SYSTEM-HELP',
      'TEMP-TABLE',
      'TEMP-TABLE',
      'TEMP-TABLE',
      'TERMINAL',
      'TERMINATE',
      'THEN',
      'THROUGH',
      'THROUGH',
      'TO',
      'TRANSACTION-MODE',
      'TRIGGER',
      'TRIGGERS',
      'UNDERLINE',
      'UNDO',
      'UNIX',
      'UNLOAD',
      'UNSUBSCRIBE',
      'UP',
      'UPDATE',
      'USE',
      'VALIDATE',
      'VAR',
      'VARIABLE',
      'VARIABLE',
      'VIEW',
      'WAIT-FOR',
      'WHEN',
      'WIDGET',
      'WIDGET',
      'WIDGET-POOL',
      'WIDGET-POOL',
      'WORK-TABLE',
      'WORKFILE',
      'X-DOCUMENT',
      'X-NODEREF',
   );
   $self->listAdd('widgets',
      'BROWSE',
      'BUTTON',
      'COMBO-BOX',
      'CONTROL-FRAME',
      'DIALOG-BOX',
      'EDITOR',
      'FIELD-GROUP',
      'FILL-IN',
      'FRAME',
      'IMAGE',
      'LITERAL',
      'MENU',
      'MENU-ITEM',
      'RADIO-SET',
      'RECTANGLE',
      'SELECTION-LIST',
      'SLIDER',
      'SUB-MENU',
      'TEXT',
      'TOGGLE-BOX',
      'WINDOW',
   );
   $self->contextdata({
      'Identifier' => {
         callback => \&parseIdentifier,
         attribute => 'Identifier',
         lineending => '#pop',
      },
      'MultiLineComment' => {
         callback => \&parseMultiLineComment,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|:|\\!|\\+|,|<|=|>|\\%|\\&|\\*|\\/|;|\\?|\\[|\\]|\\^|\\{|\\||\\}|\\~|\\\\|-');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'progress';
}

sub parseIdentifier {
   my ($self, $text) = @_;
   # attribute => 'Identifier'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'Identifier')) {
      return 1
   }
   return 0;
};

sub parseMultiLineComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # context => '#pop'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # endRegion => 'Comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   # context => '##Alerts'
   # type => 'IncludeRules'
   if ($self->includePlugin('Alerts', $text)) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'envvariables'
   # attribute => 'Preprocvar'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'envvariables', 0, undef, 0, '#stay', 'Preprocvar')) {
      return 1
   }
   # String => 'mytypes'
   # attribute => 'Data_Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'mytypes', 0, undef, 0, '#stay', 'Data_Type')) {
      return 1
   }
   # String => 'operators'
   # attribute => 'Operators'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'operators', 0, undef, 0, '#stay', 'Operators')) {
      return 1
   }
   # String => 'preprocvar'
   # attribute => 'Preprocvar'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'preprocvar', 0, undef, 0, '#stay', 'Preprocvar')) {
      return 1
   }
   # String => 'phrases'
   # attribute => 'Phrases'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'phrases', 0, undef, 0, '#stay', 'Phrases')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'statements'
   # attribute => 'Statements'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'statements', 0, undef, 0, '#stay', 'Statements')) {
      return 1
   }
   # String => 'widgets'
   # attribute => 'Widgets'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'widgets', 0, undef, 0, '#stay', 'Widgets')) {
      return 1
   }
   # String => 'handles'
   # attribute => 'Handles'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'handles', 0, undef, 0, '#stay', 'Handles')) {
      return 1
   }
   # String => 'properties'
   # attribute => 'Properties'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'properties', 0, undef, 0, '#stay', 'Properties')) {
      return 1
   }
   # String => 'attributes'
   # attribute => 'Attributes'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'attributes', 0, undef, 0, '#stay', 'Attributes')) {
      return 1
   }
   # String => 'methods'
   # attribute => 'Methods'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'methods', 0, undef, 0, '#stay', 'Methods')) {
      return 1
   }
   # attribute => 'Integer'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Integer')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'MultiLineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'MultiLineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '"'
   # context => 'Identifier'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Identifier', 'Comment')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#stay', 'String')) {
      return 1
   }
   # String => '{}[]()~:'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, '{}[]()~:', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => 'PROCEDURE'
   # attribute => 'Region Marker'
   # beginRegion => 'P1'
   # context => '#stay'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'PROCEDURE', 1, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => 'END PROCEDURE'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'P1'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'END PROCEDURE', 1, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => 'FUNCTION'
   # attribute => 'Region Marker'
   # beginRegion => 'F1'
   # context => '#stay'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'FUNCTION', 1, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => 'END FUNCTION'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'F1'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'END FUNCTION', 1, 0, 0, undef, 1, '#stay', 'Region Marker')) {
      return 1
   }
   # String => 'DO:'
   # attribute => 'Function'
   # beginRegion => 'L1'
   # context => '#stay'
   # firstNonSpace => 'FALSE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'DO:', 1, 0, 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'REPEAT'
   # attribute => 'Function'
   # beginRegion => 'L1'
   # context => '#stay'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'REPEAT', 1, 0, 0, undef, 1, '#stay', 'Function')) {
      return 1
   }
   # String => 'FOR'
   # attribute => 'Function'
   # beginRegion => 'L1'
   # context => '#stay'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'FOR', 1, 0, 0, undef, 1, '#stay', 'Function')) {
      return 1
   }
   # String => 'CASE'
   # attribute => 'Function'
   # beginRegion => 'L1'
   # context => '#stay'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'CASE', 1, 0, 0, undef, 1, '#stay', 'Function')) {
      return 1
   }
   # String => 'END'
   # attribute => 'Function'
   # context => '#stay'
   # endRegion => 'L1'
   # firstNonSpace => 'TRUE'
   # insensitive => 'TRUE'
   # type => 'StringDetect'
   if ($self->testStringDetect($text, 'END', 1, 0, 0, undef, 1, '#stay', 'Function')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # attribute => 'String'
   # context => '#pop'
   # type => 'LineContinue'
   if ($self->testLineContinue($text, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Progress - a Plugin for progress syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Progress;
 my $sh = new Syntax::Highlight::Engine::Kate::Progress([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Progress is a  plugin module that provides syntax highlighting
for progress to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author