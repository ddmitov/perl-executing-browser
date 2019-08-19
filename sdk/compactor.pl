
# This file must be executed by the appimage-maker.sh script!

use strict;
use warnings;
use 5.010;

use Cwd qw(getcwd);
use File::Basename qw(basename);
use File::Copy;
use File::Spec;
use File::Spec::Functions qw(catdir);
use FindBin qw($Bin);
use Getopt::Long qw(GetOptions);
use lib catdir($Bin, "lib");

# Non-core CPAN modules:
# File::Copy::Recursive and Module::ScanDeps are loaded from
# the 'lib' subdirectory of the directory of this script:
use File::Copy::Recursive qw(fcopy);
use Module::ScanDeps;

# Command-line argument:
my $appimage_name = "";
GetOptions("appimage_name=s" => \$appimage_name);

# Directory paths:
my $root = getcwd;
my $app_directory = catdir($root, "resources", "app");
my $perl_original = catdir($root, "resources", "perl");
my $perl_compacted = catdir($root, $appimage_name.".app", "resources", "perl");

# Get all PEB Perl scripts from the 'index.html' file:
my $index_filepath = catdir($app_directory, "index.html");
open(my $index_filehandle, '<', $index_filepath) or
  die "Can not open $index_filepath. $!";
my @index_data = <$index_filehandle>;
close $index_filehandle;

my @scripts;
foreach my $line (@index_data) {
  if ($line =~ m/(.*scriptRelativePath\s\=\s')(.*)(';)/) {
    my $script_relative_path = $2;
    my $script_full_path = catdir($app_directory, $script_relative_path);
    if (not grep (/$script_full_path/, @scripts)) {
      push @scripts, $script_full_path;
    }
  }
}

# Copy the Perl interpreter:
fcopy(
  catdir($perl_original, "bin", "perl"),
  catdir($perl_compacted, "bin", "perl")
);

# Get all dependencies from all Perl scripts:
my $script_counter;
foreach my $script (@scripts) {
  if (-e $script) {
    $script_counter++;
    print "Script Nr. $script_counter: $script\n";

    my $dependencies_hashref =
      scan_deps(
        files => [$script],
        recurse => 3,
        compile => 'false',
        warn_missing => 1
      );

    my $module_counter;
    while (my($module_relative_path, $module) = each(%{$dependencies_hashref})) {
      $module_counter++;
      print "Dependency Nr. $module_counter: $module_relative_path\n";

      (my $destination = $module->{file}) =~ s/$perl_original/$perl_compacted/g;
      fcopy($module->{file}, $destination);
    }
  }

  print "\n";
}
