package HTML::Perlinfo;
BEGIN { %Seen = %INC }

use strict;
use warnings;
use Carp (); 

use HTML::Perlinfo::Apache;
use HTML::Perlinfo::Modules; 
use HTML::Perlinfo::Common;

use base qw(Exporter HTML::Perlinfo::Base);
our @EXPORT = qw(perlinfo);

our $VERSION = '1.62';

sub perlinfo {
  my ($opt) = @_;
  $opt = 'INFO_ALL' unless $opt;
 
  error_msg("Invalid perlinfo() parameter: @_")
  if (($opt !~ /^INFO_(?:ALL|GENERAL|CONFIG|VARIABLES|APACHE|MODULES|LICENSE|LOADED)$/) || @_ > 1); 
 
  $opt = lc $opt;
  my $p = HTML::Perlinfo->new();
  $p->$opt;

}
%INC = %HTML::Perlinfo::Seen;
1;
__END__
=pod

=head1 NAME

HTML::Perlinfo - Display a lot of Perl information in HTML format 

=head1 SYNOPSIS

	use HTML::Perlinfo;

	perlinfo();
	
	
	use HTML::Perlinfo;
	use CGI qw(header);

	$|++;

	print header;
	perlinfo(INFO_MODULES);

=head1 DESCRIPTION

This module outputs a large amount of information about your Perl installation in HTML. So far, this includes information about Perl compilation options, the Perl version, server information and environment, HTTP headers, OS version information, Perl modules, and more. 

HTML::Perlinfo is aimed at Web developers, but almost anyone using Perl may find it useful. It is a valuable debugging tool as it contains all EGPCS (Environment, GET, POST, Cookie, Server) data. It will also work under taint mode.  

The output may be customized by passing one of the following options. 

=head1 OPTIONS

There are 8 options to pass to the perlinfo funtion. All of these options are also object methods. The key difference is their case: Captilize the option name when passing it to the function and use only lower-case letters when using the object-oriented approach.

=over

=item INFO_GENERAL

The Perl version, build date, and more.

=item INFO_VARIABLES

Shows all predefined variables from EGPCS (Environment, GET, POST, Cookie, Server).

=item INFO_CONFIG

All configuration values from config_sh. INFO_ALL shows only some values.

=item INFO_APACHE

Apache HTTP server information, including mod_perl information.  

=item INFO_MODULES 

All installed modules, their version number and description. INFO_ALL shows only core modules.
Please also see L<HTML::Perlinfo::Modules>.

=item INFO_LOADED

Post-execution dump of loaded modules (plus INFO_VARIABLES). INFO_ALL shows only core modules. Please also see L<HTML::Perlinfo::Loaded>.

=item INFO_LICENSE 

Perl license information.

=item INFO_ALL

Shows all of the above defaults. This is the default value.

=back

=head1 PROGRAMMING STYLE

There are two styles of programming with Perlinfo.pm, a function-oriented style and an object-oriented style.

Function-oriented style:

	# Show all information, defaults to INFO_ALL
	perlinfo();

	# Show only module information. This shows all installed modules.
	perlinfo(INFO_MODULES);

Object-oriented style:

	$p = new HTML::Perlinfo;
	$p->info_all;

	# You can also set the CSS values in the constructor!
    	$p = HTML::Perlinfo->new(
		bg_image  => 'http://i104.photobucket.com/albums/m176/perlinfo/camel.gif',
		bg_repeat => 'yes-repeat'
	);
	$p->info_all;

More examples ...

	# This is wrong (no capitals)
	$p->INFO_MODULES;

	# But this is correct
	perlinfo(INFO_MODULES);
	
	# Ditto
	$p->info_modules;

=head1 CUSTOMIZING THE HTML

You can capture the HTML output and manipulate it or you can alter CSS elements with object attributes.

For further details and examples, please see the L<HTML documentation|HTML::Perlinfo::HTML> in the HTML::Perlinfo distribution.

=head1 SECURITY

Displaying detailed server information on the internet is not a good idea and HTML::Perlinfo reveals a lot of information about the local environment. While restricting what system users can publish online is wise, you can also hinder them from using the module by installing it outside of the usual module directories (see perldoc -q lib). Of course, preventing users from installing the module in their own home directories is another matter entirely. 

=head1 REQUIREMENTS

HTML::Perlinfo does not require any non-core modules. 

=head1 NOTES

INFO_APACHE relies soley on environment variables.  

INFO_VARIABLES did not work correctly until version 1.52.

INFO_LOADED is the only option whose output cannot be assigned to a scalar. 

Some might notice that HTML::Perlinfo shares the look and feel of the PHP function phpinfo. It was originally inspired by that function and was first released in 2004 as PHP::Perlinfo, which is no longer available on CPAN.   

Since the module outputs HTML, you may want to use it in a CGI script, but you do not have to. Of course, some information, like HTTP headers, would not be available if you use the module at the command-line. If you decide to use this module in a CGI script, B<make sure you print out the content-type header beforehand>. For example:

	use HTML::Perlinfo;

	print "Content-type: text/html\n\n";
	perlinfo();

I prefer to use the header function from the CGI module:

	use HTML::Perlinfo;
	use CGI qw(header);

	print header;
	perlinfo();

In this example, I am flushing the buffer because I know that there will be a lot of modules:

	use HTML::Perlinfo;
	use CGI qw(header);

	$|++;

	print header;
	perlinfo(INFO_MODULES);

HTML::Perlinfo stopped printing the header automatically as of version 1.43.  

=head1 BUGS

Please report any bugs or feature requests to C<bug-html-perlinfo@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTML-Perlinfo>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SEE ALSO

L<Config>. You can also use "perl -V" to see a configuration summary at the command-line.

L<CGI::Carp::Fatals>, L<Apache::Status>, L<App::Info>, L<Probe::Perl>, L<Module::CoreList>, L<Module::Info>, among others.

Also included in the Perlinfo distribution: L<perlinfo>, L<HTML::Perlinfo::Loaded>, L<HTML::Perlinfo::Modules> 

=head1 AUTHOR

Mike Accardo <accardo@cpan.org>

=head1 COPYRIGHT

   Copyright (c) 2004-9, Mike Accardo. All Rights Reserved.
 This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License.

=cut

