
# Copyright (c) 2006 Hans Jeuken. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.

package Syntax::Highlight::Engine::Kate;

use 5.006;
our $VERSION = '0.08';
use strict;
use warnings;
use Carp;
use Data::Dumper;
use File::Basename;

use base('Syntax::Highlight::Engine::Kate::Template');

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;
	my %args = (@_);
	
	my $add = delete $args{'plugins'};
	unless (defined($add)) { $add = [] };
	my $language = delete $args{'language'};
	unless (defined($language)) { $language = 'Off' };
	
	my $self = $class->SUPER::new(%args);

	$self->{'plugins'} = {};
	#begin autoinsert
	$self->{'extensions'} = {
		' *.cls' => ['LaTeX', ],
		' *.dtx' => ['LaTeX', ],
		' *.ltx' => ['LaTeX', ],
		' *.sty' => ['LaTeX', ],
		'*.4GL' => ['4GL', ],
		'*.4gl' => ['4GL', ],
		'*.ABC' => ['ABC', ],
		'*.ASM' => ['AVR Assembler', 'PicAsm', ],
		'*.BAS' => ['FreeBASIC', ],
		'*.BI' => ['FreeBASIC', ],
		'*.C' => ['C++', 'C', 'ANSI C89', ],
		'*.D' => ['D', ],
		'*.F' => ['Fortran', ],
		'*.F90' => ['Fortran', ],
		'*.F95' => ['Fortran', ],
		'*.FOR' => ['Fortran', ],
		'*.FPP' => ['Fortran', ],
		'*.GDL' => ['GDL', ],
		'*.H' => ['C++', ],
		'*.JSP' => ['JSP', ],
		'*.LOGO' => ['de_DE', 'en_US', 'nl', ],
		'*.LY' => ['LilyPond', ],
		'*.Logo' => ['de_DE', 'en_US', 'nl', ],
		'*.M' => ['Matlab', 'Octave', ],
		'*.MAB' => ['MAB-DB', ],
		'*.Mab' => ['MAB-DB', ],
		'*.PER' => ['4GL-PER', ],
		'*.PIC' => ['PicAsm', ],
		'*.PRG' => ['xHarbour', 'Clipper', ],
		'*.R' => ['R Script', ],
		'*.S' => ['GNU Assembler', ],
		'*.SQL' => ['SQL', 'SQL (MySQL)', 'SQL (PostgreSQL)', ],
		'*.SRC' => ['PicAsm', ],
		'*.V' => ['Verilog', ],
		'*.VCG' => ['GDL', ],
		'*.a' => ['Ada', ],
		'*.abc' => ['ABC', ],
		'*.ada' => ['Ada', ],
		'*.adb' => ['Ada', ],
		'*.ado' => ['Stata', ],
		'*.ads' => ['Ada', ],
		'*.ahdl' => ['AHDL', ],
		'*.ai' => ['PostScript', ],
		'*.ans' => ['Ansys', ],
		'*.asm' => ['AVR Assembler', 'Asm6502', 'Intel x86 (NASM)', 'PicAsm', ],
		'*.asm-avr' => ['AVR Assembler', ],
		'*.asp' => ['ASP', ],
		'*.awk' => ['AWK', ],
		'*.bas' => ['FreeBASIC', ],
		'*.basetest' => ['BaseTest', ],
		'*.bash' => ['Bash', ],
		'*.bi' => ['FreeBASIC', ],
		'*.bib' => ['BibTeX', ],
		'*.bro' => ['Component-Pascal', ],
		'*.c' => ['C', 'ANSI C89', 'LPC', ],
		'*.c++' => ['C++', ],
		'*.cc' => ['C++', ],
		'*.cfc' => ['ColdFusion', ],
		'*.cfg' => ['Quake Script', ],
		'*.cfm' => ['ColdFusion', ],
		'*.cfml' => ['ColdFusion', ],
		'*.cg' => ['Cg', ],
		'*.cgis' => ['CGiS', ],
		'*.ch' => ['xHarbour', 'Clipper', ],
		'*.cis' => ['Cisco', ],
		'*.cl' => ['Common Lisp', ],
		'*.cmake' => ['CMake', ],
		'*.config' => ['Logtalk', ],
		'*.cp' => ['Component-Pascal', ],
		'*.cpp' => ['C++', ],
		'*.cs' => ['C#', ],
		'*.css' => ['CSS', ],
		'*.cue' => ['CUE Sheet', ],
		'*.cxx' => ['C++', ],
		'*.d' => ['D', ],
		'*.daml' => ['XML', ],
		'*.dbm' => ['ColdFusion', ],
		'*.def' => ['Modula-2', ],
		'*.desktop' => ['.desktop', ],
		'*.diff' => ['Diff', ],
		'*.do' => ['Stata', ],
		'*.docbook' => ['XML', ],
		'*.dox' => ['Doxygen', ],
		'*.doxygen' => ['Doxygen', ],
		'*.e' => ['E Language', 'Eiffel', 'Euphoria', ],
		'*.ebuild' => ['Bash', ],
		'*.eclass' => ['Bash', ],
		'*.eml' => ['Email', ],
		'*.eps' => ['PostScript', ],
		'*.err' => ['4GL', ],
		'*.ex' => ['Euphoria', ],
		'*.exu' => ['Euphoria', ],
		'*.exw' => ['Euphoria', ],
		'*.f' => ['Fortran', ],
		'*.f90' => ['Fortran', ],
		'*.f95' => ['Fortran', ],
		'*.fe' => ['ferite', ],
		'*.feh' => ['ferite', ],
		'*.flex' => ['Lex/Flex', ],
		'*.for' => ['Fortran', ],
		'*.fpp' => ['Fortran', ],
		'*.frag' => ['GLSL', ],
		'*.gdl' => ['GDL', ],
		'*.glsl' => ['GLSL', ],
		'*.guile' => ['Scheme', ],
		'*.h' => ['C++', 'C', 'ANSI C89', 'Inform', 'LPC', 'Objective-C', ],
		'*.h++' => ['C++', ],
		'*.hcc' => ['C++', ],
		'*.hpp' => ['C++', ],
		'*.hs' => ['Haskell', ],
		'*.hsp' => ['Spice', ],
		'*.ht' => ['Apache Configuration', ],
		'*.htm' => ['HTML', ],
		'*.html' => ['HTML', 'Mason', ],
		'*.hxx' => ['C++', ],
		'*.i' => ['progress', ],
		'*.idl' => ['IDL', ],
		'*.inc' => ['POV-Ray', 'PHP (HTML)', 'LPC', ],
		'*.inf' => ['Inform', ],
		'*.ini' => ['INI Files', ],
		'*.java' => ['Java', ],
		'*.js' => ['JavaScript', ],
		'*.jsp' => ['JSP', ],
		'*.katetemplate' => ['Kate File Template', ],
		'*.kbasic' => ['KBasic', ],
		'*.kdelnk' => ['.desktop', ],
		'*.l' => ['Lex/Flex', ],
		'*.ldif' => ['LDIF', ],
		'*.lex' => ['Lex/Flex', ],
		'*.lgo' => ['de_DE', 'en_US', 'nl', ],
		'*.lgt' => ['Logtalk', ],
		'*.lhs' => ['Literate Haskell', ],
		'*.lisp' => ['Common Lisp', ],
		'*.logo' => ['de_DE', 'en_US', 'nl', ],
		'*.lsp' => ['Common Lisp', ],
		'*.lua' => ['Lua', ],
		'*.ly' => ['LilyPond', ],
		'*.m' => ['Matlab', 'Objective-C', 'Octave', ],
		'*.m3u' => ['M3U', ],
		'*.mab' => ['MAB-DB', ],
		'*.md' => ['Modula-2', ],
		'*.mi' => ['Modula-2', ],
		'*.ml' => ['Objective Caml', 'SML', ],
		'*.mli' => ['Objective Caml', ],
		'*.moc' => ['C++', ],
		'*.mod' => ['Modula-2', ],
		'*.mup' => ['Music Publisher', ],
		'*.not' => ['Music Publisher', ],
		'*.o' => ['LPC', ],
		'*.octave' => ['Octave', ],
		'*.p' => ['Pascal', 'progress', ],
		'*.pas' => ['Pascal', ],
		'*.pb' => ['PureBasic', ],
		'*.per' => ['4GL-PER', ],
		'*.per.err' => ['4GL-PER', ],
		'*.php' => ['PHP (HTML)', ],
		'*.php3' => ['PHP (HTML)', ],
		'*.phtm' => ['PHP (HTML)', ],
		'*.phtml' => ['PHP (HTML)', ],
		'*.pic' => ['PicAsm', ],
		'*.pike' => ['Pike', ],
		'*.pl' => ['Perl', ],
		'*.pls' => ['INI Files', ],
		'*.pm' => ['Perl', ],
		'*.po' => ['GNU Gettext', ],
		'*.pot' => ['GNU Gettext', ],
		'*.pov' => ['POV-Ray', ],
		'*.pp' => ['Pascal', ],
		'*.prg' => ['xHarbour', 'Clipper', ],
		'*.pro' => ['RSI IDL', ],
		'*.prolog' => ['Prolog', ],
		'*.ps' => ['PostScript', ],
		'*.py' => ['Python', ],
		'*.pyw' => ['Python', ],
		'*.rb' => ['Ruby', ],
		'*.rc' => ['XML', ],
		'*.rdf' => ['XML', ],
		'*.reg' => ['WINE Config', ],
		'*.rex' => ['REXX', ],
		'*.rib' => ['RenderMan RIB', ],
		'*.s' => ['GNU Assembler', 'MIPS Assembler', ],
		'*.sa' => ['Sather', ],
		'*.sce' => ['scilab', ],
		'*.scheme' => ['Scheme', ],
		'*.sci' => ['scilab', ],
		'*.scm' => ['Scheme', ],
		'*.sgml' => ['SGML', ],
		'*.sh' => ['Bash', ],
		'*.shtm' => ['HTML', ],
		'*.shtml' => ['HTML', ],
		'*.siv' => ['Sieve', ],
		'*.sml' => ['SML', ],
		'*.sp' => ['Spice', ],
		'*.spec' => ['RPM Spec', ],
		'*.sql' => ['SQL', 'SQL (MySQL)', 'SQL (PostgreSQL)', ],
		'*.src' => ['PicAsm', ],
		'*.ss' => ['Scheme', ],
		'*.t2t' => ['txt2tags', ],
		'*.tcl' => ['Tcl/Tk', ],
		'*.tdf' => ['AHDL', ],
		'*.tex' => ['LaTeX', ],
		'*.tji' => ['TaskJuggler', ],
		'*.tjp' => ['TaskJuggler', ],
		'*.tk' => ['Tcl/Tk', ],
		'*.tst' => ['BaseTestchild', ],
		'*.uc' => ['UnrealScript', ],
		'*.v' => ['Verilog', ],
		'*.vcg' => ['GDL', ],
		'*.vert' => ['GLSL', ],
		'*.vhd' => ['VHDL', ],
		'*.vhdl' => ['VHDL', ],
		'*.vl' => ['Verilog', ],
		'*.vm' => ['Velocity', ],
		'*.w' => ['progress', ],
		'*.wml' => ['PHP (HTML)', ],
		'*.wrl' => ['VRML', ],
		'*.xml' => ['XML', ],
		'*.xsl' => ['xslt', ],
		'*.xslt' => ['xslt', ],
		'*.y' => ['Yacc/Bison', ],
		'*.ys' => ['yacas', ],
		'*Makefile*' => ['Makefile', ],
		'*makefile*' => ['Makefile', ],
		'*patch' => ['Diff', ],
		'CMakeLists.txt' => ['CMake', ],
		'ChangeLog' => ['ChangeLog', ],
		'QRPGLESRC.*' => ['ILERPG', ],
		'apache.conf' => ['Apache Configuration', ],
		'apache2.conf' => ['Apache Configuration', ],
		'httpd.conf' => ['Apache Configuration', ],
		'httpd2.conf' => ['Apache Configuration', ],
		'xorg.conf' => ['x.org Configuration', ],
	};
	$self->{'sections'} = {
		'Assembler' => [
			'AVR Assembler',
			'Asm6502',
			'GNU Assembler',
			'Intel x86 (NASM)',
			'MIPS Assembler',
			'PicAsm',
		],
		'Configuration' => [
			'.desktop',
			'Apache Configuration',
			'Cisco',
			'INI Files',
			'WINE Config',
			'x.org Configuration',
		],
		'Database' => [
			'4GL',
			'4GL-PER',
			'LDIF',
			'SQL',
			'SQL (MySQL)',
			'SQL (PostgreSQL)',
			'progress',
		],
		'Hardware' => [
			'AHDL',
			'Spice',
			'VHDL',
			'Verilog',
		],
		'Logo' => [
			'de_DE',
			'en_US',
			'nl',
		],
		'Markup' => [
			'ASP',
			'BibTeX',
			'CSS',
			'ColdFusion',
			'Doxygen',
			'GNU Gettext',
			'HTML',
			'JSP',
			'Javadoc',
			'Kate File Template',
			'LaTeX',
			'MAB-DB',
			'PostScript',
			'SGML',
			'VRML',
			'Wikimedia',
			'XML',
			'txt2tags',
			'xslt',
		],
		'Other' => [
			'ABC',
			'Alerts',
			'CMake',
			'CSS/PHP',
			'CUE Sheet',
			'ChangeLog',
			'Debian Changelog',
			'Debian Control',
			'Diff',
			'Email',
			'JavaScript/PHP',
			'LilyPond',
			'M3U',
			'Makefile',
			'Music Publisher',
			'POV-Ray',
			'RPM Spec',
			'RenderMan RIB',
		],
		'Scientific' => [
			'GDL',
			'Matlab',
			'Octave',
			'TI Basic',
			'scilab',
		],
		'Script' => [
			'Ansys',
		],
		'Scripts' => [
			'AWK',
			'Bash',
			'Common Lisp',
			'Euphoria',
			'JavaScript',
			'Lua',
			'Mason',
			'PHP (HTML)',
			'PHP/PHP',
			'Perl',
			'Pike',
			'Python',
			'Quake Script',
			'R Script',
			'REXX',
			'Ruby',
			'Scheme',
			'Sieve',
			'TaskJuggler',
			'Tcl/Tk',
			'UnrealScript',
			'Velocity',
			'ferite',
		],
		'Sources' => [
			'ANSI C89',
			'Ada',
			'C',
			'C#',
			'C++',
			'CGiS',
			'Cg',
			'Clipper',
			'Component-Pascal',
			'D',
			'E Language',
			'Eiffel',
			'Fortran',
			'FreeBASIC',
			'GLSL',
			'Haskell',
			'IDL',
			'ILERPG',
			'Inform',
			'Java',
			'KBasic',
			'LPC',
			'Lex/Flex',
			'Literate Haskell',
			'Logtalk',
			'Modula-2',
			'Objective Caml',
			'Objective-C',
			'Pascal',
			'Prolog',
			'PureBasic',
			'RSI IDL',
			'SML',
			'Sather',
			'Stata',
			'Yacc/Bison',
			'xHarbour',
			'yacas',
		],
		'Test' => [
			'BaseTest',
			'BaseTestchild',
		],
	};
	$self->{'syntaxes'} = {
		'.desktop' => 'Desktop',
		'4GL' => 'FourGL',
		'4GL-PER' => 'FourGLminusPER',
		'ABC' => 'ABC',
		'AHDL' => 'AHDL',
		'ANSI C89' => 'ANSI_C89',
		'ASP' => 'ASP',
		'AVR Assembler' => 'AVR_Assembler',
		'AWK' => 'AWK',
		'Ada' => 'Ada',
		'Alerts' => 'Alerts',
		'Ansys' => 'Ansys',
		'Apache Configuration' => 'Apache_Configuration',
		'Asm6502' => 'Asm6502',
		'BaseTest' => 'BaseTest',
		'BaseTestchild' => 'BaseTestchild',
		'Bash' => 'Bash',
		'BibTeX' => 'BibTeX',
		'C' => 'C',
		'C#' => 'Cdash',
		'C++' => 'Cplusplus',
		'CGiS' => 'CGiS',
		'CMake' => 'CMake',
		'CSS' => 'CSS',
		'CSS/PHP' => 'CSS_PHP',
		'CUE Sheet' => 'CUE_Sheet',
		'Cg' => 'Cg',
		'ChangeLog' => 'ChangeLog',
		'Cisco' => 'Cisco',
		'Clipper' => 'Clipper',
		'ColdFusion' => 'ColdFusion',
		'Common Lisp' => 'Common_Lisp',
		'Component-Pascal' => 'ComponentminusPascal',
		'D' => 'D',
		'Debian Changelog' => 'Debian_Changelog',
		'Debian Control' => 'Debian_Control',
		'Diff' => 'Diff',
		'Doxygen' => 'Doxygen',
		'E Language' => 'E_Language',
		'Eiffel' => 'Eiffel',
		'Email' => 'Email',
		'Euphoria' => 'Euphoria',
		'Fortran' => 'Fortran',
		'FreeBASIC' => 'FreeBASIC',
		'GDL' => 'GDL',
		'GLSL' => 'GLSL',
		'GNU Assembler' => 'GNU_Assembler',
		'GNU Gettext' => 'GNU_Gettext',
		'HTML' => 'HTML',
		'Haskell' => 'Haskell',
		'IDL' => 'IDL',
		'ILERPG' => 'ILERPG',
		'INI Files' => 'INI_Files',
		'Inform' => 'Inform',
		'Intel x86 (NASM)' => 'Intel_x86_NASM',
		'JSP' => 'JSP',
		'Java' => 'Java',
		'JavaScript' => 'JavaScript',
		'JavaScript/PHP' => 'JavaScript_PHP',
		'Javadoc' => 'Javadoc',
		'KBasic' => 'KBasic',
		'Kate File Template' => 'Kate_File_Template',
		'LDIF' => 'LDIF',
		'LPC' => 'LPC',
		'LaTeX' => 'LaTeX',
		'Lex/Flex' => 'Lex_Flex',
		'LilyPond' => 'LilyPond',
		'Literate Haskell' => 'Literate_Haskell',
		'Logtalk' => 'Logtalk',
		'Lua' => 'Lua',
		'M3U' => 'M3U',
		'MAB-DB' => 'MABminusDB',
		'MIPS Assembler' => 'MIPS_Assembler',
		'Makefile' => 'Makefile',
		'Mason' => 'Mason',
		'Matlab' => 'Matlab',
		'Modula-2' => 'Modulaminus2',
		'Music Publisher' => 'Music_Publisher',
		'Objective Caml' => 'Objective_Caml',
		'Objective-C' => 'ObjectiveminusC',
		'Octave' => 'Octave',
		'PHP (HTML)' => 'PHP_HTML',
		'PHP/PHP' => 'PHP_PHP',
		'POV-Ray' => 'POVminusRay',
		'Pascal' => 'Pascal',
		'Perl' => 'Perl',
		'PicAsm' => 'PicAsm',
		'Pike' => 'Pike',
		'PostScript' => 'PostScript',
		'Prolog' => 'Prolog',
		'PureBasic' => 'PureBasic',
		'Python' => 'Python',
		'Quake Script' => 'Quake_Script',
		'R Script' => 'R_Script',
		'REXX' => 'REXX',
		'RPM Spec' => 'RPM_Spec',
		'RSI IDL' => 'RSI_IDL',
		'RenderMan RIB' => 'RenderMan_RIB',
		'Ruby' => 'Ruby',
		'SGML' => 'SGML',
		'SML' => 'SML',
		'SQL' => 'SQL',
		'SQL (MySQL)' => 'SQL_MySQL',
		'SQL (PostgreSQL)' => 'SQL_PostgreSQL',
		'Sather' => 'Sather',
		'Scheme' => 'Scheme',
		'Sieve' => 'Sieve',
		'Spice' => 'Spice',
		'Stata' => 'Stata',
		'TI Basic' => 'TI_Basic',
		'TaskJuggler' => 'TaskJuggler',
		'Tcl/Tk' => 'Tcl_Tk',
		'UnrealScript' => 'UnrealScript',
		'VHDL' => 'VHDL',
		'VRML' => 'VRML',
		'Velocity' => 'Velocity',
		'Verilog' => 'Verilog',
		'WINE Config' => 'WINE_Config',
		'Wikimedia' => 'Wikimedia',
		'XML' => 'XML',
		'Yacc/Bison' => 'Yacc_Bison',
		'de_DE' => 'De_DE',
		'en_US' => 'En_US',
		'ferite' => 'Ferite',
		'nl' => 'Nl',
		'progress' => 'Progress',
		'scilab' => 'Scilab',
		'txt2tags' => 'Txt2tags',
		'x.org Configuration' => 'Xorg_Configuration',
		'xHarbour' => 'XHarbour',
		'xslt' => 'Xslt',
		'yacas' => 'Yacas',
	};
	#end autoinsert
	$self->{'language '} = '';
	bless ($self, $class);
	if ($language ne '') {
		$self->language($language);
	}
	return $self;
}

sub extensions {
	my $self = shift;
	return $self->{'extensions'};
}

#overriding Template's initialize method. now it should not do anything.
sub initialize {
	my $cw = shift;
}

sub language {
	my $self = shift;
	if (@_) {
		$self->{'language'} = shift;
		$self->reset;
	}
	return $self->{'language'};
}

sub languageAutoSet {
	my ($self, $file) = @_;
	my $lang = $self->languagePropose($file);
	if (defined $lang) {
		$self->language($lang)
	} else {
		$self->language('Off')
	}
}

sub languageList {
	my $self = shift;
	my $l = $self->{'syntaxes'};
	return sort {uc($a) cmp uc($b)} keys %$l;
}

sub languagePropose {
	my ($self, $file) = @_;
	my $hsh = $self->extensions;
	foreach my $key (keys %$hsh) {
		my $reg = $key;
		$reg =~ s/\./\\./g;
		$reg =~ s/\+/\\+/g;
		$reg =~ s/\*/.*/g;
		$reg = "$reg\$";
		if ($file =~ /$reg/) {
			return $hsh->{$key}->[0]
		}
	}
	return undef;
}

sub languagePlug {
	my ($self, $req) = @_;
	unless (exists($self->{'syntaxes'}->{$req})) {
		warn "undefined language: $req";
		return undef;
	}
	return $self->{'syntaxes'}->{$req};
}

sub reset {
	my $self = shift;
	my $lang = $self->language;
	if ($lang eq 'Off') {
		$self->stack([]);
	} else {
		my $plug	= $self->pluginGet($lang);
		my $basecontext = $plug->basecontext;
		$self->stack([
			[$plug, $basecontext]
		]);
	}
	$self->out([]);
	$self->snippet('');
}

sub sections {
	my $self = shift;
	return $self->{'sections'};
}

sub syntaxes {
	my $self = shift;
	return $self->{'syntaxes'}
}


1;

__END__

=head1 NAME

Syntax::Highlight::Engine::Kate - a port to Perl of the syntax highlight engine of the Kate texteditor.

=head1 SYNOPSIS

 #if you want to create a compiled executable, you may want to do this:
 use Syntax::Highlight::Engine::Kate::All;
 
 use Syntax::Highlight::Engine::Kate;
 my $hl = new Syntax::Highlight::Engine::Kate(
    language => 'Perl',
    substitutions => {
       "<" => "&lt;",
       ">" => "&gt;",
       "&" => "&amp;",
       " " => "&nbsp;",
       "\t" => "&nbsp;&nbsp;&nbsp;",
       "\n" => "<BR>\n",
    },
    format_table => {
       Alert => ["<font color=\"#0000ff\">", "</font>"],
       BaseN => ["<font color=\"#007f00\">", "</font>"],
       BString => ["<font color=\"#c9a7ff\">", "</font>"],
       Char => ["<font color=\"#ff00ff\">", "</font>"],
       Comment => ["<font color=\"#7f7f7f\"><i>", "</i></font>"],
       DataType => ["<font color=\"#0000ff\">", "</font>"],
       DecVal => ["<font color=\"#00007f\">", "</font>"],
       Error => ["<font color=\"#ff0000\"><b><i>", "</i></b></font>"],
       Float => ["<font color=\"#00007f\">", "</font>"],
       Function => ["<font color=\"#007f00\">", "</font>"],
       IString => ["<font color=\"#ff0000\">", ""],
       Keyword => ["<b>", "</b>"],
       Normal => ["", ""],
       Operator => ["<font color=\"#ffa500\">", "</font>"],
       Others => ["<font color=\"#b03060\">", "</font>"],
       RegionMarker => ["<font color=\"#96b9ff\"><i>", "</i></font>"],
       Reserved => ["<font color=\"#9b30ff\"><b>", "</b></font>"],
       String => ["<font color=\"#ff0000\">", "</font>"],
       Variable => ["<font color=\"#0000ff\"><b>", "</b></font>"],
       Warning => ["<font color=\"#0000ff\"><b><i>", "</b></i></font>"],
    },
 );
 
 #or
 
 my $hl = new Syntax::Highlight::Engine::Kate::Perl(
    substitutions => {
       "<" => "&lt;",
       ">" => "&gt;",
       "&" => "&amp;",
       " " => "&nbsp;",
       "\t" => "&nbsp;&nbsp;&nbsp;",
       "\n" => "<BR>\n",
    },
    format_table => {
       Alert => ["<font color=\"#0000ff\">", "</font>"],
       BaseN => ["<font color=\"#007f00\">", "</font>"],
       BString => ["<font color=\"#c9a7ff\">", "</font>"],
       Char => ["<font color=\"#ff00ff\">", "</font>"],
       Comment => ["<font color=\"#7f7f7f\"><i>", "</i></font>"],
       DataType => ["<font color=\"#0000ff\">", "</font>"],
       DecVal => ["<font color=\"#00007f\">", "</font>"],
       Error => ["<font color=\"#ff0000\"><b><i>", "</i></b></font>"],
       Float => ["<font color=\"#00007f\">", "</font>"],
       Function => ["<font color=\"#007f00\">", "</font>"],
       IString => ["<font color=\"#ff0000\">", ""],
       Keyword => ["<b>", "</b>"],
       Normal => ["", ""],
       Operator => ["<font color=\"#ffa500\">", "</font>"],
       Others => ["<font color=\"#b03060\">", "</font>"],
       RegionMarker => ["<font color=\"#96b9ff\"><i>", "</i></font>"],
       Reserved => ["<font color=\"#9b30ff\"><b>", "</b></font>"],
       String => ["<font color=\"#ff0000\">", "</font>"],
       Variable => ["<font color=\"#0000ff\"><b>", "</b></font>"],
       Warning => ["<font color=\"#0000ff\"><b><i>", "</b></i></font>"],
    },
 );
 
 
 print "<html>\n<head>\n</head>\n<body>\n";
 while (my $in = <>) {
    print $hl->highlightText($in);
 }
 print "</body>\n</html>\n";

=head1 DESCRIPTION

Syntax::Highlight::Engine::Kate is a port to perl of the syntax highlight engine of the 
Kate text editor.

The language xml files of kate have been rewritten to perl modules using a script. These modules 
function as plugins to this module.

Syntax::Highlight::Engine::Kate inherits Syntax::Highlight::Engine::Kate::Template.

=head1 OPTIONS

=over 4

=item B<language>

Specify the language you want highlighted.
look in the B<PLUGINS> section for supported languages.



=item B<plugins>

If you created your own language plugins you may specify a list of them with this option.

 plugins => [
   ["MyModuleName", "MyLanguageName", "*,ext1;*.ext2", "Section"],
   ....
 ]

=item B<format_table>

This option must be specified if the B<highlightText> method needs to do anything usefull for you.
All mentioned keys in the synopsis must be specified.


=item B<substitutions>

With this option you can specify additional formatting options.


=back

=head1 METHODS

=over 4

=item B<extensions>

returns a reference to the extensions hash,

=item B<language>(I<?$language?>)

Sets and returns the current language that is highlighted. when setting the language a reset is also done.

=item B<languageAutoSet>(I<$filename>);

Suggests language name for the fiven file B<$filename>

=item B<languageList>

returns a list of languages for which plugins have been defined.

=item B<languagePlug>(I<$language>);

returns the module name of the plugin for B<$language>

=item B<languagePropose>(I<$filename>);

Suggests language name for the fiven file B<$filename>

=item B<sections>

Returns a reference to the sections hash.

=back

=head1 ATTRIBUTES

In the kate XML syntax files you find under the section B<<itemDatas>> entries like 
<itemData name="Unknown Property"  defStyleNum="dsError" italic="1"/>. Kate is an editor
so it is ok to have definitions for forground and background colors and so on. However, 
since this Module is supposed to be a more universal highlight engine, the attributes need
to be fully abstract. In which case, Kate does not have enough default attributes defined
to fullfill all needs. Kate defines the following standard attributes: B<dsNormal>, B<dsKeyword>, 
B<dsDataType>, B<dsDecVal>, B<dsBaseN>, B<dsFloat>, B<dsChar>, B<dsString>, B<dsComment>, B<dsOthers>, 
B<dsAlert>, B<dsFunction>, B<dsRegionMarker>, B<dsError>. This module leaves out the "ds" part and uses 
following additional attributes: B<BString>, B<IString>, B<Operator>, B<Reserved>, B<Variable>. I have 
modified the XML files so that each highlight mode would get it's own attribute. In quite a few cases
still not enough attributes were defined. So in some languages different modes have the same attribute.

=head1 PLUGINS

Below an overview of existing plugins. All have been tested on use and can be created. The ones for which no samplefile
is available are marked. Those marked OK have highlighted the testfile without appearant mistakes. This does
not mean that all bugs are shaken out. 

 LANGUAGE             MODULE                   COMMENT
 ********             ******                   ******
 .desktop             Desktop                  OK
 4GL                  FourGL                   No sample file
 4GL-PER              FourGLminusPER           No sample file
 ABC                  ABC                      OK
 AHDL                 AHDL                     OK
 ANSI C89             ANSI_C89                 No sample file
 ASP                  ASP                      OK
 AVR Assembler        AVR_Assembler            OK
 AWK                  AWK                      OK
 Ada                  Ada                      No sample file
                      Alerts                   OK hidden module
 Ansys                Ansys                    No sample file
 Apache Configuration Apache_Configuration     No sample file
 Asm6502              Asm6502                  No sample file
 Bash                 Bash                     OK
 BibTeX               BibTeX                   OK
 C                    C                        No sample file
 C#                   Cdash                    No sample file
 C++                  Cplusplus                OK
 CGiS                 CGiS                     No sample file
 CMake                CMake                    OK
 CSS                  CSS                      OK
 CUE Sheet            CUE_Sheet                No sample file
 Cg                   Cg                       No sample file
 ChangeLog            ChangeLog                No sample file
 Cisco                Cisco                    No sample file
 Clipper              Clipper                  OK
 ColdFusion           ColdFusion               No sample file
 Common Lisp          Common_Lisp              OK
 Component-Pascal     ComponentminusPascal     No sample file
 D                    D                        No sample file
 Debian Changelog     Debian_Changelog         No sample file
 Debian Control       Debian_Control           No sample file
 Diff                 Diff                     No sample file
 Doxygen              Doxygen                  OK
 E Language           E_Language               OK
 Eiffel               Eiffel                   No sample file
 Email                Email                    OK
 Euphoria             Euphoria                 OK
 Fortran              Fortran                  OK
 FreeBASIC            FreeBASIC                No sample file
 GDL                  GDL                      No sample file
 GLSL                 GLSL                     OK
 GNU Assembler        GNU_Assembler            No sample file
 GNU Gettext          GNU_Gettext              No sample file
 HTML                 HTML                     OK
 Haskell              Haskell                  OK
 IDL                  IDL                      No sample file
 ILERPG               ILERPG                   No sample file
 INI Files            INI_Files                No sample file
 Inform               Inform                   No sample file
 Intel x86 (NASM)     Intel_X86_NASM           seems to have issues
 JSP                  JSP                      OK
 Java                 Java                     OK
 JavaScript           JavaScript               OK
 Javadoc              Javadoc                  No sample file
 KBasic               KBasic                   No sample file
 Kate File Template   Kate_File_Template       No sample file
 LDIF                 LDIF                     No sample file
 LPC                  LPC                      No sample file
 LaTeX                LaTex                    OK
 Lex/Flex             Lex_Flex                 OK
 LilyPond             LilyPond                 OK
 Literate Haskell     Literate_Haskell         OK
 Lua                  Lua                      No sample file
 M3U                  M3U                      OK
 MAB-DB               MABminusDB               No sample file
 MIPS Assembler       MIPS_Assembler           No sample file
 Makefile             Makefile                 No sample file
 Mason                Mason                    No sample file
 Matlab               Matlab                   has issues
 Modula-2             Modulaminus2             No sample file
 Music Publisher      Music_Publisher          No sample file
 Octave               Octave                   OK
 PHP (HTML)           PHP_HTML                 OK
                      PHP_PHP                  OK hidden module
 POV-Ray              POV_Ray                  OK
 Pascal               Pascal                   No sample file
 Perl                 Perl                     OK
 PicAsm               PicAsm                   OK
 Pike                 Pike                     OK
 PostScript           PostScript               OK
 Prolog               Prolog                   No sample file
 PureBasic            PureBasic                OK
 Python               Python                   OK
 Quake Script         Quake_Script             No sample file
 R Script             R_Script                 No sample file
 REXX                 REXX                     No sample file
 RPM Spec             RPM_Spec                 No sample file
 RSI IDL              RSI_IDL                  No sample file
 RenderMan RIB        RenderMan_RIB            OK
 Ruby                 Ruby                     OK
 SGML                 SGML                     No sample file
 SML                  SML                      No sample file
 SQL                  SQL                      No sample file
 SQL (MySQL)          SQL_MySQL                No sample file
 SQL (PostgreSQL)     SQL_PostgreSQL           No sample file
 Sather               Sather                   No sample file
 Scheme               Scheme                   OK
 Sieve                Sieve                    No sample file
 Spice                Spice                    OK
 Stata                Stata                    OK
 TI Basic             TI_Basic                 No sample file
 TaskJuggler          TaskJuggler              No sample file
 Tcl/Tk               TCL_Tk                   OK
 UnrealScript         UnrealScript             OK
 VHDL                 VHDL                     No sample file
 VRML                 VRML                     OK
 Velocity             Velocity                 No sample file
 Verilog              Verilog                  No sample file
 WINE Config          WINE_Config              No sample file
 Wikimedia            Wikimedia                No sample file
 XML                  XML                      OK
 XML (Debug)          XML_Debug                No sample file
 Yacc/Bison           Yacc_Bison               OK
 de_DE                De_DE                    No sample file
 en_EN                En_EN                    No sample file
 ferite               Ferite                   No sample file
 nl                   Nl                       No sample file
 progress             Progress                 No sample file
 scilab               Scilab                   No sample file
 txt2tags             Txt2tags                 No sample file
 x.org Configuration  X_org_Configuration      OK
 xHarbour             XHarbour                 OK
 xslt                 Xslt                     No sample file
 yacas                Yacas                    No sample file


=head1 BUGS

Float is detected differently than in the Kate editor.

The regular expression engine of the Kate editor, qregexp, appears to be more tolerant to mistakes
in regular expressions than perl. This might lead to error messages and differences in behaviour. 
Most of the problems were sorted out while developing, because error messages appeared. For as far
as differences in behaviour is concerned, testing is the only way to find out, so i hope the users
out there will be able to tell me more.

This module is mimicking the behaviour of the syntax highlight engine of the Kate editor. If you find
a bug/mistake in the highlighting, please check if Kate behaves in the same way. If yes, the cause is
likely to be found there.

=head1 TO DO

Rebuild the scripts i am using to generate the modules from xml files so they are more pro-actively tracking
flaws in the build of the xml files like missing lists. Also regular expressions in the xml can be tested better 
before used in plugins.

Refine the testmethods in Syntax::Highlight::Engine::Kate::Template, so that choices for casesensitivity, 
dynamic behaviour and lookahead can be determined at generate time of the plugin, might increase throughput.

Implement codefolding.

=head1 ACKNOWLEDGEMENTS

All the people who wrote Kate and the syntax highlight xml files.

=head1 AUTHOR AND COPYRIGHT

This module is written and maintained by:

Hans Jeuken < haje at toneel dot demon dot nl >

Copyright (c) 2006 by Hans Jeuken, all rights reserved.

You may freely distribute and/or modify this module under the same terms 
as Perl itself. 

=head1 SEE ALSO

Syntax::Highlight::Engine::Kate::Template http:://www.kate-editor.org

=cut

