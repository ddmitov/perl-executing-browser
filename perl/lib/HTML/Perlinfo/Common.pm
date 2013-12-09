package HTML::Perlinfo::Common;

our @ISA = qw(Exporter);
our @EXPORT = qw(initialize_globals print_table_colspan_header print_table_row print_table_color_start print_table_color_end print_color_box print_table_row_color print_table_start print_table_end print_box_start print_box_end print_hr print_table_header print_section print_license add_link check_path check_args check_module_args perl_version release_date process_args error_msg match_string);
require Exporter;

use Carp ();

our %links;

%links = ( 
 'all'   => 1,
 'local' => 0,
 'docs'  => 1,
);


##### The following is lifted from File::Which 0.05 by Per Einar Ellefsen. 
##### The check_path sub uses the which sub.
#############
use File::Spec;

my $Is_VMS    = ($^O eq 'VMS');
my $Is_MacOS  = ($^O eq 'MacOS');
my $Is_DOSish = (($^O eq 'MSWin32') or
                ($^O eq 'dos')     or
                ($^O eq 'os2'));

# For Win32 systems, stores the extensions used for
# executable files
# For others, the empty string is used
# because 'perl' . '' eq 'perl' => easier
my @path_ext = ('');
if ($Is_DOSish) {
    if ($ENV{PATHEXT} and $Is_DOSish) {    # WinNT. PATHEXT might be set on Cygwin, but not used.
        push @path_ext, split ';', $ENV{PATHEXT};
    }
    else {
        push @path_ext, qw(.com .exe .bat); # Win9X or other: doesn't have PATHEXT, so needs hardcoded.
    }
}
elsif ($Is_VMS) { 
    push @path_ext, qw(.exe .com);
}

sub which {
    my ($exec) = @_;

    return undef unless $exec;

    my $all = wantarray;
    my @results = ();
    
    # check for aliases first
    if ($Is_VMS) {
        my $symbol = `SHOW SYMBOL $exec`;
        chomp($symbol);
        if (!$?) {
            return $symbol unless $all;
            push @results, $symbol;
        }
    }
    if ($Is_MacOS) {
        my @aliases = split /\,/, $ENV{Aliases};
        foreach my $alias (@aliases) {
            # This has not been tested!!
            # PPT which says MPW-Perl cannot resolve `Alias $alias`,
            # let's just hope it's fixed
            if (lc($alias) eq lc($exec)) {
                chomp(my $file = `Alias $alias`);
                last unless $file;  # if it failed, just go on the normal way
                return $file unless $all;
                push @results, $file;
                # we can stop this loop as if it finds more aliases matching,
                # it'll just be the same result anyway
                last;
            }
        }
    }

    my @path = File::Spec->path();
    unshift @path, File::Spec->curdir if $Is_DOSish or $Is_VMS or $Is_MacOS;

    for my $base (map { File::Spec->catfile($_, $exec) } @path) {
       for my $ext (@path_ext) {
            my $file = $base.$ext;

            if ((-x $file or    # executable, normal case
                 ($Is_MacOS ||  # MacOS doesn't mark as executable so we check -e
                  ($Is_DOSish and grep { $file =~ /$_$/i } @path_ext[1..$#path_ext])
                                # DOSish systems don't pass -x on non-exe/bat/com files.
                                # so we check -e. However, we don't want to pass -e on files
                                # that aren't in PATHEXT, like README.
                 and -e _)
                ) and !-d _)
            {                   # and finally, we don't want dirs to pass (as they are -x)


                    return $file unless $all;
                    push @results, $file;       # Make list to return later
            }
        }
    }
    
    if($all) {
        return @results;
    } else {
        return undef;
    }
}

## End File::Which code

sub check_path {
  
  return add_link('local', which("$_[0]")) if which("$_[0]");
  return "<i>not in path</i>";

}

sub match_string {
 my($module_name, $string) = @_;
 
 my $result = 0;
 my @string = (ref $string eq 'ARRAY') ? @$string : ($string); 
 foreach(@string) {
    $result = index(lc($module_name), lc($_));
    last if ($result != -1);
 }
 return ($result == -1) ? 0 : 1; 

}

sub perl_version {
  my $version;
  if ($] >= 5.006) {
    $version = sprintf "%vd", $^V;
  }
  else { # else time to update Perl!
    $version = "$]";
  }
  return $version;
}

sub release_date {

# when things escaped
  %released = (
    5.000    => '1994-10-17',
    5.001    => '1995-03-14',
    5.002    => '1996-02-96',
    5.00307  => '1996-10-10',
    5.004    => '1997-05-15',
    5.005    => '1998-07-22',
    5.00503  => '1999-03-28',
    5.00405  => '1999-04-29',
    5.006    => '2000-03-22',
    5.006001 => '2001-04-08',
    5.007003 => '2002-03-05',
    5.008    => '2002-07-19',
    5.008001 => '2003-09-25',
    5.009    => '2003-10-27',
    5.008002 => '2003-11-05',
    5.006002 => '2003-11-15',
    5.008003 => '2004-01-14',
    5.00504  => '2004-02-23',
    5.009001 => '2004-03-16',
    5.008004 => '2004-04-21',
    5.008005 => '2004-07-19',
    5.008006 => '2004-11-27',
    5.009002 => '2005-04-01',
    5.008007 => '2005-05-30',
    5.009003 => '2006-01-28',
    5.008008 => '2006-01-31',
    5.009004 => '2006-08-15',
    5.009005 => '2007-07-07',
    5.010000 => '2007-12-18',
   );
	
  # Do we have Module::Corelist
  eval{require Module::CoreList};
  if ($@) { # no
     return ($released{$]}) ? $released{$]} : "unknown";
  }
  else {    # yes
     return ($Module::CoreList::released{$]}) ? $Module::CoreList::released{$]} : "unknown";
  }	  
 
}

sub check_args { 

  my ($key, $value) = @_;
  my ($message, %allowed);
  @allowed{qw(docs local 0 1)} = ();

  if (not exists $allowed{$key}) {
    $message = "$key is an invalid links parameter";
  }
  elsif ($key =~ /(?:docs|local)/ && $value !~ /^(?:0|1)$/i) {
    $message = "$value is an invalid value for the $key parameter in the links attribute";
  }

  error_msg("$message") if $message;

}

sub check_module_args {

  my ($key, $value) = @_;
  my ($message, %allowed);
  @allowed{qw(from columns sort_by color link show_only section full_page show_inc show_dir files_in)} = ();

  if (not exists $allowed{$key}) {
    $message = "$key is an invalid print_modules parameter";
  }
  elsif ($key eq 'sort_by' && $value !~ /^(?:name|version)$/i) {
    $message = "$value is an invalid sort"; 
  }
  elsif ($key =~ /^(?:color|link|columns|files_in)$/ && ref($value) ne 'ARRAY') {
    $message = "The $key parameter value is not an array reference";
  }
  elsif ($key eq 'columns' && grep(!/^(?:name|version|desc|path|core)$/, @{$value})) {
    $message = "Invalid column name in the $key parameter";
  }
  elsif ($key eq 'color' && @{$value} <= 1) {
    $message = "You didn't specify a module to color";
  }
  elsif ($key eq 'link' && @{$value} <= 1 && $value->[0] != 0) {
    $message = "You didn't provide a URL for the $key parameter";
  }
  elsif ($key eq 'show_only' && (ref($value) ne 'ARRAY') && lc $value ne 'core') {
    $message = "$value is an invalid value for the $key parameter";
  }
  elsif ($key eq 'full_page' && $value != 0 && $value != 1 ) {
    $message = "$value is an invalid value for the $key parameter";
  }
  elsif ($key eq 'link' && ($value->[0] ne 'all' && $value->[0] != 0 && ref($value->[0]) ne 'ARRAY')) {
    $message = "Invalid first element in the $key parameter value";
  }
  error_msg("$message") if $message;
}



sub process_args {
  # This sub returns a hash ref containing param args
  my %params;
  my $sub  = pop @_ || die "No coderef provided\n"; # get the sub
  if (defined $_[0]) {
    while(my($key, $value) = splice @_, 0, 2) {
        $sub->($key, $value);
        if (exists $params{$key}){
           @key_value = ref(${$params{$key}}[0]) eq 'ARRAY' ? @{$params{$key}} : $params{$key};
           push @key_value,$value;
           $new_val = [@key_value];
           $params{$key} = $new_val;
        }
        else {
            $params{$key} = $value;
        }
    }
  } 
  return \%params; 
}

sub error_msg {
  local $Carp::CarpLevel = $Carp::CarpLevel + 1;
  Carp::croak "User error: $_[0]";
}

# HTML subs 

sub  print_table_colspan_header {
  
   	 return sprintf("<tr class=\"h\"><th colspan=\"%d\">%s</th></tr>\n", $_[0], $_[1]);  

  }

  sub print_table_row {
      
	 
	  my $num_cols = $_[0];
	  my $HTML = "<tr>";

	  for ($i=0; $i<$num_cols; $i++) {

		  $HTML .= sprintf("<td class=\"%s\">", ($i==0 ? "e" : "v" ));

		  my $row_element = $_[$i+1];
		  if ((not defined ($row_element)) || ($row_element !~ /\S/)) {
			  $HTML .= "<i>no value</i>";
		  } else {
			  my $elem_esc = $row_element;
			  $HTML .= "$elem_esc";

		  }

		  $HTML .= " </td>";

	  }

	  $HTML .=  "</tr>\n";
	  return $HTML;
	  
  }


 sub print_table_color_start {

 	return qq~<table class="modules" cellpadding=4 cellspacing=4 border=0 width="600"><tr>\n~;
 }

 sub print_table_color_end {

 	return '</tr></table>';
 }


 sub print_color_box {

	return  qq ~<td>
                      <table border=0>
                       <tr><td>
                          <table class="modules" border=0 width=50 height=50 align=left bgcolor="$_[0]">
                            <tr bgcolor="$_[0]"> 
				<td color="$_[0]">
				 &nbsp; 
				</td>
			    </tr>
                          </table>
                       </tr></td>
		       <tr><td><small>$_[1]</small></td></tr>
                      </table>
                    </td>~;
 }

 sub print_table_row_color {

  	  my $num_cols = $_[0];
          my $HTML = $_[1] ? "<tr bgcolor=\"$_[1]\">" : "<tr>";

          for ($i=0; $i<$num_cols; $i++) {

                  $HTML .= $_[1] ? "<td bgcolor=\"$_[1]\">" : sprintf("<td class=\"%s\">", ($i==0 ? "e" : "v" ));

                  my $row_element = $_[$i+2]; # start at the 2nd element
                  if ((not defined ($row_element)) || ($row_element !~ /\S/)) {
                          $HTML .= "<i>no value</i>";
                  } else {
                          my $elem_esc = $row_element;
                          $HTML .= "$elem_esc";

                  }

                  $HTML .= " </td>";

          }

          $HTML .=  "</tr>\n";
          return $HTML;
 }
 
  sub print_table_start {

	  return "<table border=\"0\" cellpadding=\"3\" width=\"600\">\n";

  }
  sub print_table_end {

	  return "</table><br />\n";

  }
  sub print_box_start {

	  my $HTML = print_table_start();	
	  $HTML .= ($_[0] == 1) ? "<tr class=\"h\"><td>\n" : "<tr class=\"v\"><td>\n";
	  return $HTML; 
  }


  sub print_box_end {
	  my $HTML = "</td></tr>\n";
	  $HTML .= print_table_end();
	  return $HTML;
  }

  sub print_hr {
	  return "<hr />\n";

  }


  sub print_table_header {

	  my($num_cols) = $_[0];
	  my $HTML = "<tr class=\"h\">";

	  my $i;		
	  for ($i=0; $i<$num_cols; $i++) {
		  my $row_element = $_[$i+1];
		  $row_element = " " if (!$row_element);
		  $HTML .=  "<th>$row_element</th>";
	  }

	  return "$HTML</tr>\n";
  }


  sub print_section  {

	  return "<h2>" . $_[0] . "</h2>\n"; 

  }

	

 sub print_perl_license {

	  return <<"END_OF_HTML";
<p>
This program is free software; you can redistribute it and/or modify it under the terms of
either the Artistic License or the GNU General Public License, which may be found in the Perl 5 source kit.
</p>

<p>
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
</p>
<p>
Complete documentation for Perl, including FAQ lists, should be found on
this system using `man perl' or `perldoc perl'.  If you have access to the
Internet, point your browser at @{[ add_link('same', 'http://www.perl.org/')]}, the Perl directory.
</p> 
END_OF_HTML

  }

sub print_license {

 return join '', print_section("Perl License"),
		       print_box_start(0),
		       print_perl_license(),
		       print_box_end();
}


sub add_link {

	my ($type, $value, $link) = @_;
	return $value unless $links{'all'};
    
	if ($type eq "cpan") {

	return $value if $link && $link->[0] =~ /^[0]$/;
	
	  if ($link) {
	    if (ref $link->[0] eq 'ARRAY' && ref $link->[1] ne 'ARRAY') {
	      foreach (@{$link->[0]}) {
	            if ($_ eq 'all' or match_string($value,$_)==1) {
		      return '<a href=' . $link->[1] . $value .
                                qq~ title="Click here to see $value documentation [Opens in a new window]"
                                target="_blank">$value</a> ~
		    }		
                }
	    }	
            elsif (ref $link->[0] eq 'ARRAY' && ref $link->[1] eq 'ARRAY'){
	       foreach my $lv (@$link) {
	          if (ref $lv->[0] eq 'ARRAY') {
	            foreach(@{$lv->[0]}) {		  
                     if ($_ eq 'all' or match_string($value,$_)==1) {	
                       return '<a href=' . $lv->[1] . $value .
                                qq~ title="Click here to see $value documentation [Opens in a new window]"
                                target="_blank">$value</a> ~
		     }
                    }		     
		  }
                  else {
		    if ($lv->[0] eq 'all' or match_string($value,$lv->[0])==1) {	
                       return '<a href=' . $lv->[1] . $value .
                                qq~ title="Click here to see $value documentation [Opens in a new window]"
                                target="_blank">$value</a> ~
		     }	
		  }
	      }
            }	      
            elsif ($link->[0] eq 'all' or match_string($value,$link->[0])==1) {
			return '<a href=' . $link->[1] . $value .  
				qq~ title="Click here to see $value documentation [Opens in a new window]" 
				target="_blank">$value</a> ~
 	    }
          }
		return qq~ <a href="http://search.cpan.org/perldoc?$value" 
		title="Click here to see $value on CPAN [Opens in a new window]" target="_blank">$value</a> ~;
	}
	elsif ($type eq "config") {
      		return $value unless $links{'docs'};
		my ($letter) = $value =~ /^(.)/;
		return  qq! <a href="http://search.cpan.org/~aburlison/Solaris-PerlGcc-1.3/config/5.006001/5.10/sparc/Config.pm#$letter">$value</a> !;
	}
	elsif ($type eq "local") {
	  return $value unless $links{'local'};
			return qq~ <a href="file://$value" title="Click here to see $value [Opens in a new window]" target="_blank">$value</a> ~;
	}
	elsif ($type eq "same") {
		return qq~ <a href="$value">$value</a> ~;
	}
}

1; 
