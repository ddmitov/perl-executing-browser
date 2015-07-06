#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

##############################
# CENSOR.PL SETTINGS:
##############################
my @allowed_use_pragmas = qw (attributes autodie autouse
	base bigint bignum bigrat blib bytes
	charnames constant
	diagnostics
	encoding
	feature fields
	filetest
	if integer
	less locale
	mro
	open ops overload overloading
	parent
	re
	sigtrap sort strict subs
	threads threads::shared
	utf8
	vars vmsish
	warnings warnings::register);

my @core_modules = qw (AnyDBM_File
	App::Prove App::Prove::State App::Prove::State::Result App::Prove::State::Result::Test
	Archive::Tar Archive::Tar::File Attribute::Handlers AutoLoader AutoSplit
	B B::Concise B::Debug B::Deparse B::Showlex B::Terse B::Xref Benchmark
	Carp Class::Struct Compress::Raw::Bzip2 Compress::Raw::Zlib Compress::Zlib Config Config::Extensions
	CPAN CPAN::Debug CPAN::Distroprefs CPAN::FirstTime CPAN::HandleConfig CPAN::Kwalify CPAN::Nox
	CPAN::Queue CPAN::Tarzip CPAN::Version
	Cwd
	Data::Dumper DB
	DBM_Filter DBM_Filter::compress DBM_Filter::encode DBM_Filter::int32 DBM_Filter::null DBM_Filter::utf8
	DB_File Devel::Peek Devel::PPPort Devel::SelfStubber
	Digest Digest::base Digest::file Digest::MD5 Digest::SHA DirHandle Dumpvalue DynaLoader
	Encode Encode::Alias Encode::Byte Encode::CJKConstants Encode::CN Encode::CN::HZ Encode::Config
	Encode::EBCDIC Encode::Encoder Encode::Encoding Encode::GSM0338 Encode::Guess Encode::JP
	Encode::JP::H2Z Encode::JP::JIS7 Encode::KR Encode::KR::2022_KR Encode::MIME::Header Encode::MIME::Name
	Encode::Symbol Encode::TW Encode::Unicode Encode::Unicode::UTF7
	English Env Errno Exporter Exporter::Heavy
	ExtUtils::CBuilder ExtUtils::CBuilder::Platform::Windows ExtUtils::Command ExtUtils::Command::MM
	ExtUtils::Constant ExtUtils::Constant::Base ExtUtils::Constant::Utils ExtUtils::Constant::XS ExtUtils::Embed
	ExtUtils::Install ExtUtils::Installed ExtUtils::Liblist ExtUtils::MakeMaker ExtUtils::MakeMaker::Config
	ExtUtils::MakeMaker::FAQ ExtUtils::MakeMaker::Tutorial ExtUtils::Manifest ExtUtils::Miniperl
	ExtUtils::Mkbootstrap ExtUtils::Mksymlists ExtUtils::MM ExtUtils::MM_AIX ExtUtils::MM_Cygwin
	ExtUtils::MM_Darwin ExtUtils::MM_DOS ExtUtils::MM_MacOS ExtUtils::MM_NW5
	ExtUtils::MM_OS2 ExtUtils::MM_QNX ExtUtils::MM_Unix ExtUtils::MM_UWIN ExtUtils::MM_VMS ExtUtils::MM_VOS
	ExtUtils::MM_Win32 ExtUtils::MM_Win95 ExtUtils::MY ExtUtils::Packlist ExtUtils::ParseXS ExtUtils::testlib
	Fatal Fcntl
	File::Basename File::Compare File::Copy File::DosGlob File::Fetch File::Find
	File::Glob File::GlobMapper File::Path File::Spec File::Spec::Cygwin File::Spec::Epoc
	File::Spec::Functions File::Spec::Mac File::Spec::OS2 File::Spec::Unix File::Spec::VMS
	File::Spec::Win32 File::stat File::Temp FileCache FileHandle Filter::Simple Filter::Util::Call
	FindBin
	Getopt::Long Getopt::Std
	Hash::Util Hash::Util::FieldHash
	I18N::Collate I18N::Langinfo I18N::LangTags I18N::LangTags::Detect I18N::LangTags::List
	IO
	IO::Compress::Base IO::Compress::Bzip2 IO::Compress::Deflate
	IO::Compress::Gzip IO::Compress::RawDeflate IO::Compress::Zip
	IO::Dir IO::File IO::Handle IO::Pipe IO::Poll IO::Seekable IO::Select 
	IO::Socket IO::Socket::INET IO::Socket::UNIX 
	IO::Uncompress::AnyInflate IO::Uncompress::AnyUncompress 
	IO::Uncompress::Base IO::Uncompress::Bunzip2 IO::Uncompress::Gunzip 
	IO::Uncompress::Inflate IO::Uncompress::RawInflate IO::Uncompress::Unzip IO::Zlib 
	IPC::Cmd IPC::Msg IPC::Open2 IPC::Open3 IPC::Semaphore IPC::SharedMem IPC::SysV
	List::Util List::Util::XS
	Locale::Country Locale::Currency Locale::Language Locale::Maketext
	Locale::Maketext::Guts Locale::Maketext::GutsLoader
	Locale::Maketext::Simple Locale::Script
	Math::BigFloat Math::BigInt Math::BigInt::Calc
	Math::BigInt::CalcEmu Math::BigInt::FastCalc
	Math::BigRat Math::Complex Math::Trig
	Memoize Memoize::AnyDBM_File Memoize::Expire
	Memoize::ExpireFile Memoize::ExpireTest Memoize::NDBM_File
	Memoize::SDBM_File Memoize::Storable
	MIME::Base64 MIME::QuotedPrint
	Module::CoreList Module::Load
	Module::Load::Conditional Module::Loaded
	NDBM_File
	Net::Cmd Net::Config Net::Domain Net::FTP
	Net::FTP::dataconn Net::hostent Net::netent Net::Netrc
	Net::NNTP Net::Ping Net::POP3 Net::protoent Net::servent
	Net::SMTP Net::Time
	NEXT
	O Opcode
	Params::Check Parse::CPAN::Meta
	PerlIO PerlIO::encoding PerlIO::scalar PerlIO::via PerlIO::via::QuotedPrint
	Pod::Checker Pod::Escapes Pod::Find Pod::Functions Pod::Html Pod::InputObjects
	Pod::Man Pod::ParseLink Pod::Parser Pod::ParseUtils Pod::Perldoc Pod::Perldoc::BaseTo
	Pod::Perldoc::GetOptsOO Pod::Perldoc::ToChecker Pod::Perldoc::ToMan Pod::Perldoc::ToNroff
	Pod::Perldoc::ToPod Pod::Perldoc::ToRtf Pod::Perldoc::ToText Pod::Perldoc::ToTk Pod::Perldoc::ToXml
	Pod::PlainText Pod::Select Pod::Simple Pod::Simple::Checker Pod::Simple::Debug
	Pod::Simple::DumpAsText Pod::Simple::DumpAsXML Pod::Simple::HTML Pod::Simple::HTMLBatch
	Pod::Simple::LinkSection Pod::Simple::Methody Pod::Simple::PullParser Pod::Simple::PullParserEndToken
	Pod::Simple::PullParserStartToken Pod::Simple::PullParserTextToken Pod::Simple::PullParserToken
	Pod::Simple::RTF Pod::Simple::Search Pod::Simple::SimpleTree Pod::Simple::Text Pod::Simple::TextContent
	Pod::Simple::XHTML Pod::Simple::XMLOutStream Pod::Text Pod::Text::Color Pod::Text::Overstrike
	Pod::Text::Termcap Pod::Usage
	POSIX
	Safe Scalar::Util SDBM_File Search::Dict SelectSaver
	SelfLoader Socket Storable Symbol
	Sys::Hostname Sys::Syslog
	 TAP::Base TAP::Formatter::Base TAP::Formatter::Color
	TAP::Formatter::Console TAP::Formatter::Console::ParallelSession
	TAP::Formatter::Console::Session TAP::Formatter::File
	TAP::Formatter::File::Session TAP::Formatter::Session
	TAP::Harness TAP::Object TAP::Parser TAP::Parser::Aggregator
	TAP::Parser::Grammar TAP::Parser::Iterator TAP::Parser::Iterator::Array
	TAP::Parser::Iterator::Process TAP::Parser::Iterator::Stream
	TAP::Parser::IteratorFactory TAP::Parser::Multiplexer TAP::Parser::Result 
	TAP::Parser::Result::Bailout TAP::Parser::Result::Comment
	TAP::Parser::Result::Plan TAP::Parser::Result::Pragma TAP::Parser::Result::Test
	TAP::Parser::Result::Unknown TAP::Parser::Result::Version
	TAP::Parser::Result::YAML TAP::Parser::ResultFactory TAP::Parser::Scheduler
	TAP::Parser::Scheduler::Job TAP::Parser::Scheduler::Spinner TAP::Parser::Source
	TAP::Parser::YAMLish::Reader TAP::Parser::YAMLish::Writer
	Term::ANSIColor Term::Cap Term::Complete Term::ReadLine
	Test Test::Builder Test::Builder::Module Test::Builder::Tester
	Test::Builder::Tester::Color Test::Harness Test::More Test::Simple
	Text::Abbrev Text::Balanced Text::ParseWords Text::Tabs Text::Wrap
	Thread Thread::Queue Thread::Semaphore
	Tie::Array Tie::File Tie::Handle Tie::Hash Tie::Hash::NamedCapture
	Tie::Memoize Tie::RefHash Tie::Scalar Tie::StdHandle Tie::SubstrHash
	Time::gmtime Time::HiRes Time::Local Time::localtime Time::Piece
	Time::Seconds Time::tm
	Unicode::Collate Unicode::Normalize Unicode::UCD
	UNIVERSAL
	User::grent User::pwent
	XSLoader);

my @allowed_non_core_modules = qw (Archive::Zip
	DBI
	File::Copy::Recursive
	Module::ScanDeps
	XML::LibXML);

my @prohibited_core_functions = qw (fork unlink);
##############################
# END OF CENSOR.PL SETTINGS
##############################

my @allowed_use_pragmas_and_modules = (@allowed_use_pragmas, @core_modules, @allowed_non_core_modules);
my $prohibited_core_functions = join (' ', @prohibited_core_functions);

##############################
# REDIRECT STDERR TO A VARIABLE:
##############################
open (my $saved_stderr_filehandle, '>&', \*STDERR)  or die "Can't duplicate STDERR: $!";
close STDERR;
my $stderr;
open (STDERR, '>', \$stderr) or die "Unable to open STDERR: $!";

##############################
# READ USER SCRIPT FROM
# THE FIRST COMMAND LINE ARGUMENT:
##############################
my $file = $ARGV[0];
open my $filehandle, '<', $file or die;
my @user_code = <$filehandle>;
close $filehandle;

##############################
# INSERT SAFETY LINE IN USER CODE -
# BAN ALL PROHIBITED CORE FUNCTIONS:
##############################
my %problematic_lines;
my $line_number;
my $real_line_number;
foreach my $line (@user_code) {
	$line_number++;
	$real_line_number = $line_number - 1;

	if ($line_number == 1) {
		my $first_line = $line;
		shift @user_code;
		my $safety_line = "no ops qw ($prohibited_core_functions);";
		unshift @user_code, $first_line, $safety_line;
	}

##############################
# DETECT FORBIDDEN MANIPULATION OF
# ALL SPECIAL ENVIRONMENT VARIABLES:
##############################
	if ($line =~ m/\$ENV{'DOCUMENT_ROOT'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'DOCUMENT_ROOT'}/) {
			next;
		} else {
			$problematic_lines{$line} = "Forbidden manipulation of 'DOCUMENT_ROOT' environment variable detected!";
		}
	}

	if ($line =~ m/\$ENV{'FILE_TO_OPEN'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FILE_TO_OPEN'}/) {
			next;
		} else {
			$problematic_lines{$line} = "Forbidden manipulation of 'FILE_TO_OPEN' environment variable detected!";
		}
	}

	if ($line =~ m/\$ENV{'FILE_TO_CREATE'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FILE_TO_CREATE'}/) {
			next;
		} else {
			$problematic_lines{$line} = "Forbidden manipulation of 'FILE_TO_CREATE' environment variable detected!";
		}
	}

	if ($line =~ m/\$ENV{'FOLDER_TO_OPEN'}\s*=/) {
		if ($line =~ m/#.*\$ENV{'FOLDER_TO_OPEN'}/) {
			next;
		} else {
			$problematic_lines{$line} = "Forbidden manipulation of 'FOLDER_TO_OPEN' environment variable detected!";
		}
	}

##############################
# DETECT FORBIDDEN OPEN:
##############################
	if ($line =~ m/open\s/) {
		# commented 'open' is not a treat and is allowed
		if ($line =~ m/#.*open/) {
			next;
		} else {
			# 'open' from DOCUMENT_ROOT is allowed
			if ($line =~ m/(open my \$filehandle, '<', \"\$ENV{'DOCUMENT_ROOT'}\$relative_filepath\" or)/) {
				next;
			# 'use open' pragma is also allowed
			} elsif ($line =~ "use open") {
				next;
			# every other use of 'open' is not allowed
			} else {
				$problematic_lines{$line} = "Forbidden use of 'open' function detected!";
			}
		}
	}

##############################
# DETECT FORBIDDEN MODULES OR
# FORBIDDEN USE PRAGMAS:
##############################
	if ($line =~ m/use\s/) {
		# commented 'use' is not a treat and is allowed
		if ($line =~ m/#.*use/) {
				next;
		} else {
			my $use_pragma_or_module_name = $line;
			$use_pragma_or_module_name =~ s/use\s//;
			$use_pragma_or_module_name =~ s/\sqw.*//;
			$use_pragma_or_module_name =~ s/;//;
			chomp $use_pragma_or_module_name;
			if ($use_pragma_or_module_name =~ m/5\.\d/) { 
				next;
			} elsif (grep (/$use_pragma_or_module_name/, @allowed_use_pragmas_and_modules)) { 
				next;
			} else {
				$problematic_lines{$line} = "Forbidden 'use' pragma or unauthorized module detected!";
			}
		}
	}

}

##############################
# HTML HEADER AND FOOTER:
##############################
my $header = "<html>

<head>
<title>Perl Executing Browser - Errors</title>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
<style type='text/css'>body {text-align: left}</style>\n
</head>

<body>";

my $footer = "</body>

</html>";

##############################
# EXECUTE USER CODE IN 'EVAL' STATEMENT:
##############################
if (scalar (keys %problematic_lines) == 0) {
	my $user_code = join ('', @user_code);
	eval ($user_code);

	close (STDERR) or die "Can't close STDERR: $!";
	open (STDERR, '>&', $saved_stderr_filehandle) or die "Can't restore STDERR: $!";
} else {
	close (STDERR) or die "Can't close STDERR: $!";
	open (STDERR, '>&', $saved_stderr_filehandle) or die "Can't restore STDERR: $!";

	print STDERR $header;
	print STDERR "<p align='center'><font size='5' face='SansSerif'>";
	print STDERR "Script execution was not attempted due to security violations:</font></p>\n";

	while ((my $line, my $explanation) = each (%problematic_lines)){
		print STDERR "<pre>";
		print STDERR "$line";
		print STDERR "$explanation";
		print STDERR "</pre>";
	}
	
	print STDERR $footer;
	exit;
}

##############################
# PRINT SAVED STDERR, IF ANY:
##############################
if ($@) {
	if ($@ =~ m/trapped/) {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>Unsecure code was blocked:</font></p>\n";
		print STDERR "<pre>$@</pre>";
		print STDERR $footer;
		exit;
	} else {
		print STDERR $header;
		print STDERR "<p align='center'><font size='5' face='SansSerif'>Errors were found during script execution:</font></p>\n";
		print STDERR "<pre>$@</pre>";
		print STDERR $footer;
		exit;
	}
}

if (defined($stderr)) {
	print STDERR $header;
	print STDERR "<p align='center'><font size='5' face='SansSerif'>Errors were found during script execution:</font></p>\n";
	print STDERR "<pre>$stderr</pre>";
	print STDERR $footer;
}
