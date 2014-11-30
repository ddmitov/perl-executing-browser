package CGI::Simple::Cookie;

# Original version Copyright 1995-1999, Lincoln D. Stein. All rights reserved.
# It may be used and modified freely, but I do request that this copyright
# notice remain attached to the file.  You may modify this module as you
# wish, but if you redistribute a modified version, please attach a note
# listing the modifications you have made.

# This version Copyright 2001, Dr James Freeman. All rights reserved.
# Renamed, strictified, and generally hacked code. Now 30% shorter.
# Interface remains identical and passes all original CGI::Cookie tests

use strict;
use vars '$VERSION';
$VERSION = '1.114';
use CGI::Simple::Util qw(rearrange unescape escape);
use overload '""' => \&as_string, 'cmp' => \&compare, 'fallback' => 1;

# fetch a list of cookies from the environment and return as a hash.
# the cookies are parsed as normal escaped URL data.
sub fetch {
  my $self = shift;
  my $raw_cookie = $ENV{HTTP_COOKIE} || $ENV{COOKIE};
  return () unless $raw_cookie;
  return $self->parse( $raw_cookie );
}

sub parse {
  my ( $self, $raw_cookie ) = @_;
  return () unless $raw_cookie;
  my %results;
  my @pairs = split "[;,] ?", $raw_cookie;
  for my $pair ( @pairs ) {
    # trim leading trailing whitespace
    $pair =~ s/^\s+//;
    $pair =~ s/\s+$//;
    my ( $key, $value ) = split( "=", $pair, 2 );
    next if !defined( $value );
    my @values = ();
    if ( $value ne '' ) {
      @values = map unescape( $_ ), split( /[&;]/, $value . '&dmy' );
      pop @values;
    }
    $key = unescape( $key );

    # A bug in Netscape can cause several cookies with same name to
    # appear.  The FIRST one in HTTP_COOKIE is the most recent version.
    $results{$key} ||= $self->new( -name => $key, -value => \@values );
  }
  return wantarray ? %results : \%results;
}

# fetch a list of cookies from the environment and return as a hash.
# the cookie values are not unescaped or altered in any way.
sub raw_fetch {
  my $raw_cookie = $ENV{HTTP_COOKIE} || $ENV{COOKIE};
  return () unless $raw_cookie;
  my %results;
  my @pairs = split "; ?", $raw_cookie;
  for my $pair ( @pairs ) {
    $pair =~ s/^\s+|\s+$//;    # trim leading trailing whitespace
    my ( $key, $value ) = split "=", $pair;

    # fixed bug that does not allow 0 as a cookie value thanks Jose Mico
    # $value ||= 0;
    $value = defined $value ? $value : '';
    $results{$key} = $value;
  }
  return wantarray ? %results : \%results;
}

sub new {
  my ( $class, @params ) = @_;
  $class = ref( $class ) || $class;
  my (
    $name,   $value,   $path,    $domain,
    $secure, $expires, $max_age, $httponly
   )
   = rearrange(
    [
      'NAME', [ 'VALUE', 'VALUES' ],
      'PATH',    'DOMAIN',
      'SECURE',  'EXPIRES',
      'MAX-AGE', 'HTTPONLY'
    ],
    @params
   );
  return undef unless defined $name and defined $value;
  my $self = {};
  bless $self, $class;
  $self->name( $name );
  $self->value( $value );
  $path ||= "/";
  $self->path( $path )         if defined $path;
  $self->domain( $domain )     if defined $domain;
  $self->secure( $secure )     if defined $secure;
  $self->expires( $expires )   if defined $expires;
  $self->max_age( $expires )   if defined $max_age;
  $self->httponly( $httponly ) if defined $httponly;
  return $self;
}

sub as_string {
  my $self = shift;
  return "" unless $self->name;
  my $name   = escape( $self->name );
  my $value  = join "&", map { escape( $_ ) } $self->value;
  my @cookie = ( "$name=$value" );
  push @cookie, "domain=" . $self->domain   if $self->domain;
  push @cookie, "path=" . $self->path       if $self->path;
  push @cookie, "expires=" . $self->expires if $self->expires;
  push @cookie, "max-age=" . $self->max_age if $self->max_age;
  push @cookie, "secure"                    if $self->secure;
  push @cookie, "HttpOnly"                  if $self->httponly;
  return join "; ", @cookie;
}

sub compare {
  my ( $self, $value ) = @_;
  return "$self" cmp $value;
}

# accessors subs
sub name {
  my ( $self, $name ) = @_;
  $self->{'name'} = $name if defined $name;
  return $self->{'name'};
}

sub value {
  my ( $self, $value ) = @_;
  if ( defined $value ) {
    my @values
     = ref $value eq 'ARRAY' ? @$value
     : ref $value eq 'HASH'  ? %$value
     :                         ( $value );
    $self->{'value'} = [@values];
  }
  return wantarray ? @{ $self->{'value'} } : $self->{'value'}->[0];
}

sub domain {
  my ( $self, $domain ) = @_;
  $self->{'domain'} = $domain if defined $domain;
  return $self->{'domain'};
}

sub secure {
  my ( $self, $secure ) = @_;
  $self->{'secure'} = $secure if defined $secure;
  return $self->{'secure'};
}

sub expires {
  my ( $self, $expires ) = @_;
  $self->{'expires'} = CGI::Simple::Util::expires( $expires, 'cookie' )
   if defined $expires;
  return $self->{'expires'};
}

sub max_age {
  my ( $self, $max_age ) = @_;
  $self->{'max-age'}
   = CGI::Simple::Util::_expire_calc( $max_age ) - time()
   if defined $max_age;
  return $self->{'max-age'};
}

sub path {
  my ( $self, $path ) = @_;
  $self->{'path'} = $path if defined $path;
  return $self->{'path'};
}

sub httponly {
  my ( $self, $httponly ) = @_;
  $self->{'httponly'} = $httponly if defined $httponly;
  return $self->{'httponly'};
}

1;

__END__

=head1 NAME

CGI::Simple::Cookie - Interface to HTTP cookies

=head1 SYNOPSIS

    use CGI::Simple::Standard qw(header);
    use CGI::Simple::Cookie;

    # Create new cookies and send them
    $cookie1 = CGI::Simple::Cookie->new( -name=>'ID', -value=>123456 );
    $cookie2 = CGI::Simple::Cookie->new( -name=>'preferences',
                                        -value=>{ font => Helvetica,
                                                  size => 12 }
                                      );
    print header( -cookie=>[$cookie1,$cookie2] );

    # fetch existing cookies
    %cookies = CGI::Simple::Cookie->fetch;
    $id = $cookies{'ID'}->value;

    # create cookies returned from an external source
    %cookies = CGI::Simple::Cookie->parse($ENV{COOKIE});

=head1 DESCRIPTION

CGI::Simple::Cookie is an interface to HTTP/1.1 cookies, a mechanism
that allows Web servers to store persistent information on the browser's
side of the connection. Although CGI::Simple::Cookie is intended to be
used in conjunction with CGI::Simple (and is in fact used by it
internally), you can use this module independently.

For full information on cookies see:

	http://tools.ietf.org/html/rfc2109
	http://tools.ietf.org/html/rfc2965

=head1 USING CGI::Simple::Cookie

CGI::Simple::Cookie is object oriented.  Each cookie object has a name
and a value.  The name is any scalar value.  The value is any scalar or
array value (associative arrays are also allowed).  Cookies also have
several optional attributes, including:

=over 4

=item B<1. expiration date>

The expiration date tells the browser how long to hang on to the
cookie.  If the cookie specifies an expiration date in the future, the
browser will store the cookie information in a disk file and return it
to the server every time the user reconnects (until the expiration
date is reached).  If the cookie species an expiration date in the
past, the browser will remove the cookie from the disk file.  If the
expiration date is not specified, the cookie will persist only until
the user quits the browser.

=item B<2. domain>

This is a partial or complete domain name for which the cookie is
valid.  The browser will return the cookie to any host that matches
the partial domain name.  For example, if you specify a domain name
of ".capricorn.com", then the browser will return the cookie to
web servers running on any of the machines "www.capricorn.com",
"ftp.capricorn.com", "feckless.capricorn.com", etc.  Domain names
must contain at least two periods to prevent attempts to match
on top level domains like ".edu".  If no domain is specified, then
the browser will only return the cookie to servers on the host the
cookie originated from.

=item B<3. path>

If you provide a cookie path attribute, the browser will check it
against your script's URL before returning the cookie.  For example,
if you specify the path "/cgi-bin", then the cookie will be returned
to each of the scripts "/cgi-bin/tally.pl", "/cgi-bin/order.pl", and
"/cgi-bin/customer_service/complain.pl", but not to the script
"/cgi-private/site_admin.pl".  By default, the path is set to "/", so
that all scripts at your site will receive the cookie.

=item B<4. secure flag>

If the "secure" attribute is set, the cookie will only be sent to your
script if the CGI request is occurring on a secure channel, such as SSL.

=item B<4. HttpOnly flag>

If the "httponly" attribute is set, the cookie will only be accessible
through HTTP Requests. This cookie will be inaccessible via JavaScript
(to prevent XSS attacks).

See this URL for more information including supported browsers:

L<http://www.owasp.org/index.php/HTTPOnly>

=back

=head2 Creating New Cookies

    $c = CGI::Simple::Cookie->new( -name    =>  'foo',
                                  -value   =>  'bar',
                                  -expires =>  '+3M',
                                  -domain  =>  '.capricorn.com',
                                  -path    =>  '/cgi-bin/database',
                                  -secure  =>  1
                                );

Create cookies from scratch with the B<new> method.  The B<-name> and
B<-value> parameters are required.  The name must be a scalar value.
The value can be a scalar, an array reference, or a hash reference.
(At some point in the future cookies will support one of the Perl
object serialization protocols for full generality).

B<-expires> accepts any of the relative or absolute date formats
recognized by CGI::Simple, for example "+3M" for three months in the
future.  See CGI::Simple's documentation for details.

B<-max-age> accepts the same data formats as B<< -expires >>, but sets a
relative value instead of an absolute like B<< -expires >>. This is intended to be
more secure since a clock could be changed to fake an absolute time. In
practice, as of 2011, C<< -max-age >> still does not enjoy the widespread support
that C<< -expires >> has. You can set both, and browsers that support
C<< -max-age >> should ignore the C<< Expires >> header. The drawback
to this approach is the bit of bandwidth for sending an extra header on each cookie.

B<-domain> points to a domain name or to a fully qualified host name.
If not specified, the cookie will be returned only to the Web server
that created it.

B<-path> points to a partial URL on the current server.  The cookie
will be returned to all URLs beginning with the specified path.  If
not specified, it defaults to '/', which returns the cookie to all
pages at your site.

B<-secure> if set to a true value instructs the browser to return the
cookie only when a cryptographic protocol is in use.

B<-httponly> if set to a true value, the cookie will not be accessible
via JavaScript.

=head2 Sending the Cookie to the Browser

Within a CGI script you can send a cookie to the browser by creating
one or more Set-Cookie: fields in the HTTP header.  Here is a typical
sequence:

    $c = CGI::Simple::Cookie->new( -name    =>  'foo',
                                   -value   =>  ['bar','baz'],
                                   -expires =>  '+3M'
                                  );

    print "Set-Cookie: $c\n";
    print "Content-Type: text/html\n\n";

To send more than one cookie, create several Set-Cookie: fields.
Alternatively, you may concatenate the cookies together with "; " and
send them in one field.

If you are using CGI::Simple, you send cookies by providing a -cookie
argument to the header() method:

  print header( -cookie=>$c );

Mod_perl users can set cookies using the request object's header_out()
method:

  $r->header_out('Set-Cookie',$c);

Internally, Cookie overloads the "" operator to call its as_string()
method when incorporated into the HTTP header.  as_string() turns the
Cookie's internal representation into an RFC-compliant text
representation.  You may call as_string() yourself if you prefer:

    print "Set-Cookie: ",$c->as_string,"\n";

=head2 Recovering Previous Cookies

    %cookies = CGI::Simple::Cookie->fetch;

B<fetch> returns an associative array consisting of all cookies
returned by the browser.  The keys of the array are the cookie names.  You
can iterate through the cookies this way:

    %cookies = CGI::Simple::Cookie->fetch;
    foreach (keys %cookies) {
        do_something($cookies{$_});
    }

In a scalar context, fetch() returns a hash reference, which may be more
efficient if you are manipulating multiple cookies.

CGI::Simple uses the URL escaping methods to save and restore reserved
characters in its cookies.  If you are trying to retrieve a cookie set by
a foreign server, this escaping method may trip you up.  Use raw_fetch()
instead, which has the same semantics as fetch(), but performs no unescaping.

You may also retrieve cookies that were stored in some external
form using the parse() class method:

       $COOKIES = `cat /usr/tmp/Cookie_stash`;
       %cookies = CGI::Simple::Cookie->parse($COOKIES);

=head2 Manipulating Cookies

Cookie objects have a series of accessor methods to get and set cookie
attributes.  Each accessor has a similar syntax.  Called without
arguments, the accessor returns the current value of the attribute.
Called with an argument, the accessor changes the attribute and
returns its new value.

=over 4

=item B<name()>

Get or set the cookie's name.  Example:

    $name = $c->name;
    $new_name = $c->name('fred');

=item B<value()>

Get or set the cookie's value.  Example:

    $value = $c->value;
    @new_value = $c->value(['a','b','c','d']);

B<value()> is context sensitive.  In a list context it will return
the current value of the cookie as an array.  In a scalar context it
will return the B<first> value of a multivalued cookie.

=item B<domain()>

Get or set the cookie's domain.

=item B<path()>

Get or set the cookie's path.

=item B<expires()>

Get or set the cookie's expiration time.

=item B<max_age()>

Get or set the cookie's maximum age.

=item B<secure()>

Get or set the cookie's secure flag.

=item B<httponly()>

Get or set the cookie's HttpOnly flag.

=back


=head1 AUTHOR INFORMATION

Original version copyright 1997-1998, Lincoln D. Stein.  All rights reserved.
Originally copyright 2001 Dr James Freeman E<lt>jfreeman@tassie.net.auE<gt>
This release by Andy Armstrong <andy@hexten.net>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Address bug reports and comments to: andy@hexten.net

=head1 BUGS

This section intentionally left blank :-)

=head1 SEE ALSO

L<CGI::Carp>, L<CGI::Simple>

=cut
