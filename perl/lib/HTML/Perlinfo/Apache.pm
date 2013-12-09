package HTML::Perlinfo::Apache;

use warnings;
use strict;
use HTML::Perlinfo::Common;



sub new {
    my %apache;
    my $env  = ( $ENV{SERVER_SOFTWARE} || "" ) =~ /apache/i;
    my $mp   = exists $ENV{MOD_PERL};
    $apache{'env'}  = $env;
    $apache{'mp'}   = $mp;
    bless \%apache;
}

sub has {
    my ( $self, @opts ) = @_;
		for my $opt (@opts) {
			return 0 unless $self->{$opt};
		}
    return 1;
}

sub print_apache {
	
	my $self = shift;
        my @mods;
	my  ($version, $hostname, $port, $mp_status) = ("<i>Not detected</i>") x 7;

	$mp_status = 'enabled' if $self->has qw(mp);
	
	  ($version) = $ENV{'SERVER_SOFTWARE'} =~ /(\d+[\.\d]*)/ 
				if (defined $ENV{'SERVER_SOFTWARE'} && $ENV{'SERVER_SOFTWARE'} =~ /\d+[\.\d]*/); 
	

	return join '', print_table_row(2, "Apache Version", "$version"),
                        (defined($ENV{'SERVER_NAME'}) && defined($ENV{'SERVER_PORT'})) ?
			print_table_row(2, "Hostname:Port", "$ENV{'SERVER_NAME'} : $ENV{'SERVER_PORT'}"):
			print_table_row(2, "Hostname:Port", "$hostname : $port"),
			print_table_row(2, "mod_perl", "$mp_status");
}

sub print_modperl {

	my ($version_status, $version_number) = ("<i>Not detected</i>") x 3;

	  $version_status = '1.0';
          $version_status = '2.0 or higher' if $ENV{MOD_PERL_API_VERSION} && $ENV{MOD_PERL_API_VERSION} == 2;
          ($version_number) = $ENV{MOD_PERL} =~ /^\S+\/(\d+(?:[\.\_]\d+)+)/;
	  $version_number =~ s/_//g;
          $version_number =~ s/(\.[^.]+)\./$1/g;
	  unless ($version_status eq '2.0 or higher') {
	    if ( $version_number >= 1.9901 ) {
                 $version_status = '1.9 which is incompatible with 2.0';
            }
	  } 	
	  
	 return join '', print_box_start(0),  
		"Running under mod_perl version $version_status (version number: $version_number)",
			 print_box_end(); 

}

sub print_apache_environment {


	return join '', print_table_row(2, "DOCUMENT_ROOT", $ENV{'DOCUMENT_ROOT'}), 
			print_table_row(2, "HTTP_ACCEPT", $ENV{'HTTP_ACCEPT'}),
			print_table_row(2, "HTTP_ACCEPT_CHARSET", $ENV{'HTTP_ACCEPT_CHARSET'}),
			print_table_row(2, "HTTP_ACCEPT_ENCODING", $ENV{'HTTP_ACCEPT_ENCODING'}),
			print_table_row(2, "HTTP_ACCEPT_LANGUAGE", $ENV{'HTTP_ACCEPT_LANGUAGE'}),
			print_table_row(2, "HTTP_CONNECTION", $ENV{'HTTP_CONNECTION'}),
			print_table_row(2, "HTTP_HOSTS", $ENV{'HTTP_HOSTS'}),
			print_table_row(2, "HTTP_KEEP_ALIVE", $ENV{'HTTP_KEEP_ALIVE'}),
			print_table_row(2, "HTTP_USER_AGENT", $ENV{'HTTP_USER_AGENT'}),
			print_table_row(2, "PATH", $ENV{'PATH'}),
			print_table_row(2, "REMOTE_ADDR", $ENV{'REMOTE_ADDR'}),
			print_table_row(2, "REMOTE_HOST", $ENV{'REMOTE_HOST'}),
			print_table_row(2, "REMOTE_PORT", $ENV{'REMOTE_PORT'}),
			print_table_row(2, "SCRIPT_FILENAME", $ENV{'SCRIPT_FILENAME'}),
			print_table_row(2, "SCRIPT_URI", $ENV{'SCRIPT_URI'}),
			print_table_row(2, "SCRIPT_URL", $ENV{'SCRIPT_URL'}),
			print_table_row(2, "SERVER_ADDR", $ENV{'SERVER_ADDR'}),
			print_table_row(2, "SERVER_ADMIN", $ENV{'SERVER_ADMIN'}),
			print_table_row(2, "SERVER_NAME", $ENV{'SERVER_NAME'}),
			print_table_row(2, "SERVER_PORT", $ENV{'SERVER_PORT'}),
			print_table_row(2, "SERVER_SIGNATURE", $ENV{'SERVER_SIGNATURE'}),
			print_table_row(2, "SERVER_SOFTWARE", $ENV{'SERVER_SOFTWARE'}),
			print_table_row(2, "GATEWAY_INTERFACE", $ENV{'GATEWAY_INTERFACE'}),
			print_table_row(2, "SERVER_PROTOCOL", $ENV{'SERVER_PROTOCOL'}),
			print_table_row(2, "REQUEST_METHOD", $ENV{'REQUEST_METHOD'}),
			print_table_row(2, "QUERY_STRING", $ENV{'QUERY_STRING'}),
			print_table_row(2, "REQUEST_URI", $ENV{'REQUEST_URI'}),
			print_table_row(2, "SCRIPT_NAME", $ENV{'SCRIPT_NAME'});  

}
1;

