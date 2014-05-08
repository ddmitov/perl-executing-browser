# Copyright (c) 2005 - 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

# This file was generated from the 'commonlisp.xml' file of the syntax highlight
# engine of the kate text editor (http://www.kate-editor.org

#kate xml version 1.02
#kate version 2.3
#kate author Dominik Haumann (dhdev@gmx.de)
#generated: Sun Feb  3 22:02:04 2008, localtime

package Syntax::Highlight::Engine::Kate::Common_Lisp;

our $VERSION = '0.07';

use strict;
use warnings;
use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
   my $proto = shift;
   my $class = ref($proto) || $proto;
   my $self = $class->SUPER::new(@_);
   $self->attributes({
      'BaseN' => 'BaseN',
      'Brackets' => 'BString',
      'Char' => 'Char',
      'Comment' => 'Comment',
      'Data' => 'DataType',
      'Decimal' => 'DecVal',
      'Definition' => 'Others',
      'Float' => 'Float',
      'Function' => 'Function',
      'Keyword' => 'Keyword',
      'Modifier' => 'Reserved',
      'Normal' => 'Normal',
      'Operator' => 'Operator',
      'Region Marker' => 'RegionMarker',
      'String' => 'String',
      'Variable' => 'Variable',
   });
   $self->listAdd('definitions',
      'defclass',
      'defconstant',
      'defgeneric',
      'define-compiler-macro',
      'define-condition',
      'define-method-combination',
      'define-modify-macro',
      'define-setf-expander',
      'define-setf-method',
      'define-symbol-macro',
      'defmacro',
      'defmethod',
      'defpackage',
      'defparameter',
      'defsetf',
      'defstruct',
      'deftype',
      'defun',
      'defvar',
   );
   $self->listAdd('keywords',
      'abort',
      'abs',
      'access',
      'acons',
      'acos',
      'acosh',
      'add-method',
      'adjoin',
      'adjust-array',
      'adjustable-array-p',
      'allocate-instance',
      'alpha-char-p',
      'alphanumericp',
      'and',
      'append',
      'apply',
      'applyhook',
      'apropos',
      'apropos-list',
      'aref',
      'arithmetic-error',
      'arithmetic-error-operands',
      'arithmetic-error-operation',
      'array',
      'array-dimension',
      'array-dimension-limit',
      'array-dimensions',
      'array-displacement',
      'array-element-type',
      'array-has-fill-pointer-p',
      'array-in-bounds-p',
      'array-rank',
      'array-rank-limit',
      'array-row-major-index',
      'array-total-size',
      'array-total-size-limit',
      'arrayp',
      'ash',
      'asin',
      'asinh',
      'assert',
      'assoc',
      'assoc-if',
      'assoc-if-not',
      'atan',
      'atanh',
      'atom',
      'base-char',
      'base-string',
      'bignum',
      'bit',
      'bit-and',
      'bit-andc1',
      'bit-andc2',
      'bit-eqv',
      'bit-ior',
      'bit-nand',
      'bit-nor',
      'bit-not',
      'bit-orc1',
      'bit-orc2',
      'bit-vector',
      'bit-vector-p',
      'bit-xor',
      'block',
      'boole',
      'boole-1',
      'boole-2',
      'boole-and',
      'boole-andc1',
      'boole-andc2',
      'boole-c1',
      'boole-c2',
      'boole-clr',
      'boole-eqv',
      'boole-ior',
      'boole-nand',
      'boole-nor',
      'boole-orc1',
      'boole-orc2',
      'boole-set',
      'boole-xor',
      'boolean',
      'both-case-p',
      'boundp',
      'break',
      'broadcast-stream',
      'broadcast-stream-streams',
      'built-in-class',
      'butlast',
      'byte',
      'byte-position',
      'byte-size',
      'call-arguments-limit',
      'call-method',
      'call-next-method',
      'capitalize',
      'car',
      'case',
      'catch',
      'ccase',
      'cdr',
      'ceiling',
      'cell-error',
      'cell-error-name',
      'cerror',
      'change-class',
      'char',
      'char-bit',
      'char-bits',
      'char-bits-limit',
      'char-code',
      'char-code-limit',
      'char-control-bit',
      'char-downcase',
      'char-equal',
      'char-font',
      'char-font-limit',
      'char-greaterp',
      'char-hyper-bit',
      'char-int',
      'char-lessp',
      'char-meta-bit',
      'char-name',
      'char-not-equal',
      'char-not-greaterp',
      'char-not-lessp',
      'char-super-bit',
      'char-upcase',
      'char/=',
      'char<',
      'char<=',
      'char=',
      'char>',
      'char>=',
      'character',
      'characterp',
      'check-type',
      'cis',
      'class',
      'class-name',
      'class-of',
      'clear-input',
      'clear-output',
      'close',
      'clrhash',
      'code-char',
      'coerce',
      'commonp',
      'compilation-speed',
      'compile',
      'compile-file',
      'compile-file-pathname',
      'compiled-function',
      'compiled-function-p',
      'compiler-let',
      'compiler-macro',
      'compiler-macro-function',
      'complement',
      'complex',
      'complexp',
      'compute-applicable-methods',
      'compute-restarts',
      'concatenate',
      'concatenated-stream',
      'concatenated-stream-streams',
      'cond',
      'condition',
      'conjugate',
      'cons',
      'consp',
      'constantly',
      'constantp',
      'continue',
      'control-error',
      'copy-alist',
      'copy-list',
      'copy-pprint-dispatch',
      'copy-readtable',
      'copy-seq',
      'copy-structure',
      'copy-symbol',
      'copy-tree',
      'cos',
      'cosh',
      'count',
      'count-if',
      'count-if-not',
      'ctypecase',
      'debug',
      'decf',
      'declaim',
      'declaration',
      'declare',
      'decode-float',
      'decode-universal-time',
      'delete',
      'delete-duplicates',
      'delete-file',
      'delete-if',
      'delete-if-not',
      'delete-package',
      'denominator',
      'deposit-field',
      'describe',
      'describe-object',
      'destructuring-bind',
      'digit-char',
      'digit-char-p',
      'directory',
      'directory-namestring',
      'disassemble',
      'division-by-zero',
      'do',
      'do*',
      'do-all-symbols',
      'do-exeternal-symbols',
      'do-external-symbols',
      'do-symbols',
      'documentation',
      'dolist',
      'dotimes',
      'double-float',
      'double-float-epsilon',
      'double-float-negative-epsilon',
      'dpb',
      'dribble',
      'dynamic-extent',
      'ecase',
      'echo-stream',
      'echo-stream-input-stream',
      'echo-stream-output-stream',
      'ed',
      'eighth',
      'elt',
      'encode-universal-time',
      'end-of-file',
      'endp',
      'enough-namestring',
      'ensure-directories-exist',
      'ensure-generic-function',
      'eq',
      'eql',
      'equal',
      'equalp',
      'error',
      'etypecase',
      'eval',
      'eval-when',
      'evalhook',
      'evenp',
      'every',
      'exp',
      'export',
      'expt',
      'extended-char',
      'fboundp',
      'fceiling',
      'fdefinition',
      'ffloor',
      'fifth',
      'file-author',
      'file-error',
      'file-error-pathname',
      'file-length',
      'file-namestring',
      'file-position',
      'file-stream',
      'file-string-length',
      'file-write-date',
      'fill',
      'fill-pointer',
      'find',
      'find-all-symbols',
      'find-class',
      'find-if',
      'find-if-not',
      'find-method',
      'find-package',
      'find-restart',
      'find-symbol',
      'finish-output',
      'first',
      'fixnum',
      'flet',
      'float',
      'float-digits',
      'float-precision',
      'float-radix',
      'float-sign',
      'floating-point-inexact',
      'floating-point-invalid-operation',
      'floating-point-overflow',
      'floating-point-underflow',
      'floatp',
      'floor',
      'fmakunbound',
      'force-output',
      'format',
      'formatter',
      'fourth',
      'fresh-line',
      'fround',
      'ftruncate',
      'ftype',
      'funcall',
      'function',
      'function-keywords',
      'function-lambda-expression',
      'functionp',
      'gbitp',
      'gcd',
      'generic-function',
      'gensym',
      'gentemp',
      'get',
      'get-decoded-time',
      'get-dispatch-macro-character',
      'get-internal-real-time',
      'get-internal-run-time',
      'get-macro-character',
      'get-output-stream-string',
      'get-properties',
      'get-setf-expansion',
      'get-setf-method',
      'get-universal-time',
      'getf',
      'gethash',
      'go',
      'graphic-char-p',
      'handler-bind',
      'handler-case',
      'hash-table',
      'hash-table-count',
      'hash-table-p',
      'hash-table-rehash-size',
      'hash-table-rehash-threshold',
      'hash-table-size',
      'hash-table-test',
      'host-namestring',
      'identity',
      'if',
      'if-exists',
      'ignorable',
      'ignore',
      'ignore-errors',
      'imagpart',
      'import',
      'in-package',
      'in-package',
      'incf',
      'initialize-instance',
      'inline',
      'input-stream-p',
      'inspect',
      'int-char',
      'integer',
      'integer-decode-float',
      'integer-length',
      'integerp',
      'interactive-stream-p',
      'intern',
      'internal-time-units-per-second',
      'intersection',
      'invalid-method-error',
      'invoke-debugger',
      'invoke-restart',
      'invoke-restart-interactively',
      'isqrt',
      'keyword',
      'keywordp',
      'labels',
      'lambda',
      'lambda-list-keywords',
      'lambda-parameters-limit',
      'last',
      'lcm',
      'ldb',
      'ldb-test',
      'ldiff',
      'least-negative-double-float',
      'least-negative-long-float',
      'least-negative-normalized-double-float',
      'least-negative-normalized-long-float',
      'least-negative-normalized-short-float',
      'least-negative-normalized-single-float',
      'least-negative-short-float',
      'least-negative-single-float',
      'least-positive-double-float',
      'least-positive-long-float',
      'least-positive-normalized-double-float',
      'least-positive-normalized-long-float',
      'least-positive-normalized-short-float',
      'least-positive-normalized-single-float',
      'least-positive-short-float',
      'least-positive-single-float',
      'length',
      'let',
      'let*',
      'lisp',
      'lisp-implementation-type',
      'lisp-implementation-version',
      'list',
      'list*',
      'list-all-packages',
      'list-length',
      'listen',
      'listp',
      'load',
      'load-logical-pathname-translations',
      'load-time-value',
      'locally',
      'log',
      'logand',
      'logandc1',
      'logandc2',
      'logbitp',
      'logcount',
      'logeqv',
      'logical-pathname',
      'logical-pathname-translations',
      'logior',
      'lognand',
      'lognor',
      'lognot',
      'logorc1',
      'logorc2',
      'logtest',
      'logxor',
      'long-float',
      'long-float-epsilon',
      'long-float-negative-epsilon',
      'long-site-name',
      'loop',
      'loop-finish',
      'lower-case-p',
      'machine-instance',
      'machine-type',
      'machine-version',
      'macro-function',
      'macroexpand',
      'macroexpand-1',
      'macroexpand-l',
      'macrolet',
      'make-array',
      'make-array',
      'make-broadcast-stream',
      'make-char',
      'make-concatenated-stream',
      'make-condition',
      'make-dispatch-macro-character',
      'make-echo-stream',
      'make-hash-table',
      'make-instance',
      'make-instances-obsolete',
      'make-list',
      'make-load-form',
      'make-load-form-saving-slots',
      'make-method',
      'make-package',
      'make-pathname',
      'make-random-state',
      'make-sequence',
      'make-string',
      'make-string-input-stream',
      'make-string-output-stream',
      'make-symbol',
      'make-synonym-stream',
      'make-two-way-stream',
      'makunbound',
      'map',
      'map-into',
      'mapc',
      'mapcan',
      'mapcar',
      'mapcon',
      'maphash',
      'mapl',
      'maplist',
      'mask-field',
      'max',
      'member',
      'member-if',
      'member-if-not',
      'merge',
      'merge-pathname',
      'merge-pathnames',
      'method',
      'method-combination',
      'method-combination-error',
      'method-qualifiers',
      'min',
      'minusp',
      'mismatch',
      'mod',
      'most-negative-double-float',
      'most-negative-fixnum',
      'most-negative-long-float',
      'most-negative-short-float',
      'most-negative-single-float',
      'most-positive-double-float',
      'most-positive-fixnum',
      'most-positive-long-float',
      'most-positive-short-float',
      'most-positive-single-float',
      'muffle-warning',
      'multiple-value-bind',
      'multiple-value-call',
      'multiple-value-list',
      'multiple-value-prog1',
      'multiple-value-seteq',
      'multiple-value-setq',
      'multiple-values-limit',
      'name-char',
      'namestring',
      'nbutlast',
      'nconc',
      'next-method-p',
      'nil',
      'nintersection',
      'ninth',
      'no-applicable-method',
      'no-next-method',
      'not',
      'notany',
      'notevery',
      'notinline',
      'nreconc',
      'nreverse',
      'nset-difference',
      'nset-exclusive-or',
      'nstring',
      'nstring-capitalize',
      'nstring-downcase',
      'nstring-upcase',
      'nsublis',
      'nsubst',
      'nsubst-if',
      'nsubst-if-not',
      'nsubstitute',
      'nsubstitute-if',
      'nsubstitute-if-not',
      'nth',
      'nth-value',
      'nthcdr',
      'null',
      'number',
      'numberp',
      'numerator',
      'nunion',
      'oddp',
      'open',
      'open-stream-p',
      'optimize',
      'or',
      'otherwise',
      'output-stream-p',
      'package',
      'package-error',
      'package-error-package',
      'package-name',
      'package-nicknames',
      'package-shadowing-symbols',
      'package-use-list',
      'package-used-by-list',
      'packagep',
      'pairlis',
      'parse-error',
      'parse-integer',
      'parse-namestring',
      'pathname',
      'pathname-device',
      'pathname-directory',
      'pathname-host',
      'pathname-match-p',
      'pathname-name',
      'pathname-type',
      'pathname-version',
      'pathnamep',
      'peek-char',
      'phase',
      'pi',
      'plusp',
      'pop',
      'position',
      'position-if',
      'position-if-not',
      'pprint',
      'pprint-dispatch',
      'pprint-exit-if-list-exhausted',
      'pprint-fill',
      'pprint-indent',
      'pprint-linear',
      'pprint-logical-block',
      'pprint-newline',
      'pprint-pop',
      'pprint-tab',
      'pprint-tabular',
      'prin1',
      'prin1-to-string',
      'princ',
      'princ-to-string',
      'print',
      'print-not-readable',
      'print-not-readable-object',
      'print-object',
      'print-unreadable-object',
      'probe-file',
      'proclaim',
      'prog',
      'prog*',
      'prog1',
      'prog2',
      'progn',
      'program-error',
      'progv',
      'provide',
      'psetf',
      'psetq',
      'push',
      'pushnew',
      'putprop',
      'quote',
      'random',
      'random-state',
      'random-state-p',
      'rassoc',
      'rassoc-if',
      'rassoc-if-not',
      'ratio',
      'rational',
      'rationalize',
      'rationalp',
      'read',
      'read-byte',
      'read-char',
      'read-char-no-hang',
      'read-delimited-list',
      'read-eval-print',
      'read-from-string',
      'read-line',
      'read-preserving-whitespace',
      'read-sequence',
      'reader-error',
      'readtable',
      'readtable-case',
      'readtablep',
      'real',
      'realp',
      'realpart',
      'reduce',
      'reinitialize-instance',
      'rem',
      'remf',
      'remhash',
      'remove',
      'remove-duplicates',
      'remove-if',
      'remove-if-not',
      'remove-method',
      'remprop',
      'rename-file',
      'rename-package',
      'replace',
      'require',
      'rest',
      'restart',
      'restart-bind',
      'restart-case',
      'restart-name',
      'return',
      'return-from',
      'revappend',
      'reverse',
      'room',
      'rotatef',
      'round',
      'row-major-aref',
      'rplaca',
      'rplacd',
      'safety',
      'satisfies',
      'sbit',
      'scale-float',
      'schar',
      'search',
      'second',
      'sequence',
      'serious-condition',
      'set',
      'set-char-bit',
      'set-difference',
      'set-dispatch-macro-character',
      'set-exclusive-or',
      'set-macro-character',
      'set-pprint-dispatch',
      'set-syntax-from-char',
      'setf',
      'setq',
      'seventh',
      'shadow',
      'shadowing-import',
      'shared-initialize',
      'shiftf',
      'short-float',
      'short-float-epsilon',
      'short-float-negative-epsilon',
      'short-site-name',
      'signal',
      'signed-byte',
      'signum',
      'simle-condition',
      'simple-array',
      'simple-base-string',
      'simple-bit-vector',
      'simple-bit-vector-p',
      'simple-condition-format-arguments',
      'simple-condition-format-control',
      'simple-error',
      'simple-string',
      'simple-string-p',
      'simple-type-error',
      'simple-vector',
      'simple-vector-p',
      'simple-warning',
      'sin',
      'single-flaot-epsilon',
      'single-float',
      'single-float-epsilon',
      'single-float-negative-epsilon',
      'sinh',
      'sixth',
      'sleep',
      'slot-boundp',
      'slot-exists-p',
      'slot-makunbound',
      'slot-missing',
      'slot-unbound',
      'slot-value',
      'software-type',
      'software-version',
      'some',
      'sort',
      'space',
      'special',
      'special-form-p',
      'special-operator-p',
      'speed',
      'sqrt',
      'stable-sort',
      'standard',
      'standard-char',
      'standard-char-p',
      'standard-class',
      'standard-generic-function',
      'standard-method',
      'standard-object',
      'step',
      'storage-condition',
      'store-value',
      'stream',
      'stream-element-type',
      'stream-error',
      'stream-error-stream',
      'stream-external-format',
      'streamp',
      'streamup',
      'string',
      'string-capitalize',
      'string-char',
      'string-char-p',
      'string-downcase',
      'string-equal',
      'string-greaterp',
      'string-left-trim',
      'string-lessp',
      'string-not-equal',
      'string-not-greaterp',
      'string-not-lessp',
      'string-right-strim',
      'string-right-trim',
      'string-stream',
      'string-trim',
      'string-upcase',
      'string/=',
      'string<',
      'string<=',
      'string=',
      'string>',
      'string>=',
      'stringp',
      'structure',
      'structure-class',
      'structure-object',
      'style-warning',
      'sublim',
      'sublis',
      'subseq',
      'subsetp',
      'subst',
      'subst-if',
      'subst-if-not',
      'substitute',
      'substitute-if',
      'substitute-if-not',
      'subtypep',
      'svref',
      'sxhash',
      'symbol',
      'symbol-function',
      'symbol-macrolet',
      'symbol-name',
      'symbol-package',
      'symbol-plist',
      'symbol-value',
      'symbolp',
      'synonym-stream',
      'synonym-stream-symbol',
      'sys',
      'system',
      't',
      'tagbody',
      'tailp',
      'tan',
      'tanh',
      'tenth',
      'terpri',
      'the',
      'third',
      'throw',
      'time',
      'trace',
      'translate-logical-pathname',
      'translate-pathname',
      'tree-equal',
      'truename',
      'truncase',
      'truncate',
      'two-way-stream',
      'two-way-stream-input-stream',
      'two-way-stream-output-stream',
      'type',
      'type-error',
      'type-error-datum',
      'type-error-expected-type',
      'type-of',
      'typecase',
      'typep',
      'unbound-slot',
      'unbound-slot-instance',
      'unbound-variable',
      'undefined-function',
      'unexport',
      'unintern',
      'union',
      'unless',
      'unread',
      'unread-char',
      'unsigned-byte',
      'untrace',
      'unuse-package',
      'unwind-protect',
      'update-instance-for-different-class',
      'update-instance-for-redefined-class',
      'upgraded-array-element-type',
      'upgraded-complex-part-type',
      'upper-case-p',
      'use-package',
      'use-value',
      'user',
      'user-homedir-pathname',
      'values',
      'values-list',
      'vector',
      'vector-pop',
      'vector-push',
      'vector-push-extend',
      'vectorp',
      'warn',
      'warning',
      'when',
      'wild-pathname-p',
      'with-accessors',
      'with-compilation-unit',
      'with-condition-restarts',
      'with-hash-table-iterator',
      'with-input-from-string',
      'with-open-file',
      'with-open-stream',
      'with-output-to-string',
      'with-package-iterator',
      'with-simple-restart',
      'with-slots',
      'with-standard-io-syntax',
      'write',
      'write-byte',
      'write-char',
      'write-line',
      'write-sequence',
      'write-string',
      'write-to-string',
      'y-or-n-p',
      'yes-or-no-p',
      'zerop',
   );
   $self->listAdd('modifiers',
      ':abort',
      ':adjustable',
      ':append',
      ':array',
      ':base',
      ':case',
      ':circle',
      ':conc-name',
      ':constructor',
      ':copier',
      ':count',
      ':create',
      ':default',
      ':defaults',
      ':device',
      ':direction',
      ':directory',
      ':displaced-index-offset',
      ':displaced-to',
      ':element-type',
      ':end',
      ':end1',
      ':end2',
      ':error',
      ':escape',
      ':external',
      ':from-end',
      ':gensym',
      ':host',
      ':if-does-not-exist:pretty',
      ':if-exists:print',
      ':include:print-function',
      ':index',
      ':inherited',
      ':initial-contents',
      ':initial-element',
      ':initial-offset',
      ':initial-value',
      ':input',
      ':internal:size',
      ':io',
      ':junk-allowed',
      ':key',
      ':length',
      ':level',
      ':name',
      ':named',
      ':new-version',
      ':nicknames',
      ':output',
      ':output-file',
      ':overwrite',
      ':predicate',
      ':preserve-whitespace',
      ':probe',
      ':radix',
      ':read-only',
      ':rehash-size',
      ':rehash-threshold',
      ':rename',
      ':rename-and-delete',
      ':start',
      ':start1',
      ':start2',
      ':stream',
      ':supersede',
      ':test',
      ':test-not',
      ':type',
      ':use',
      ':verbose',
      ':version',
   );
   $self->listAdd('symbols',
      '*',
      '**',
      '***',
      '+',
      '++',
      '+++',
      '-',
      '/',
      '//',
      '///',
      '/=',
      '1+',
      '1-',
      '<',
      '<=',
      '=',
      '=>',
      '>',
      '>=',
   );
   $self->listAdd('variables',
      '*applyhook*',
      '*break-on-signals*',
      '*break-on-signals*',
      '*break-on-warnings*',
      '*compile-file-pathname*',
      '*compile-file-pathname*',
      '*compile-file-truename*',
      '*compile-file-truename*',
      '*compile-print*',
      '*compile-verbose*',
      '*compile-verbose*',
      '*debug-io*',
      '*debugger-hook*',
      '*default-pathname-defaults*',
      '*error-output*',
      '*evalhook*',
      '*features*',
      '*gensym-counter*',
      '*load-pathname*',
      '*load-print*',
      '*load-truename*',
      '*load-verbose*',
      '*macroexpand-hook*',
      '*modules*',
      '*package*',
      '*print-array*',
      '*print-base*',
      '*print-case*',
      '*print-circle*',
      '*print-escape*',
      '*print-gensym*',
      '*print-length*',
      '*print-level*',
      '*print-lines*',
      '*print-miser-width*',
      '*print-miser-width*',
      '*print-pprint-dispatch*',
      '*print-pprint-dispatch*',
      '*print-pretty*',
      '*print-radix*',
      '*print-readably*',
      '*print-right-margin*',
      '*print-right-margin*',
      '*query-io*',
      '*random-state*',
      '*read-base*',
      '*read-default-float-format*',
      '*read-eval*',
      '*read-suppress*',
      '*readtable*',
      '*standard-input*',
      '*standard-output*',
      '*terminal-io*',
      '*trace-output*',
   );
   $self->contextdata({
      'MultiLineComment' => {
         callback => \&parseMultiLineComment,
         attribute => 'Comment',
      },
      'Normal' => {
         callback => \&parseNormal,
         attribute => 'Normal',
      },
      'SpecialNumber' => {
         callback => \&parseSpecialNumber,
         attribute => 'Normal',
         lineending => '#pop',
      },
      'String' => {
         callback => \&parseString,
         attribute => 'String',
      },
      'function_decl' => {
         callback => \&parsefunction_decl,
         attribute => 'Function',
      },
   });
   $self->deliminators('\\s||\\.|\\(|\\)|,|\\%|\\&|;|\\[|\\]|\\^|\\{|\\||\\}|\\~|-|\\+|\\*|\\?|\\!|<|>|=|\\/|:|#|\\\\');
   $self->basecontext('Normal');
   $self->keywordscase(0);
   $self->initialize;
   bless ($self, $class);
   return $self;
}

sub language {
   return 'Common Lisp';
}

sub parseMultiLineComment {
   my ($self, $text) = @_;
   # attribute => 'Comment'
   # char => '|'
   # char1 => '#'
   # context => '#pop'
   # endRegion => 'region'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '|', '#', 0, 0, 0, undef, 0, '#pop', 'Comment')) {
      return 1
   }
   return 0;
};

sub parseNormal {
   my ($self, $text) = @_;
   # String => ';+\s*BEGIN.*$'
   # attribute => 'Region Marker'
   # beginRegion => 'region'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';+\\s*BEGIN.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => ';+\s*END.*$'
   # attribute => 'Region Marker'
   # context => '#stay'
   # endRegion => 'region'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';+\\s*END.*$', 0, 0, 0, undef, 0, '#stay', 'Region Marker')) {
      return 1
   }
   # String => ';.*$'
   # attribute => 'Comment'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, ';.*$', 0, 0, 0, undef, 0, '#stay', 'Comment')) {
      return 1
   }
   # attribute => 'Comment'
   # beginRegion => 'region'
   # char => '#'
   # char1 => '|'
   # context => 'MultiLineComment'
   # type => 'Detect2Chars'
   if ($self->testDetect2Chars($text, '#', '|', 0, 0, 0, undef, 0, 'MultiLineComment', 'Comment')) {
      return 1
   }
   # attribute => 'Brackets'
   # char => '('
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '(', 0, 0, 0, undef, 0, '#stay', 'Brackets')) {
      return 1
   }
   # attribute => 'Brackets'
   # char => ')'
   # context => '#stay'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, ')', 0, 0, 0, undef, 0, '#stay', 'Brackets')) {
      return 1
   }
   # String => 'keywords'
   # attribute => 'Keyword'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'keywords', 0, undef, 0, '#stay', 'Keyword')) {
      return 1
   }
   # String => 'symbols'
   # attribute => 'Operator'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'symbols', 0, undef, 0, '#stay', 'Operator')) {
      return 1
   }
   # String => 'modifiers'
   # attribute => 'Modifier'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'modifiers', 0, undef, 0, '#stay', 'Modifier')) {
      return 1
   }
   # String => 'variables'
   # attribute => 'Variable'
   # context => '#stay'
   # type => 'keyword'
   if ($self->testKeyword($text, 'variables', 0, undef, 0, '#stay', 'Variable')) {
      return 1
   }
   # String => 'definitions'
   # attribute => 'Definition'
   # context => 'function_decl'
   # type => 'keyword'
   if ($self->testKeyword($text, 'definitions', 0, undef, 0, 'function_decl', 'Definition')) {
      return 1
   }
   # String => '#\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => 'String'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, 'String', 'String')) {
      return 1
   }
   # String => '#[bodxei]'
   # attribute => 'Char'
   # context => 'SpecialNumber'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#[bodxei]', 0, 0, 0, undef, 0, 'SpecialNumber', 'Char')) {
      return 1
   }
   # String => '#[tf]'
   # attribute => 'Decimal'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#[tf]', 0, 0, 0, undef, 0, '#stay', 'Decimal')) {
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
   return 0;
};

sub parseSpecialNumber {
   my ($self, $text) = @_;
   # attribute => 'Float'
   # context => '#pop'
   # type => 'Float'
   if ($self->testFloat($text, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   # attribute => 'Decimal'
   # context => '#pop'
   # type => 'Int'
   if ($self->testInt($text, 0, undef, 0, '#pop', 'Decimal')) {
      return 1
   }
   # attribute => 'BaseN'
   # context => '#pop'
   # type => 'HlCOct'
   if ($self->testHlCOct($text, 0, undef, 0, '#pop', 'BaseN')) {
      return 1
   }
   # attribute => 'Float'
   # context => '#pop'
   # type => 'HlCHex'
   if ($self->testHlCHex($text, 0, undef, 0, '#pop', 'Float')) {
      return 1
   }
   return 0;
};

sub parseString {
   my ($self, $text) = @_;
   # String => '#\\.'
   # attribute => 'Char'
   # context => '#stay'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '#\\\\.', 0, 0, 0, undef, 0, '#stay', 'Char')) {
      return 1
   }
   # attribute => 'String'
   # char => '"'
   # context => '#pop'
   # type => 'DetectChar'
   if ($self->testDetectChar($text, '"', 0, 0, 0, undef, 0, '#pop', 'String')) {
      return 1
   }
   return 0;
};

sub parsefunction_decl {
   my ($self, $text) = @_;
   # String => '\s*[A-Za-z0-9-+\<\>//\*]*\s*'
   # attribute => 'Function'
   # context => '#pop'
   # type => 'RegExpr'
   if ($self->testRegExpr($text, '\\s*[A-Za-z0-9-+\\<\\>//\\*]*\\s*', 0, 0, 0, undef, 0, '#pop', 'Function')) {
      return 1
   }
   return 0;
};


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate::Common_Lisp - a Plugin for Common Lisp syntax highlighting

=head1 SYNOPSIS

 require Syntax::Highlight::Engine::Kate::Common_Lisp;
 my $sh = new Syntax::Highlight::Engine::Kate::Common_Lisp([
 ]);

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate::Common_Lisp is a  plugin module that provides syntax highlighting
for Common Lisp to the Syntax::Haghlight::Engine::Kate highlighting engine.

This code is generated from the syntax definition files used
by the Kate project.
It works quite fine, but can use refinement and optimization.

It inherits Syntax::Higlight::Engine::Kate::Template. See also there.

=head1 AUTHOR

Hans Jeuken (haje <at> toneel <dot> demon <dot> nl)

=head1 BUGS

Unknown. If you find any, please contact the author