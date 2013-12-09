package HTML::Perlinfo::Loaded;
BEGIN { %Seen = %INC } 

use HTML::Perlinfo::Modules;

$VERSION = '1.02';

%INC = %Seen;
END { 
 
    delete $INC{'HTML/Perlinfo/Loaded.pm'};	
    my $m = HTML::Perlinfo::Modules->new(full_page=>0, title=>'perlinfo(INFO_LOADED)');
    $m->print_htmlhead; 
    $m->print_modules('files_in'=>[values %INC],'section'=>'Loaded Modules');
    print $m->info_variables,"</div></body></html>";
}

1;
__END__
=pod

=head1 NAME

HTML::Perlinfo::Loaded - Post-execution HTML dump of loaded modules and environment variables

=head1 SYNOPSIS

    #!/usr/bin/perl
    use HTML::Perlinfo::Loaded;
    ...

=head1 DESCRIPTION

This module installs an at-exit handler to generate an HTML dump of all the module files used by a Perl program. As an added bonus, environment variables are also included in this dump. When used under mod_perl, the module will show you preloaded modules in the HTML page too.

Since the "dump" is a complete HTML page, this module is a good debugging tool for Web applications. Just make sure you print the content-type header beforehand or you will get an internal server error (malformed header).   

Note that the HTML::Perlinfo function 'perlinfo' has an option called INFO_LOADED that will produce the same result. In other words, there is more than one way to do it! Observe:

    use HTML::Perlinfo;

    perlinfo(INFO_LOADED);

The result will be the same if you say:

    #!/usr/bin/perl
    use HTML::Perlinfo::Loaded;
    ...

There is no difference, except using the perlinfo option gives you greater control. You could always control HTML::Perlinfo::Loaded with a pound sign (a comment on/off), but if you are using mod_perl it makes more sense to add HTML::Perlinfo to your startup file and then call perlinfo(INFO_LOADED) when you want to dump.

=head1 SEE ALSO

L<Devel::Loaded>, L<HTML::Perlinfo::Modules>, L<HTML::Perlinfo>, L<perlinfo>

=head1 AUTHOR

Mike Accardo <accardo@cpan.org>

=head1 COPYRIGHT

   Copyright (c) 2008, Mike Accardo. All Rights Reserved.
 This module is free software. It may be used, redistributed
and/or modified under the terms of the Perl Artistic License.

=cut
