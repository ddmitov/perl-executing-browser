# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sql.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.11
#kate version 2.4
#kate author Yury Lebedev (yurylebedev@mail.ru)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::SQL;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'Comment' => 'Comment',
      'Data Type' => 'DataType',
      'Decimal' => 'DecVal',
      'External Variable' => 'Char',
      'Float' => 'Float',
      'Function' => 'Function',
      'Identifier' => 'Others',
      'Keyword' => 'Keyword',
      'Normal Text' => 'Normal',
      'Operator' => 'Normal',
      'Preprocessor' => 'Others',
      'String' => 'String',
      'String Char' => 'Char',
      'Symbol' => 'Char',
   });
   $self->listAdd('functions',
      'ABS',
      'ACOS',
      'ADD_MONTHS',
      'ASCII',
      'ASCIISTR',
      'ASIN',
      'ATAN',
      'ATAN2',
      'AVG',
      'BFILENAME',
      'BIN_TO_NUM',
      'BITAND',
      'CARDINALITY',
      'CAST',
      'CEIL',
      'CHARTOROWID',
      'CHR',
      'COALESCE',
      'COLLECT',
      'COMPOSE',
      'CONCAT',
      'CONVERT',
      'CORR',
      'CORR_K',
      'CORR_S',
      'COS',
      'COSH',
      'COUNT',
      'COVAR_POP',
      'COVAR_SAMP',
      'CUME_DIST',
      'CURRENT_DATE',
      'CURRENT_TIMESTAMP',
      'CV',
      'DBTIMEZONE',
      'DECODE',
      'DECOMPOSE',
      'DENSE_RANK',
      'DEPTH',
      'DEREF',
      'DUMP',
      'EMPTY_BLOB',
      'EMPTY_CLOB',
      'EXISTSNODE',
      'EXP',
      'EXTRACT',
      'EXTRACTVALUE',
      'FIRST',
      'FIRST_VALUE',
      'FLOOR',
      'FROM_TZ',
      'GREATEST',
      'GROUPING',
      'GROUPING_ID',
      'GROUP_ID',
      'HEXTORAW',
      'INITCAP',
      'INSTR',
      'INSTRB',
      'LAG',
      'LAST',
      'LAST_DAY',
      'LAST_VALUE',
      'LEAD',
      'LEAST',
      'LENGTH',
      'LENGTHB',
      'LN',
      'LNNVL',
      'LOCALTIMESTAMP',
      'LOG',
      'LOWER',
      'LPAD',
      'LTRIM',
      'MAKE_REF',
      'MAX',
      'MEDIAN',
      'MIN',
      'MOD',
      'MONTHS_BETWEEN',
      'NANVL',
      'NCHR',
      'NEW_TIME',
      'NEXT_DAY',
      'NLSSORT',
      'NLS_CHARSET_DECL_LEN',
      'NLS_CHARSET_ID',
      'NLS_CHARSET_NAME',
      'NLS_INITCAP',
      'NLS_LOWER',
      'NLS_UPPER',
      'NTILE',
      'NULLIF',
      'NUMTODSINTERVAL',
      'NUMTOYMINTERVAL',
      'NVL',
      'NVL2',
      'ORA_HASH',
      'ORA_ROWSCN',
      'PERCENTILE_CONT',
      'PERCENTILE_DISC',
      'PERCENT_RANK',
      'POWER',
      'POWERMULTISET',
      'POWERMULTISET_BY_CARDINALITY',
      'PRESENTNNV',
      'PRESENTV',
      'RANK',
      'RATIO_TO_REPORT',
      'RAWTOHEX',
      'RAWTONHEX',
      'REF',
      'REFTOHEX',
      'REGEXP_INSTR',
      'REGEXP_LIKE',
      'REGEXP_REPLACE',
      'REGEXP_SUBSTR',
      'REGR_AVGX',
      'REGR_AVGY',
      'REGR_COUNT',
      'REGR_INTERCEPT',
      'REGR_R2',
      'REGR_SLOPE',
      'REGR_SXX',
      'REGR_SXY',
      'REGR_SYY',
      'REMAINDER',
      'ROUND',
      'ROWIDTOCHAR',
      'ROWIDTONCHAR',
      'ROW_NUMBER',
      'RPAD',
      'RTRIM',
      'SCN_TO_TIMESTAMP',
      'SESSIONTIMEZONE',
      'SIGN',
      'SIN',
      'SINH',
      'SOUNDEX',
      'SQRT',
      'STATS_BINOMIAL_TEST',
      'STATS_CROSSTAB',
      'STATS_F_TEST',
      'STATS_KS_TEST',
      'STATS_MODE',
      'STATS_MW_TEST',
      'STATS_ONE_WAY_ANOVA',
      'STATS_T_TEST_INDEP',
      'STATS_T_TEST_INDEPU',
      'STATS_T_TEST_ONE',
      'STATS_T_TEST_PAIRED',
      'STATS_WSR_TEST',
      'STDDEV',
      'STDDEV_POP',
      'STDDEV_SAMP',
      'SUBSTR',
      'SUBSTRB',
      'SUM',
      'SYSDATE',
      'SYSTIMESTAMP',
      'SYS_CONNECT_BY_PATH',
      'SYS_CONTEXT',
      'SYS_DBURIGEN',
      'SYS_EXTRACT_UTC',
      'SYS_GUID',
      'SYS_TYPEID',
      'SYS_XMLAGG',
      'SYS_XMLGEN',
      'TAN',
      'TANH',
      'TIMESTAMP_TO_SCN',
      'TO_BINARY_DOUBLE',
      'TO_BINARY_FLOAT',
      'TO_CHAR',
      'TO_CLOB',
      'TO_DATE',
      'TO_DSINTERVAL',
      'TO_LOB',
      'TO_MULTI_BYTE',
      'TO_NCHAR',
      'TO_NCLOB',
      'TO_NUMBER',
      'TO_SINGLE_BYTE',
      'TO_TIMESTAMP',
      'TO_TIMESTAMP_TZ',
      'TO_YMINTERVAL',
      'TRANSLATE',
      'TREAT',
      'TRIM',
      'TRUNC',
      'TZ_OFFSET',
      'UID',
      'UNISTR',
      'UPDATEXML',
      'UPPER',
      'USER',
      'USERENV',
      'VALUE',
      'VARIANCE',
      'VAR_POP',
      'VAR_SAMP',
      'VSIZE',
      'WIDTH_BUCKET',
      'XMLAGG',
      'XMLCOLATTVAL',
      'XMLCONCAT',
      'XMLELEMENT',
      'XMLFOREST',
      'XMLSEQUENCE',
      'XMLTRANSFORM',
   );
   $self->listAdd('keywords',
      'ACCESS',
      'ACCOUNT',
      'ADD',
      'ADMIN',
      'ADMINISTER',
      'ADVISE',
      'AFTER',
      'AGENT',
      'ALL',
      'ALLOCATE',
      'ALL_ROWS',
      'ALTER',
      'ANALYZE',
      'ANCILLARY',
      'AND',
      'ANY',
      'ARCHIVE',
      'ARCHIVELOG',
      'AS',
      'ASC',
      'ASSERTION',
      'ASSOCIATE',
      'AT',
      'ATTRIBUTE',
      'ATTRIBUTES',
      'AUDIT',
      'AUTHENTICATED',
      'AUTHID',
      'AUTHORIZATION',
      'AUTOALLOCATE',
      'AUTOEXTEND',
      'AUTOMATIC',
      'BACKUP',
      'BECOME',
      'BEFORE',
      'BEGIN',
      'BEHALF',
      'BETWEEN',
      'BINDING',
      'BITMAP',
      'BLOCK',
      'BLOCK_RANGE',
      'BODY',
      'BOTH',
      'BOUND',
      'BREAK',
      'BROADCAST',
      'BTITLE',
      'BUFFER_POOL',
      'BUILD',
      'BULK',
      'BY',
      'CACHE',
      'CACHE_INSTANCES',
      'CALL',
      'CANCEL',
      'CASCADE',
      'CASE',
      'CATEGORY',
      'CHAINED',
      'CHANGE',
      'CHECK',
      'CHECKPOINT',
      'CHILD',
      'CHOOSE',
      'CHUNK',
      'CLASS',
      'CLEAR',
      'CLONE',
      'CLOSE',
      'CLOSE_CACHED_OPEN_CURSORS',
      'CLUSTER',
      'COALESCE',
      'COLUMN',
      'COLUMNS',
      'COLUMN_VALUE',
      'COMMENT',
      'COMMIT',
      'COMMITTED',
      'COMPATIBILITY',
      'COMPILE',
      'COMPLETE',
      'COMPOSITE_LIMIT',
      'COMPRESS',
      'COMPUTE',
      'CONNECT',
      'CONNECT_TIME',
      'CONSIDER',
      'CONSISTENT',
      'CONSTANT',
      'CONSTRAINT',
      'CONSTRAINTS',
      'CONTAINER',
      'CONTENTS',
      'CONTEXT',
      'CONTINUE',
      'CONTROLFILE',
      'COPY',
      'COST',
      'CPU_PER_CALL',
      'CPU_PER_SESSION',
      'CREATE',
      'CREATE_STORED_OUTLINES',
      'CROSS',
      'CUBE',
      'CURRENT',
      'CURSOR',
      'CYCLE',
      'DANGLING',
      'DATA',
      'DATABASE',
      'DATAFILE',
      'DATAFILES',
      'DBA',
      'DDL',
      'DEALLOCATE',
      'DEBUG',
      'DECLARE',
      'DEFAULT',
      'DEFERRABLE',
      'DEFERRED',
      'DEFINER',
      'DEGREE',
      'DELETE',
      'DEMAND',
      'DESC',
      'DETERMINES',
      'DICTIONARY',
      'DIMENSION',
      'DIRECTORY',
      'DISABLE',
      'DISASSOCIATE',
      'DISCONNECT',
      'DISKGROUP',
      'DISMOUNT',
      'DISTINCT',
      'DISTRIBUTED',
      'DOMAIN',
      'DROP',
      'DYNAMIC',
      'EACH',
      'ELSE',
      'EMPTY',
      'ENABLE',
      'END',
      'ENFORCE',
      'ENTRY',
      'ESCAPE',
      'ESTIMATE',
      'EVENTS',
      'EXCEPT',
      'EXCEPTION',
      'EXCEPTIONS',
      'EXCHANGE',
      'EXCLUDING',
      'EXCLUSIVE',
      'EXEC',
      'EXECUTE',
      'EXISTS',
      'EXPIRE',
      'EXPLAIN',
      'EXPLOSION',
      'EXTENDS',
      'EXTENT',
      'EXTENTS',
      'EXTERNALLY',
      'FAILED_LOGIN_ATTEMPTS',
      'FALSE',
      'FAST',
      'FILE',
      'FILTER',
      'FIRST_ROWS',
      'FLAGGER',
      'FLASHBACK',
      'FLUSH',
      'FOLLOWING',
      'FOR',
      'FORCE',
      'FOREIGN',
      'FREELIST',
      'FREELISTS',
      'FRESH',
      'FROM',
      'FULL',
      'FUNCTION',
      'FUNCTIONS',
      'GENERATED',
      'GLOBAL',
      'GLOBALLY',
      'GLOBAL_NAME',
      'GRANT',
      'GROUP',
      'GROUPS',
      'HASH',
      'HASHKEYS',
      'HAVING',
      'HEADER',
      'HEAP',
      'HIERARCHY',
      'HOUR',
      'ID',
      'IDENTIFIED',
      'IDENTIFIER',
      'IDGENERATORS',
      'IDLE_TIME',
      'IF',
      'IMMEDIATE',
      'IN',
      'INCLUDING',
      'INCREMENT',
      'INCREMENTAL',
      'INDEX',
      'INDEXED',
      'INDEXES',
      'INDEXTYPE',
      'INDEXTYPES',
      'INDICATOR',
      'INITIAL',
      'INITIALIZED',
      'INITIALLY',
      'INITRANS',
      'INNER',
      'INSERT',
      'INSTANCE',
      'INSTANCES',
      'INSTEAD',
      'INTERMEDIATE',
      'INTERSECT',
      'INTO',
      'INVALIDATE',
      'IS',
      'ISOLATION',
      'ISOLATION_LEVEL',
      'JAVA',
      'JOIN',
      'KEEP',
      'KEY',
      'KILL',
      'LABEL',
      'LAYER',
      'LEADING',
      'LEFT',
      'LESS',
      'LEVEL',
      'LIBRARY',
      'LIKE',
      'LIMIT',
      'LINK',
      'LIST',
      'LOCAL',
      'LOCATOR',
      'LOCK',
      'LOCKED',
      'LOGFILE',
      'LOGGING',
      'LOGICAL_READS_PER_CALL',
      'LOGICAL_READS_PER_SESSION',
      'LOGOFF',
      'LOGON',
      'MANAGE',
      'MANAGED',
      'MANAGEMENT',
      'MASTER',
      'MATERIALIZED',
      'MAXARCHLOGS',
      'MAXDATAFILES',
      'MAXEXTENTS',
      'MAXINSTANCES',
      'MAXLOGFILES',
      'MAXLOGHISTORY',
      'MAXLOGMEMBERS',
      'MAXSIZE',
      'MAXTRANS',
      'MAXVALUE',
      'MEMBER',
      'MERGE',
      'METHOD',
      'MINEXTENTS',
      'MINIMIZE',
      'MINIMUM',
      'MINUS',
      'MINUTE',
      'MINVALUE',
      'MODE',
      'MODIFY',
      'MONITORING',
      'MOUNT',
      'MOVE',
      'MOVEMENT',
      'MTS_DISPATCHERS',
      'MULTISET',
      'NAMED',
      'NATURAL',
      'NEEDED',
      'NESTED',
      'NESTED_TABLE_ID',
      'NETWORK',
      'NEVER',
      'NEW',
      'NEXT',
      'NLS_CALENDAR',
      'NLS_CHARACTERSET',
      'NLS_COMP',
      'NLS_CURRENCY',
      'NLS_DATE_FORMAT',
      'NLS_DATE_LANGUAGE',
      'NLS_ISO_CURRENCY',
      'NLS_LANG',
      'NLS_LANGUAGE',
      'NLS_NUMERIC_CHARACTERS',
      'NLS_SORT',
      'NLS_SPECIAL_CHARS',
      'NLS_TERRITORY',
      'NO',
      'NOARCHIVELOG',
      'NOAUDIT',
      'NOCACHE',
      'NOCOMPRESS',
      'NOCYCLE',
      'NOFORCE',
      'NOLOGGING',
      'NOMAXVALUE',
      'NOMINIMIZE',
      'NOMINVALUE',
      'NOMONITORING',
      'NONE',
      'NOORDER',
      'NOOVERRIDE',
      'NOPARALLEL',
      'NORELY',
      'NORESETLOGS',
      'NOREVERSE',
      'NORMAL',
      'NOSEGMENT',
      'NOSORT',
      'NOT',
      'NOTHING',
      'NOVALIDATE',
      'NOWAIT',
      'NULL',
      'NULLS',
      'OBJNO',
      'OBJNO_REUSE',
      'OF',
      'OFF',
      'OFFLINE',
      'OID',
      'OIDINDEX',
      'OLD',
      'ON',
      'ONLINE',
      'ONLY',
      'OPCODE',
      'OPEN',
      'OPERATOR',
      'OPTIMAL',
      'OPTIMIZER_GOAL',
      'OPTION',
      'OR',
      'ORDER',
      'ORGANIZATION',
      'OUT',
      'OUTER',
      'OUTLINE',
      'OVER',
      'OVERFLOW',
      'OVERLAPS',
      'OWN',
      'PACKAGE',
      'PACKAGES',
      'PARALLEL',
      'PARAMETERS',
      'PARENT',
      'PARTITION',
      'PARTITIONS',
      'PARTITION_HASH',
      'PARTITION_RANGE',
      'PASSWORD',
      'PASSWORD_GRACE_TIME',
      'PASSWORD_LIFE_TIME',
      'PASSWORD_LOCK_TIME',
      'PASSWORD_REUSE_MAX',
      'PASSWORD_REUSE_TIME',
      'PASSWORD_VERIFY_FUNCTION',
      'PCTFREE',
      'PCTINCREASE',
      'PCTTHRESHOLD',
      'PCTUSED',
      'PCTVERSION',
      'PERCENT',
      'PERMANENT',
      'PLAN',
      'PLSQL_DEBUG',
      'POST_TRANSACTION',
      'PREBUILT',
      'PRECEDING',
      'PREPARE',
      'PRESENT',
      'PRESERVE',
      'PREVIOUS',
      'PRIMARY',
      'PRIOR',
      'PRIVATE',
      'PRIVATE_SGA',
      'PRIVILEGE',
      'PRIVILEGES',
      'PROCEDURE',
      'PROFILE',
      'PUBLIC',
      'PURGE',
      'QUERY',
      'QUEUE',
      'QUOTA',
      'RANDOM',
      'RANGE',
      'RBA',
      'READ',
      'READS',
      'REBUILD',
      'RECORDS_PER_BLOCK',
      'RECOVER',
      'RECOVERABLE',
      'RECOVERY',
      'RECYCLE',
      'REDUCED',
      'REFERENCES',
      'REFERENCING',
      'REFRESH',
      'RELY',
      'RENAME',
      'REPLACE',
      'RESET',
      'RESETLOGS',
      'RESIZE',
      'RESOLVE',
      'RESOLVER',
      'RESOURCE',
      'RESTRICT',
      'RESTRICTED',
      'RESUME',
      'RETURN',
      'RETURNING',
      'REUSE',
      'REVERSE',
      'REVOKE',
      'REWRITE',
      'RIGHT',
      'ROLE',
      'ROLES',
      'ROLLBACK',
      'ROLLUP',
      'ROW',
      'ROWNUM',
      'ROWS',
      'RULE',
      'SAMPLE',
      'SAVEPOINT',
      'SCAN',
      'SCAN_INSTANCES',
      'SCHEMA',
      'SCN',
      'SCOPE',
      'SD_ALL',
      'SD_INHIBIT',
      'SD_SHOW',
      'SEGMENT',
      'SEG_BLOCK',
      'SEG_FILE',
      'SELECT',
      'SELECTIVITY',
      'SEQUENCE',
      'SERIALIZABLE',
      'SERVERERROR',
      'SESSION',
      'SESSIONS_PER_USER',
      'SESSION_CACHED_CURSORS',
      'SET',
      'SHARE',
      'SHARED',
      'SHARED_POOL',
      'SHRINK',
      'SHUTDOWN',
      'SINGLETASK',
      'SIZE',
      'SKIP',
      'SKIP_UNUSABLE_INDEXES',
      'SNAPSHOT',
      'SOME',
      'SORT',
      'SOURCE',
      'SPECIFICATION',
      'SPLIT',
      'SQL_TRACE',
      'STANDBY',
      'START',
      'STARTUP',
      'STATEMENT_ID',
      'STATIC',
      'STATISTICS',
      'STOP',
      'STORAGE',
      'STORE',
      'STRUCTURE',
      'SUBMULTISET',
      'SUBPARTITION',
      'SUBPARTITIONS',
      'SUCCESSFUL',
      'SUMMARY',
      'SUPPLEMENTAL',
      'SUSPEND',
      'SWITCH',
      'SYNONYM',
      'SYSDBA',
      'SYSOPER',
      'SYSTEM',
      'SYS_OP_BITVEC',
      'SYS_OP_ENFORCE_NOT_NULL$',
      'SYS_OP_NOEXPAND',
      'SYS_OP_NTCIMG$',
      'TABLE',
      'TABLES',
      'TABLESPACE',
      'TABLESPACE_NO',
      'TABNO',
      'TEMPFILE',
      'TEMPORARY',
      'THAN',
      'THE',
      'THEN',
      'THREAD',
      'THROUGH',
      'TIMEOUT',
      'TIMEZONE_HOUR',
      'TIMEZONE_MINUTE',
      'TIME_ZONE',
      'TO',
      'TOPLEVEL',
      'TRACE',
      'TRACING',
      'TRAILING',
      'TRANSACTION',
      'TRANSITIONAL',
      'TRIGGER',
      'TRIGGERS',
      'TRUE',
      'TRUNCATE',
      'TYPE',
      'TYPES',
      'UNARCHIVED',
      'UNBOUND',
      'UNBOUNDED',
      'UNDO',
      'UNIFORM',
      'UNION',
      'UNIQUE',
      'UNLIMITED',
      'UNLOCK',
      'UNRECOVERABLE',
      'UNTIL',
      'UNUSABLE',
      'UNUSED',
      'UPDATABLE',
      'UPDATE',
      'UPD_INDEXES',
      'UPPPER',
      'USAGE',
      'USE',
      'USER_DEFINED',
      'USE_STORED_OUTLINES',
      'USING',
      'VALIDATE',
      'VALIDATION',
      'VALUES',
      'VIEW',
      'WHEN',
      'WHENEVER',
      'WHERE',
      'WITH',
      'WITHOUT',
      'WORK',
      'WRITE',
   );
   $self->listAdd('operators',
      '!=',
      '*',
      '**',
      '+',
      '-',
      '..',
      '/',
      ':=',
      '<',
      '<=',
      '<>',
      '=',
      '=>',
      '>',
      '>=',
      '^=',
      '||',
      '~=',
   );
   $self->listAdd('types',
      'ANYDATA',
      'ANYDATASET',
      'ANYTYPE',
      'ARRAY',
      'BFILE',
      'BINARY_DOUBLE',
      'BINARY_FLOAT',
      'BINARY_INTEGER',
      'BLOB',
      'BOOLEAN',
      'CFILE',
      'CHAR',
      'CHARACTER',
      'CLOB',
      'DATE',
      'DAY',
      'DBURITYPE',
      'DEC',
      'DECIMAL',
      'DOUBLE',
      'FLOAT',
      'FLOB',
      'HTTPURITYPE',
      'INT',
      'INTEGER',
      'INTERVAL',
      'LOB',
      'LONG',
      'MLSLABEL',
      'MONTH',
      'NATIONAL',
      'NCHAR',
      'NCLOB',
      'NUMBER',
      'NUMERIC',
      'NVARCHAR',
      'OBJECT',
      'PLS_INTEGER',
      'PRECISION',
      'RAW',
      'REAL',
      'RECORD',
      'ROWID',
      'SECOND',
      'SINGLE',
      'SMALLINT',
      'TIME',
      'TIMESTAMP',
      'URIFACTORYTYPE',
      'URITYPE',
      'UROWID',
      'VARCHAR',
      'VARCHAR2',
      'VARRAY',
      'VARYING',
      'XMLTYPE',
      'YEAR',
      'ZONE',
   );
   $self->contextdata({
      'Multiline C-style comment' => {
         callback => \&parseMultilineCstylecomment,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal Text',
      },
      'SQL*Plus directive to include file' => {
         callback => \&parseSQLPlusdirectivetoincludefile,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'SQL*Plus remark directive' => {
         callback => \&parseSQLPlusremarkdirective,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'Singleline PL/SQL-style comment' => {
         callback => \&parseSinglelinePLSQLstylecomment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'String literal' => {
         callback => \&parseStringliteral,
         attribute => 'String',
      },
      'User-defined identifier' => {
         callback => \&parseUserdefinedidentifier,
         attribute => 'Identifier',
         lineending => '#pop',
      },
   });
   $self->deliminators('\\s||\\(|\\)|,|\\%|\\&|;|\\?|\\[|\\]|\\{|\\}|\\\\|\\+|-|\\*|\\/|\\||=|\\!|<|>|\\~|\\^|:|\\.');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'SQL';
}

sub parseMultilineCstylecomment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '*'
   # char1 => '/'
   # context => '#pop'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '*', '/', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'operators'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'operators', 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => 'functions'
   # attribute => 'Function'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'functions', 0, undef, 0, '#stay', 'Function')) {
      return 1
   }
   # String => 'types'
   # attribute => 'Data Type'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'types', 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%bulk_exceptions\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%bulk_exceptions\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%bulk_rowcount\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%bulk_rowcount\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%found\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%found\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%isopen\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%isopen\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%notfound\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%notfound\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%rowcount\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%rowcount\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%rowtype\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%rowtype\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # String => '%type\b'
   # attribute => 'Data Type'
   # context => '#stay'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '%type\\b', 1, 0, 0, undef, 0, '#stay', 'Data Type')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#stay'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#stay', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#stay', 'Decimal')) {
      return 1
   }
   # attribute => 'String'
   # char => '''
   # context => 'String literal'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String literal', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'Singleline PL/SQL-style comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'Singleline PL/SQL-style comment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '/'
   # char1 => '*'
   # context => 'Multiline C-style comment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '/', '*', 0, 0, 0, undef, 0, 'Multiline C-style comment', 'Comment')) {
      return 1
   }
   # String => '^rem\b'
   # attribute => 'Comment'
   # column => '0'
   # context => 'SQL*Plus remark directive'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^rem\\b', 1, 0, 0, 0, 0, 'SQL*Plus remark directive', 'Comment')) {
      return 1
   }
   # attribute => 'Identifier'
   # char => '"'
   # context => 'User-defined identifier'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'User-defined identifier', 'Identifier')) {
      return 1
   }
   # String => '(:|&&?)\w+'
   # attribute => 'External Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '(:|&&?)\\w+', 0, 0, 0, undef, 0, '#stay', 'External Variable')) {
      return 1
   }
   # String => '^/$'
   # attribute => 'Symbol'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^/$', 0, 0, 0, 0, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '^@@?[^@ \t\r\n]'
   # attribute => 'Preprocessor'
   # column => '0'
   # context => 'SQL*Plus directive to include file'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '^@@?[^@ \\t\\r\\n]', 0, 0, 0, 0, 0, 'SQL*Plus directive to include file', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parseSQLPlusdirectivetoincludefile {
   my ($self, $text) = @_;
   return 0;
};

sub parseSQLPlusremarkdirective {
   my ($self, $text) = @_;
   return 0;
};

sub parseSinglelinePLSQLstylecomment {
   my ($self, $text) = @_;
   return 0;
};

sub parseStringliteral {
   my ($self, $text) = @_;
   # attribute => 'String Char'
   # context => '#stay'
   # type => 'HlCStringChar'
   if ($self->testHlCStringChar($text, 0, undef, 0, '#stay', 'String Char')) {
      return 1
   }
   # String => '&&?\w+'
   # attribute => 'External Variable'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '&&?\\w+', 0, 0, 0, undef, 0, '#stay', 'External Variable')) {
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

sub parseUserdefinedidentifier {
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


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::SQL - a Plugin for SQL syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::SQL;
 my $sh = new Syntax::Highlight::Engine::Kate::SQL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::SQL is a  plugin module that provides syntax highlighting
for SQL to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author