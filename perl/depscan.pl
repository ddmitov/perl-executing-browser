#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;

use Config;
use Module::ScanDeps;
use Cwd qw (getcwd abs_path);
use File::Copy::Recursive qw (fcopy);
use Archive::Zip qw (:ERROR_CODES :CONSTANTS);
use File::Path qw (rmtree);
use File::Basename qw (fileparse);

my $slash = "/";
my $dir = getcwd;
my $base_dir = "test";

if (defined $ARGV[0]) {
	fcopy ($^X, $dir.$slash.$base_dir.$slash."bin".$slash."perl") or die "File copying error!\n";

	if ($Config{osname} =~ "linux") {
		my @libraries = `ldd $^X`;
		foreach my $line (@libraries) {
			chomp $line;
			if ($line =~ /libperl/) {
				$line =~ s/.*\s\//\//;
				$line =~ s/\s\(.*//;
				my $libperl_path = $line;
				print "\nlibperl path: $libperl_path\n";
				my $real_libperl_path;
				# http://stackoverflow.com/questions/4887672/how-to-get-the-absolute-path-for-symlink-file
				# http://stackoverflow.com/questions/1373001/how-can-i-resolve-a-symbolic-link-in-perl
				if (-l $libperl_path) {
					$real_libperl_path = abs_path ($libperl_path);
				}
				print "libperl real path: $real_libperl_path\n";
				$line =~ s/\/.*\///;
				my $libperl_name = $line;
				print "libperl name: $libperl_name\n\n";
				fcopy ($real_libperl_path, $dir.$slash.$base_dir.$slash."bin".$slash.$libperl_name) or die "File copying error!\n";
			}
		}
	}

	print "Scanning modules...\n";

	# http://www.perlmonks.org/?node_id=982572
	my $hash_ref = scan_deps (files => [$ARGV[0]], recurse => 1);

	my $module_counter;
	while (my ($partial_path, $module_name) = each (%{$hash_ref})) {
		foreach my $include_path (@INC) {
			my $module_full_path = $include_path.$slash.$partial_path;
			if (-e $module_full_path) {
				$module_counter++;
				print "Module file Nr. $module_counter included: $module_full_path\n";
				# http://stackoverflow.com/questions/229357/what-is-the-best-way-in-perl-to-copy-files-into-a-yet-to-be-created-directory-tr
				fcopy ($module_full_path, $dir.$slash.$base_dir.$slash."lib".$slash.$partial_path) or die "File copying error!\n";
			}
		}
	}

	#~ my $zip = Archive::Zip->new();
	#~ my $dir_member = $zip->addTree ($base_dir.$slash, $base_dir);
	#~ my $script_base_name = fileparse ($ARGV[0], qr/\.[^.]*/);
	#~ my $package_name = $dir.$slash.$script_base_name.".peb";
	#~ print "Package name: $package_name\n";
	#~ unless ($zip->writeToFileNamed ($package_name) == AZ_OK) {
		#~ die "Archive creation error!\n";
	#~ }
	#~ # http://www.perlmonks.org/?node_id=602793
	#~ rmtree ($dir.$slash.$base_dir);

	print "Dependencies sucessfully collected!\n\n";
} else {
	print "\nNo file given as command line argument. Aborting!\n\n";
	exit;
}
