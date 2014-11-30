package CGI::Simple::Standard;

use strict;
use CGI::Simple;
use Carp;
use vars qw( $VERSION $USE_CGI_PM_DEFAULTS $DISABLE_UPLOADS $POST_MAX
 $NO_UNDEF_PARAMS $USE_PARAM_SEMICOLONS $HEADERS_ONCE
 $NPH $DEBUG $NO_NULL $FATAL *in %EXPORT_TAGS $AUTOLOAD );

$VERSION = "1.114";

%EXPORT_TAGS = (
  ':html'     => [qw(:misc)],
  ':standard' => [qw(:core :access)],
  ':cgi'      => [qw(:core :access)],
  ':all'      => [
    qw(:core :misc :cookie :header :push :debug :cgi-lib
     :access :internal)
  ],
  ':core' => [
    qw(param add_param param_fetch url_param keywords
     append Delete delete_all Delete_all upload
     query_string parse_query_string  parse_keywordlist
     Vars save_parameters restore_parameters)
  ],
  ':misc'   => [qw(url_decode url_encode escapeHTML unescapeHTML put)],
  ':cookie' => [qw(cookie raw_cookie)],
  ':header' => [qw(header cache no_cache redirect)],
  ':push'   => [
    qw(multipart_init multipart_start multipart_end
     multipart_final)
  ],
  ':debug'   => [qw(Dump as_string cgi_error _cgi_object)],
  ':cgi-lib' => [
    qw(ReadParse SplitParam MethGet MethPost MyBaseUrl MyURL
     MyFullUrl PrintHeader HtmlTop HtmlBot PrintVariables
     PrintEnv CgiDie CgiError Vars)
  ],
  ':ssl'    => [qw(https)],
  ':access' => [
    qw(version nph all_parameters charset crlf globals
     auth_type content_length content_type document_root
     gateway_interface path_translated referer remote_addr
     remote_host remote_ident remote_user request_method
     script_name server_name server_port server_protocol
     server_software user_name user_agent virtual_host
     path_info Accept http https protocol url self_url
     state)
  ],
  ':internal' => [
    qw(_initialize_globals _use_cgi_pm_global_settings
     _store_globals _reset_globals)
  ]
);

# BEGIN {
#     $SIG{__DIE__} = sub { croak "Undefined Method : @_\n" }
# }

sub import {
  my ( $self, @args ) = @_;
  my $package = caller();
  my ( %exports, %pragmas );
  for my $arg ( @args ) {
    $exports{$arg}++, next if $arg =~ m/^\w+$/;
    $pragmas{$arg}++, next if $arg =~ m/^-\w+$/;
    if ( $arg =~ m/^:[-\w]+$/ ) {
      if ( exists $EXPORT_TAGS{$arg} ) {
        my @tags = @{ $EXPORT_TAGS{$arg} };
        for my $tag ( @tags ) {
          my @expanded
           = exists $EXPORT_TAGS{$tag}
           ? @{ $EXPORT_TAGS{$tag} }
           : ( $tag );
          $exports{$_}++ for @expanded;
        }
      }
      else {
        croak
         "No '$arg' tag set available for export from CGI::Simple::Standard!\n";
      }
    }
  }
  my @exports = keys %exports;
  my %valid_exports;
  for my $tag ( @{ $EXPORT_TAGS{':all'} } ) {
    $valid_exports{$_}++ for @{ $EXPORT_TAGS{$tag} };
  }
  for ( @exports ) {
    croak
     "'$_' is not an available export method from CGI::Simple::Standard!\n"
     unless exists $valid_exports{$_};
  }
  no strict 'refs';
  if ( exists $pragmas{'-autoload'} ) {

    # hack symbol table to export our AUTOLOAD sub
    *{"${package}::AUTOLOAD"} = sub {
      my ( $caller, $sub ) = $AUTOLOAD =~ m/(.*)::(\w+)$/;
      &CGI::Simple::Standard::loader( $caller, $sub, @_ );
    };
    delete $pragmas{'-autoload'};
  }
  my @pragmas = keys %pragmas;
  CGI::Simple->import( @pragmas ) if @pragmas;

  # export subroutine stubs for all the desired export functions
  # we will replace them in the symbol table with the real thing
  # if and when they are first called
  for my $i ( 0 .. $#exports ) {
    *{"${package}::$exports[$i]"} = sub {
      my $caller = caller;
      &CGI::Simple::Standard::loader( $caller, $exports[$i], @_ );
     }
  }
}

# loader() may be called either via our exported AUTOLOAD sub or by the
# subroutine stubs we exported on request. It has three functions:
# 1) to initialize and store (via a closure) our CGI::Simple object
# 2) to overwrite the exported subroutine stubs with calls to the real ones
# 3) to provide two 'virtual' methods - _cgi_object() and restore_parameters()
# restore_parameters effectively functions like new() for the OO interface.
{
  my $q;

  sub loader {
    my $package = shift;
    my $sub     = shift;
    if ( $sub eq '_cgi_object' ) {    # for debugging get at the object
      $q = CGI::Simple->new( @_ ) unless $q;
      return $q;
    }
    if ( !$q or $sub eq 'restore_parameters' ) {
      if ( $sub eq 'restore_parameters' ) {
        $q = CGI::Simple->new( @_ );
        return;
      }
      else {
        $q = CGI::Simple->new;
      }
    }

   # hack the symbol table and insert the sub so we only use loader once
   # get strict to look the other way while we use sym refs
    no strict 'refs';

    # stop warnings screaming about redefined subs
    local $^W = 0;

   # hack to ensure %in ends in right package when exported by ReadParse
    @_ = ( *{"${package}::in"} ) if $sub eq 'ReadParse' and !@_;

    # write the required sub to the callers symbol table
    *{"${package}::$sub"} = sub { $q->$sub( @_ ) };

 # now we have inserted the sub let's call it and return the results :-)
    return &{"${package}::$sub"};
  }
}

1;

=head1 NAME

CGI::Simple::Standard - a wrapper module for CGI::Simple that provides a
function style interface

=head1 SYNOPSIS

    use CGI::Simple::Standard qw( -autoload );
    use CGI::Simple::Standard qw( :core :cookie :header :misc );
    use CGI::Simple::Standard qw( param upload );

    $CGI::Simple::Standard::POST_MAX = 1024;       # max upload via post 1kB
    $CGI::Simple::Standard::DISABLE_UPLOADS = 0;   # enable uploads

    @params = param();        # return all param names as a list
    $value =  param('foo');   # return the first value supplied for 'foo'
    @values = param('foo');   # return all values supplied for foo

    %fields   = Vars();       # returns untied key value pair hash
    $hash_ref = Vars();       # or as a hash ref
    %fields   = Vars("|");    # packs multiple values with "|" rather than "\0";

    @keywords = keywords();   # return all keywords as a list

    param( 'foo', 'some', 'new', 'values' );        # set new 'foo' values
    param( -name=>'foo', -value=>'bar' );
    param( -name=>'foo', -value=>['bar','baz'] );

    append( -name=>'foo', -value=>'bar' );          # append values to 'foo'
    append( -name=>'foo', -value=>['some', 'new', 'values'] );

    Delete('foo');   # delete param 'foo' and all its values
    Delete_all();    # delete everything

    <INPUT TYPE="file" NAME="upload_file" SIZE="42">

    $files    = upload()                   # number of files uploaded
    @files    = upload();                  # names of all uploaded files
    $filename = param('upload_file')       # filename of 'upload_file' field
    $mime     = upload_info($filename,'mime'); # MIME type of uploaded file
    $size     = upload_info($filename,'size'); # size of uploaded file

    my $fh = $q->upload($filename);     # open filehandle to read from
    while ( read( $fh, $buffer, 1024 ) ) { ... }

    # short and sweet upload
    $ok = upload( param('upload_file'), '/path/to/write/file.name' );
    print "Uploaded ".param('upload_file')." and wrote it OK!" if $ok;

    $decoded    = url_decode($encoded);
    $encoded    = url_encode($unencoded);
    $escaped    = escapeHTML('<>"&');
    $unescaped  = unescapeHTML('&lt;&gt;&quot;&amp;');

    $qs = query_string();   # get all data in $q as a query string OK for GET

    no_cache(1);            # set Pragma: no-cache + expires
    print header();         # print a simple header
    # get a complex header
    $header = header(   -type       => 'image/gif'
                        -nph        => 1,
                        -status     => '402 Payment required',
                        -expires    =>'+24h',
                        -cookie     => $cookie,
                        -charset    => 'utf-7',
                        -attachment => 'foo.gif',
                        -Cost       => '$2.00');

    @cookies = cookie();        # get names of all available cookies
    $value   = cookie('foo')    # get first value of cookie 'foo'
    @value   = cookie('foo')    # get all values of cookie 'foo'
    # get a cookie formatted for header() method
    $cookie  = cookie(  -name    => 'Password',
                        -values  => ['superuser','god','my dog woofie'],
                        -expires => '+3d',
                        -domain  => '.nowhere.com',
                        -path    => '/cgi-bin/database',
                        -secure  => 1 );
    print header( -cookie=>$cookie );       # set cookie

    print redirect('http://go.away.now');   # print a redirect header

    dienice( cgi_error() ) if cgi_error();

=head1 DESCRIPTION

This module is a wrapper for the completely object oriented CGI::Simple
module and provides a simple functional style interface. It provides two
different methods to import function names into your namespace.

=head2 Autoloading

If you specify the '-autoload' pragma like this:

    use CGI::Simple::Standard qw( -autoload );

Then it will use AUTOLOAD and a symbol table trick to export only those subs
you actually call into your namespace. When you specify the '-autoload' pragma
this module exports a single AUTOLOAD subroutine into you namespace. This will
clash with any AUTOLOAD sub that exists in the calling namespace so if you are
using AUTOLOAD for something else don't use this pragma.

Anyway, when you call a subroutine that is not defined in your script this
AUTOLOAD sub will be called. The first time this happens it
will initialize a CGI::Simple object and then apply the requested method
(if it exists) to it. A fatal exception will be thrown if you try to use an
undefined method (function).

=head2 Specified Export

Alternatively you can specify the functions you wish to import. You can do
this on a per function basis like this:

    use CGI::Simple::Standard qw( param upload query_string Dump );

or utilize the %EXPORT_TAGS that group functions into related groups.
Here are the groupings:

  %EXPORT_TAGS = (
    ':html'     => [ qw(:misc) ],
    ':standard' => [ qw(:core :access) ],
    ':cgi'      => [ qw(:core :access) ],
    ':all'      => [ qw(:core :misc :cookie :header :push :debug :cgi-lib
                        :access :internal) ],
    ':core'     => [ qw(param add_param param_fetch url_param keywords
                        append Delete delete_all Delete_all upload
                        query_string parse_query_string  parse_keywordlist
                        Vars save_parameters restore_parameters) ],
    ':misc'     => [ qw(url_decode url_encode escapeHTML unescapeHTML put) ],
    ':cookie'   => [ qw(cookie raw_cookie) ],
    ':header'   => [ qw(header cache no_cache redirect) ],
    ':push'     => [ qw(multipart_init multipart_start multipart_end
                        multipart_final) ],
    ':debug'    => [ qw(Dump as_string cgi_error _cgi_object) ],
    ':cgi-lib'  => [ qw(ReadParse SplitParam MethGet MethPost MyBaseUrl MyURL
                        MyFullUrl PrintHeader HtmlTop HtmlBot PrintVariables
                        PrintEnv CgiDie CgiError Vars) ],
    ':ssl'      => [ qw(https) ],
    ':access'   => [ qw(version nph all_parameters charset crlf globals
                        auth_type content_length content_type document_root
                        gateway_interface path_translated referer remote_addr
                        remote_host remote_ident remote_user request_method
                        script_name server_name server_port server_protocol
                        server_software user_name user_agent virtual_host
                        path_info Accept http https protocol url self_url
                        state) ],
    ':internal' => [ qw(_initialize_globals _use_cgi_pm_global_settings
                        _store_globals _reset_globals) ]
    );


The familiar CGI.pm tags are available but do not include the HTML
functionality. You specify the import of some function groups like this:

use CGI::Simple::Standard qw( :core :cookie :header );

Note that the function groups all start with a : char.

=head2 Mix and Match

You can use the '-autoload' pragma, specifically named function imports and
tag group imports together if you desire.

=head1 $POST_MAX and $DISABLE_UPLOADS

If you wish to set $POST_MAX or $DISABLE_UPLOADS you must do this *after* the
use statement and *before* the first function call as shown in the synopsis.

Unlike CGI.pm uploads are disabled by default and the maximum acceptable
data via post is capped at 102_400kB rather than infinity. This is specifically
to avoid denial of service attacks by default. To enable uploads and to
allow them to be of infinite size you simply:

    $CGI::Simple::Standard::POST_MAX = -1;         # infinite size upload
    $CGI::Simple::Standard::$DISABLE_UPLOADS = 0;  # enable uploads

Alternatively you can specify the CGI.pm default values as shown above by
specifying the '-default' pragma in your use statement.

    use CGI::Simple::Standard qw( -default ..... );

=head1 EXPORT

Nothing by default.

Under the '-autoload' pragma the AUTOLOAD subroutine is
exported into the calling namespace. Additional subroutines are only imported
into this namespace if you physically call them. They are installed in the
symbol table the first time you use them to save repeated calls to AUTOLOAD.

If you specifically request a function or group of functions via an EXPORT_TAG
then stubs of these functions are exported into the calling namespace. These
stub functions will be replaced with the real functions only if you actually
call them saving wasted compilation effort.

=head1 FUNCTION DETAILS

This is a wrapper module for CGI::Simple. Virtually all the methods available
in the OO interface are available via the functional interface. Several
method names are aliased to prevent namespace conflicts:

    $q->delete('foo')   =>  Delete('foo')
    $q->delete_all      =>  Delete_all() or delete_all()
    $q->save(\*FH)      =>  save_parameters(\*FH)
    $q->accept()        =>  Accept()

Although you could use the new() function to genrate new OO CGI::Simple
objects the restore_parameters() function is a better choice as it operates
like new but on the correct underlying CGI::Simple object for the functional
interface.

restore_parameters() can be used exactly as you might use new() in that
you can supply arguments to it such as query strings, hashes and file handles
to re-initialize your underlying object.

    $q->new CGI::Simple()                => restore_parameters()
    $q->new CGI::Simple({foo=>'bar'})    => restore_parameters({foo=>'bar'})
    $q->new CGI::Simple($query_string)   => restore_parameters($query_string)
    $q->new CGI::Simple(\*FH)            => restore_parameters(\*FH)

For full details of the available functions see the CGI::Simple docs. Just
remove the $q-> part and use the method name directly.

=head1 BUGS

As this is 0.01 there are almost bound to be some.

=head1 AUTHOR

Dr James Freeman E<lt>jfreeman@tassie.net.auE<gt>
This release by Andy Armstrong <andy@hexten.net>

This package is free software and is provided "as is" without express or
implied warranty. It may be used, redistributed and/or modified under the terms
of the Perl Artistic License (see http://www.perl.com/perl/misc/Artistic.html)

Address bug reports and comments to: andy@hexten.net

=head1 CREDITS

The interface and key sections of the CGI::Simple code come from
CGI.pm by Lincoln Stein.

=head1 SEE ALSO

L<CGI::Simple> which is the back end for this module,
B<CGI.pm by Lincoln Stein>

=cut

