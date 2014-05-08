# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'sql-mysql.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.08
#kate version 2.4
#kate author Shane Wright (me@shanewright.co.uk)
#generated: Sun Feb  3 22:02:06 2008, localtime

package Syntax::Highlight::Engine::Kate::SQL_MySQL;

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
      'ABS',
      'ACOS',
      'ADDDATE',
      'AES_DECRYPT',
      'AES_ENCRYPT',
      'ASCII',
      'ASIN',
      'ATAN',
      'ATAN2',
      'AVG',
      'BENCHMARK',
      'BIN',
      'BIT_AND',
      'BIT_COUNT',
      'BIT_LENGTH',
      'BIT_OR',
      'CAST',
      'CEILING',
      'CHAR',
      'CHARACTER_LENGTH',
      'CHAR_LENGTH',
      'CONCAT',
      'CONCAT_WS',
      'CONNECTION_ID',
      'CONV',
      'CONVERT',
      'COS',
      'COT',
      'COUNT',
      'CURDATE',
      'CURRENT_DATE',
      'CURRENT_TIME',
      'CURRENT_TIMESTAMP',
      'CURTIME',
      'DATABASE',
      'DATE_ADD',
      'DATE_FORMAT',
      'DATE_SUB',
      'DAYNAME',
      'DAYOFMONTH',
      'DAYOFWEEK',
      'DAYOFYEAR',
      'DECODE',
      'DEGREES',
      'DES_DECRYPT',
      'DES_ENCRYPT',
      'ELT',
      'ENCODE',
      'ENCRYPT',
      'EXP',
      'EXPORT_SET',
      'EXTRACT',
      'FIELD',
      'FIND_IN_SET',
      'FLOOR',
      'FORMAT',
      'FOUND_ROWS',
      'FROM_DAYS',
      'FROM_UNIXTIME',
      'GET_LOCK',
      'GREATEST',
      'HEX',
      'HOUR',
      'INET_ATON',
      'INET_NTOA',
      'INSERT',
      'INSTR',
      'IS_FREE_LOCK',
      'LAST_INSERT_ID',
      'LCASE',
      'LEAST',
      'LEFT',
      'LENGTH',
      'LN',
      'LOAD_FILE',
      'LOCATE',
      'LOG',
      'LOG10',
      'LOG2',
      'LOWER',
      'LPAD',
      'LTRIM',
      'MAKE_SET',
      'MASTER_POS_WAIT',
      'MAX',
      'MD5',
      'MID',
      'MIN',
      'MINUTE',
      'MOD',
      'MONTH',
      'MONTHNAME',
      'NOW',
      'OCT',
      'OCTET_LENGTH',
      'ORD',
      'PASSWORD',
      'PERIOD_ADD',
      'PERIOD_DIFF',
      'PI',
      'POSITION',
      'POW',
      'POWER',
      'QUARTER',
      'QUOTE',
      'RADIANS',
      'RAND',
      'RELEASE_LOCK',
      'REPEAT',
      'REPLACE',
      'REVERSE',
      'RIGHT',
      'ROUND',
      'RPAD',
      'RTRIM',
      'SECOND',
      'SEC_TO_TIME',
      'SESSION_USER',
      'SHA',
      'SHA1',
      'SIGN',
      'SIN',
      'SOUNDEX',
      'SPACE',
      'SQRT',
      'STD',
      'STDDEV',
      'SUBDATE',
      'SUBSTRING',
      'SUBSTRING_INDEX',
      'SUM',
      'SYSDATE',
      'SYSTEM_USER',
      'TAN',
      'TIME_FORMAT',
      'TIME_TO_SEC',
      'TO_DAYS',
      'TRIM',
      'TRUNCATE',
      'UCASE',
      'UNIX_TIMESTAMP',
      'UPPER',
      'USER',
      'VERSION',
      'WEEK',
      'WEEKDAY',
      'YEAR',
      'YEARWEEK',
   );
   $self->listAdd('keywords',
      'ACCESS',
      'ADD',
      'ALL',
      'ALTER',
      'ANALYZE',
      'AND',
      'AS',
      'ASC',
      'AUTO_INCREMENT',
      'BDB',
      'BERKELEYDB',
      'BETWEEN',
      'BOTH',
      'BY',
      'CASCADE',
      'CASE',
      'CHANGE',
      'COLUMN',
      'COLUMNS',
      'CONSTRAINT',
      'CREATE',
      'CROSS',
      'CURRENT_DATE',
      'CURRENT_TIME',
      'CURRENT_TIMESTAMP',
      'DATABASE',
      'DATABASES',
      'DAY_HOUR',
      'DAY_MINUTE',
      'DAY_SECOND',
      'DEC',
      'DEFAULT',
      'DELAYED',
      'DELETE',
      'DESC',
      'DESCRIBE',
      'DISTINCT',
      'DISTINCTROW',
      'DROP',
      'ELSE',
      'ENCLOSED',
      'ESCAPED',
      'EXISTS',
      'EXPLAIN',
      'FIELDS',
      'FOR',
      'FOREIGN',
      'FROM',
      'FULLTEXT',
      'FUNCTION',
      'GRANT',
      'GROUP',
      'HAVING',
      'HIGH_PRIORITY',
      'IF',
      'IGNORE',
      'IN',
      'INDEX',
      'INFILE',
      'INNER',
      'INNODB',
      'INSERT',
      'INTERVAL',
      'INTO',
      'IS',
      'JOIN',
      'KEY',
      'KEYS',
      'KILL',
      'LEADING',
      'LEFT',
      'LIKE',
      'LIMIT',
      'LINES',
      'LOAD',
      'LOCK',
      'LOW_PRIORITY',
      'MASTER_SERVER_ID',
      'MATCH',
      'MRG_MYISAM',
      'NATURAL',
      'NOT',
      'NULL',
      'NUMERIC',
      'ON',
      'OPTIMIZE',
      'OPTION',
      'OPTIONALLY',
      'OR',
      'ORDER',
      'OUTER',
      'OUTFILE',
      'PARTIAL',
      'PRECISION',
      'PRIMARY',
      'PRIVILEGES',
      'PROCEDURE',
      'PURGE',
      'READ',
      'REFERENCES',
      'REGEXP',
      'RENAME',
      'REPLACE',
      'REQUIRE',
      'RESTRICT',
      'RETURNS',
      'REVOKE',
      'RIGHT',
      'RLIKE',
      'SELECT',
      'SET',
      'SHOW',
      'SONAME',
      'SQL_BIG_RESULT',
      'SQL_CALC_FOUND_ROWS',
      'SQL_SMALL_RESULT',
      'SSL',
      'STARTING',
      'STRAIGHT_JOIN',
      'STRIPED',
      'TABLE',
      'TABLES',
      'TERMINATED',
      'THEN',
      'TO',
      'TRAILING',
      'UNION',
      'UNIQUE',
      'UNLOCK',
      'UNSIGNED',
      'UPDATE',
      'USAGE',
      'USE',
      'USER_RESOURCES',
      'USING',
      'VALUES',
      'VARYING',
      'WHEN',
      'WHERE',
      'WITH',
      'WRITE',
      'XOR',
      'YEAR_MONTH',
      'ZEROFILL',
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
      'BIGINT',
      'BINARY',
      'BLOB',
      'CHAR',
      'CHARACTER',
      'DECIMAL',
      'DOUBLE',
      'FLOAT',
      'HOUR_MINUTE',
      'HOUR_SECOND',
      'INT',
      'INTEGER',
      'LONG',
      'LONGBLOB',
      'LONGTEXT',
      'MEDIUMBLOB',
      'MEDIUMINT',
      'MEDIUMTEXT',
      'MIDDLEINT',
      'MINUTE_SECOND',
      'REAL',
      'SMALLINT',
      'TEXT',
      'TINYBLOB',
      'TINYINT',
      'TINYTEXT',
      'VARBINARY',
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
   $self->deliminators('\\s||\\(|\\)|,|\\%|\\&|;|\\?|\\[|\\]|\\{|\\}|\\\\|\\+|-|\\*|\\/|\\||=|\\!|<|>|\\~|\\^|:|\\.');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'SQL (MySQL)';
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

Syntax::Highlight::Engine::Kate::SQL_MySQL - a Plugin for SQL (MySQL) syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::SQL_MySQL;
 my $sh = new Syntax::Highlight::Engine::Kate::SQL_MySQL([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::SQL_MySQL is a  plugin module that provides syntax highlighting
for SQL (MySQL) to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author