# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sql-postgresql.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.08
#kate version 2.4
#kate author Shane Wright (me@shanewright.co.uk)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::SQL_PostgreSQL;

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
      'ABBREV',
      'ABS',
      'ACOS',
      'AGE',
      'AREA',
      'ASCII',
      'ASIN',
      'ATAN',
      'ATAN2',
      'AVG',
      'BIT_LENGTH',
      'BOX',
      'BOX',
      'BROADCAST',
      'BTRIM',
      'CBRT',
      'CEIL',
      'CENTER',
      'CHARACTER_LENGTH',
      'CHAR_LENGTH',
      'CHR',
      'CIRCLE',
      'COALESCE',
      'COL_DESCRIPTION',
      'CONVERT',
      'COS',
      'COT',
      'COUNT',
      'CURRVAL',
      'DATE_PART',
      'DATE_TRUNC',
      'DECODE',
      'DEGREES',
      'DIAMETER',
      'ENCODE',
      'EXP',
      'EXTRACT',
      'EXTRACT',
      'FLOOR',
      'HAS_TABLE_PRIVILEGE',
      'HEIGHT',
      'HOST',
      'INITCAP',
      'ISCLOSED',
      'ISFINITE',
      'ISOPEN',
      'LENGTH',
      'LN',
      'LOG',
      'LOWER',
      'LPAD',
      'LSEG',
      'LTRIM',
      'MASKLEN',
      'MAX',
      'MIN',
      'MOD',
      'NETMASK',
      'NETWORK',
      'NEXTVAL',
      'NOW',
      'NPOINT',
      'NULLIF',
      'OBJ_DESCRIPTION',
      'OCTET_LENGTH',
      'PATH',
      'PCLOSE',
      'PG_CLIENT_ENCODING',
      'PG_GET_INDEXDEF',
      'PG_GET_RULEDEF',
      'PG_GET_USERBYID',
      'PG_GET_VIEWDEF',
      'PI',
      'POINT',
      'POLYGON',
      'POPEN',
      'POSITION',
      'POW',
      'RADIANS',
      'RADIUS',
      'RANDOM',
      'REPEAT',
      'ROUND',
      'RPAD',
      'RTRIM',
      'SETVAL',
      'SET_MASKLEN',
      'SIGN',
      'SIN',
      'SQRT',
      'STDDEV',
      'STRPOS',
      'SUBSTR',
      'SUBSTRING',
      'SUM',
      'TAN',
      'TIMEOFDAY',
      'TIMESTAMP',
      'TO_ASCII',
      'TO_CHAR',
      'TO_DATE',
      'TO_NUMBER',
      'TO_TIMESTAMP',
      'TRANSLATE',
      'TRIM',
      'TRUNC',
      'UPPER',
      'VARIANCE',
      'WIDTH',
   );
   $self->listAdd('keywords',
      'ABORT',
      'ACCESS',
      'ACTION',
      'ADD',
      'ADMIN',
      'AFTER',
      'AGGREGATE',
      'ALIAS',
      'ALL',
      'ALLOCATE',
      'ALTER',
      'ANALYSE',
      'ANALYZE',
      'ANY',
      'ARE',
      'AS',
      'ASC',
      'ASENSITIVE',
      'ASSERTION',
      'ASSIGNMENT',
      'ASYMMETRIC',
      'AT',
      'ATOMIC',
      'AUTHORIZATION',
      'BACKWARD',
      'BEFORE',
      'BEGIN',
      'BETWEEN',
      'BINARY',
      'BOTH',
      'BREADTH',
      'BY',
      'C',
      'CACHE',
      'CALL',
      'CALLED',
      'CARDINALITY',
      'CASCADE',
      'CASCADED',
      'CASE',
      'CAST',
      'CATALOG',
      'CATALOG_NAME',
      'CHAIN',
      'CHARACTERISTICS',
      'CHARACTER_LENGTH',
      'CHARACTER_SET_CATALOG',
      'CHARACTER_SET_NAME',
      'CHARACTER_SET_SCHEMA',
      'CHAR_LENGTH',
      'CHECK',
      'CHECKED',
      'CHECKPOINT',
      'CLASS',
      'CLASS_ORIGIN',
      'CLOB',
      'CLOSE',
      'CLUSTER',
      'COALESCE',
      'COBOL',
      'COLLATE',
      'COLLATION',
      'COLLATION_CATALOG',
      'COLLATION_NAME',
      'COLLATION_SCHEMA',
      'COLUMN',
      'COLUMN_NAME',
      'COMMAND_FUNCTION',
      'COMMAND_FUNCTION_CODE',
      'COMMENT',
      'COMMIT',
      'COMMITTED',
      'COMPLETION',
      'CONDITION_NUMBER',
      'CONNECT',
      'CONNECTION',
      'CONNECTION_NAME',
      'CONSTRAINT',
      'CONSTRAINTS',
      'CONSTRAINT_CATALOG',
      'CONSTRAINT_NAME',
      'CONSTRAINT_SCHEMA',
      'CONSTRUCTOR',
      'CONTAINS',
      'CONTINUE',
      'CONVERT',
      'COPY',
      'CORRESPONDING',
      'COUNT',
      'CREATE',
      'CREATEDB',
      'CREATEUSER',
      'CROSS',
      'CUBE',
      'CURRENT',
      'CURRENT_DATE',
      'CURRENT_PATH',
      'CURRENT_ROLE',
      'CURRENT_TIME',
      'CURRENT_TIMESTAMP',
      'CURRENT_USER',
      'CURSOR',
      'CURSOR_NAME',
      'CYCLE',
      'DATA',
      'DATABASE',
      'DATE',
      'DATETIME_INTERVAL_CODE',
      'DATETIME_INTERVAL_PRECISION',
      'DAY',
      'DEALLOCATE',
      'DEC',
      'DECIMAL',
      'DECLARE',
      'DEFAULT',
      'DEFERRABLE',
      'DEFERRED',
      'DEFINED',
      'DEFINER',
      'DELETE',
      'DELIMITERS',
      'DEPTH',
      'DEREF',
      'DESC',
      'DESCRIBE',
      'DESCRIPTOR',
      'DESTROY',
      'DESTRUCTOR',
      'DETERMINISTIC',
      'DIAGNOSTICS',
      'DICTIONARY',
      'DISCONNECT',
      'DISPATCH',
      'DISTINCT',
      'DO',
      'DOMAIN',
      'DOUBLE',
      'DROP',
      'DYNAMIC',
      'DYNAMIC_FUNCTION',
      'DYNAMIC_FUNCTION_CODE',
      'EACH',
      'ELSE',
      'ENCODING',
      'ENCRYPTED',
      'END',
      'END-EXEC',
      'EQUALS',
      'ESCAPE',
      'EVERY',
      'EXCEPT',
      'EXCEPTION',
      'EXCLUSIVE',
      'EXEC',
      'EXECUTE',
      'EXISTING',
      'EXISTS',
      'EXPLAIN',
      'EXTERNAL',
      'FALSE',
      'FETCH',
      'FINAL',
      'FIRST',
      'FOR',
      'FORCE',
      'FOREIGN',
      'FORTRAN',
      'FORWARD',
      'FOUND',
      'FREE',
      'FREEZE',
      'FROM',
      'FULL',
      'FUNCTION',
      'G',
      'GENERAL',
      'GENERATED',
      'GET',
      'GLOBAL',
      'GO',
      'GOTO',
      'GRANT',
      'GRANTED',
      'GROUP',
      'GROUPING',
      'HANDLER',
      'HAVING',
      'HIERARCHY',
      'HOLD',
      'HOST',
      'HOUR',
      'IDENTITY',
      'IGNORE',
      'ILIKE',
      'IMMEDIATE',
      'IMMUTABLE',
      'IMPLEMENTATION',
      'IN',
      'INCREMENT',
      'INDEX',
      'INDICATOR',
      'INFIX',
      'INHERITS',
      'INITIALIZE',
      'INITIALLY',
      'INNER',
      'INOUT',
      'INPUT',
      'INSENSITIVE',
      'INSERT',
      'INSTANCE',
      'INSTANTIABLE',
      'INSTEAD',
      'INTERSECT',
      'INTERVAL',
      'INTO',
      'INVOKER',
      'IS',
      'ISNULL',
      'ISOLATION',
      'ITERATE',
      'JOIN',
      'K',
      'KEY',
      'KEY_MEMBER',
      'KEY_TYPE',
      'LANCOMPILER',
      'LANGUAGE',
      'LARGE',
      'LAST',
      'LATERAL',
      'LEADING',
      'LEFT',
      'LENGTH',
      'LESS',
      'LEVEL',
      'LIKE',
      'LIMIT',
      'LISTEN',
      'LOAD',
      'LOCAL',
      'LOCALTIME',
      'LOCALTIMESTAMP',
      'LOCATION',
      'LOCATOR',
      'LOCK',
      'LOWER',
      'M',
      'MAP',
      'MATCH',
      'MAX',
      'MAXVALUE',
      'MESSAGE_LENGTH',
      'MESSAGE_OCTET_LENGTH',
      'MESSAGE_TEXT',
      'METHOD',
      'MIN',
      'MINUTE',
      'MINVALUE',
      'MOD',
      'MODE',
      'MODIFIES',
      'MODIFY',
      'MODULE',
      'MONTH',
      'MORE',
      'MOVE',
      'MUMPS',
      'NAME',
      'NAMES',
      'NATIONAL',
      'NATURAL',
      'NEW',
      'NEXT',
      'NO',
      'NOCREATEDB',
      'NOCREATEUSER',
      'NONE',
      'NOT',
      'NOTHING',
      'NOTIFY',
      'NOTNULL',
      'NULL',
      'NULLABLE',
      'NULLIF',
      'NUMBER',
      'NUMERIC',
      'OBJECT',
      'OCTET_LENGTH',
      'OF',
      'OFF',
      'OFFSET',
      'OIDS',
      'OLD',
      'ON',
      'ONLY',
      'OPEN',
      'OPERATION',
      'OPERATOR',
      'OPTION',
      'OPTIONS',
      'ORDER',
      'ORDINALITY',
      'OUT',
      'OUTER',
      'OUTPUT',
      'OVERLAPS',
      'OVERLAY',
      'OVERRIDING',
      'OWNER',
      'PAD',
      'PARAMETER',
      'PARAMETERS',
      'PARAMETER_MODE',
      'PARAMETER_NAME',
      'PARAMETER_ORDINAL_POSITION',
      'PARAMETER_SPECIFIC_CATALOG',
      'PARAMETER_SPECIFIC_NAME',
      'PARAMETER_SPECIFIC_SCHEMA',
      'PARTIAL',
      'PASCAL',
      'PASSWORD',
      'PATH',
      'PENDANT',
      'PLI',
      'POSITION',
      'POSTFIX',
      'PRECISION',
      'PREFIX',
      'PREORDER',
      'PREPARE',
      'PRESERVE',
      'PRIMARY',
      'PRIOR',
      'PRIVILEGES',
      'PROCEDURAL',
      'PROCEDURE',
      'PUBLIC',
      'READ',
      'READS',
      'REAL',
      'RECURSIVE',
      'REF',
      'REFERENCES',
      'REFERENCING',
      'REINDEX',
      'RELATIVE',
      'RENAME',
      'REPEATABLE',
      'REPLACE',
      'RESET',
      'RESTRICT',
      'RESULT',
      'RETURN',
      'RETURNED_LENGTH',
      'RETURNED_OCTET_LENGTH',
      'RETURNED_SQLSTATE',
      'RETURNS',
      'REVOKE',
      'RIGHT',
      'ROLE',
      'ROLLBACK',
      'ROLLUP',
      'ROUTINE',
      'ROUTINE_CATALOG',
      'ROUTINE_NAME',
      'ROUTINE_SCHEMA',
      'ROW',
      'ROWS',
      'ROW_COUNT',
      'RULE',
      'SAVEPOINT',
      'SCALE',
      'SCHEMA',
      'SCHEMA_NAME',
      'SCOPE',
      'SCROLL',
      'SEARCH',
      'SECOND',
      'SECTION',
      'SECURITY',
      'SELECT',
      'SELF',
      'SENSITIVE',
      'SEQUENCE',
      'SERIALIZABLE',
      'SERVER_NAME',
      'SESSION',
      'SESSION_USER',
      'SET',
      'SETOF',
      'SETS',
      'SHARE',
      'SHOW',
      'SIMILAR',
      'SIMPLE',
      'SIZE',
      'SOME',
      'SOURCE',
      'SPACE',
      'SPECIFIC',
      'SPECIFICTYPE',
      'SPECIFIC_NAME',
      'SQL',
      'SQLCODE',
      'SQLERROR',
      'SQLEXCEPTION',
      'SQLSTATE',
      'SQLWARNING',
      'STABLE',
      'START',
      'STATE',
      'STATEMENT',
      'STATIC',
      'STATISTICS',
      'STDIN',
      'STDOUT',
      'STRUCTURE',
      'STYLE',
      'SUBCLASS_ORIGIN',
      'SUBLIST',
      'SUBSTRING',
      'SUM',
      'SYMMETRIC',
      'SYSID',
      'SYSTEM',
      'SYSTEM_USER',
      'TABLE',
      'TABLE_NAME',
      'TEMP',
      'TEMPLATE',
      'TEMPORARY',
      'TERMINATE',
      'THAN',
      'THEN',
      'TIMEZONE_HOUR',
      'TIMEZONE_MINUTE',
      'TO',
      'TOAST',
      'TRAILING',
      'TRANSACTION',
      'TRANSACTIONS_COMMITTED',
      'TRANSACTIONS_ROLLED_BACK',
      'TRANSACTION_ACTIVE',
      'TRANSFORM',
      'TRANSFORMS',
      'TRANSLATE',
      'TRANSLATION',
      'TREAT',
      'TRIGGER',
      'TRIGGER_CATALOG',
      'TRIGGER_NAME',
      'TRIGGER_SCHEMA',
      'TRIM',
      'TRUE',
      'TRUNCATE',
      'TRUSTED',
      'TYPE',
      'UNCOMMITTED',
      'UNDER',
      'UNENCRYPTED',
      'UNION',
      'UNIQUE',
      'UNKNOWN',
      'UNLISTEN',
      'UNNAMED',
      'UNNEST',
      'UNTIL',
      'UPDATE',
      'UPPER',
      'USAGE',
      'USER',
      'USER_DEFINED_TYPE_CATALOG',
      'USER_DEFINED_TYPE_NAME',
      'USER_DEFINED_TYPE_SCHEMA',
      'USING',
      'VACUUM',
      'VALID',
      'VALUE',
      'VALUES',
      'VARIABLE',
      'VARYING',
      'VERBOSE',
      'VERSION',
      'VIEW',
      'VOLATILE',
      'WHEN',
      'WHENEVER',
      'WHERE',
      'WITH',
      'WITHOUT',
      'WORK',
      'WRITE',
      'YEAR',
      'ZONE',
   );
   $self->listAdd('operators',
      '!',
      '!!',
      '!=',
      '!~',
      '!~*',
      '#',
      '##',
      '%',
      '&',
      '&&',
      '&<',
      '&>',
      '*',
      '**',
      '+',
      '-',
      '..',
      '/',
      ':=',
      '<',
      '<->',
      '<<',
      '<<=',
      '<=',
      '<>',
      '<^',
      '=',
      '=>',
      '>',
      '>=',
      '>>',
      '>>=',
      '>^',
      '?#',
      '?-',
      '?-|',
      '?|',
      '?||',
      '@',
      '@-@',
      '@@',
      'AND',
      'NOT',
      'OR',
      '^',
      '^=',
      '|',
      '|/',
      '||',
      '||/',
      '~',
      '~*',
      '~=',
   );
   $self->listAdd('types',
      'BIGINT',
      'BIGSERIAL',
      'BIT',
      'BIT VARYING',
      'BOOL',
      'BOOLEAN',
      'BOX',
      'BYTEA',
      'CHAR',
      'CHARACTER',
      'CHARACTER VARYING',
      'CIDR',
      'CIRCLE',
      'DATE',
      'DECIMAL',
      'DOUBLE PRECISION',
      'FLOAT8',
      'INET',
      'INT',
      'INT2',
      'INT4',
      'INT8',
      'INTEGER',
      'INTERVAL',
      'LINE',
      'LSEG',
      'LZTEXT',
      'MACADDR',
      'MONEY',
      'NUMERIC',
      'OID',
      'PATH',
      'POINT',
      'POLYGON',
      'REAL',
      'SERIAL',
      'SERIAL8',
      'SMALLINT',
      'TEXT',
      'TIME',
      'TIMESTAMP',
      'TIMESTAMP WITH TIMEZONE',
      'TIMESTAMPTZ',
      'TIMETZ',
      'VARBIT',
      'VARCHAR',
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
      'Preprocessor' => {
         callback => \&parsePreprocessor,
         attribute => 'Preprocessor',
         lineending => '#pop',
      },
      'SingleLineComment' => {
         callback => \&parseSingleLineComment,
         attribute => 'Comment',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
   });
   $self->deliminators('\\s||\\(|\\)|,|;|\\[|\\]|\\{|\\}|\\\\|\\+|-|\\*|\\/|\\||\\!|@|\\&|#|<|>|\\%|\\^|=|\\~|:|\\.|\\?');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'SQL (PostgreSQL)';
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
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '\'', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '#'
   # context => 'SingleLineComment'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '#', 0, 0, 0, undef, 0, 'SingleLineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '-'
   # char1 => '-'
   # context => 'SingleLineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '-', '-', 0, 0, 0, undef, 0, 'SingleLineComment', 'Comment')) {
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
   # String => 'rem\b'
   # attribute => 'Comment'
   # column => '0'
   # context => 'SingleLineComment'
   # insensitive => 'true'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, 'rem\\b', 1, 0, 0, 0, 0, 'SingleLineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # char => '"'
   # context => 'Identifier'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'Identifier', 'Comment')) {
      return 1
   }
   # String => ':&'
   # attribute => 'Symbol'
   # context => '#stay'
   # type => 'AnyChar'
   if ($self->testAnyChar($text, ':&', 0, 0, undef, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '/$'
   # attribute => 'Symbol'
   # column => '0'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '/$', 0, 0, 0, 0, 0, '#stay', 'Symbol')) {
      return 1
   }
   # String => '@@?[^@ \t\r\n]'
   # attribute => 'Preprocessor'
   # column => '0'
   # context => 'Preprocessor'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '@@?[^@ \\t\\r\\n]', 0, 0, 0, 0, 0, 'Preprocessor', 'Preprocessor')) {
      return 1
   }
   return 0;
};

sub parsePreprocessor {
   my ($self, $text) = @_;
   return 0;
};

sub parseSingleLineComment {
   my ($self, $text) = @_;
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
   # attribute => 'Symbol'
   # char => '&'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '&', 0, 0, 0, undef, 0, '#stay', 'Symbol')) {
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

Syntax::Highlight::Engine::Kate::SQL_PostgreSQL - a Plugin for SQL (PostgreSQL) syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::SQL_PostgreSQL;
 my $sh = new Syntax::Highlight::Engine::Kate::SQL_PostgreSQL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::SQL_PostgreSQL is a  plugin module that provides syntax highlighting
for SQL (PostgreSQL) to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author