
use strict;
use warnings;
use 5.010;

use Config;
use Cwd qw(getcwd);
use File::Basename qw(basename);
use File::Copy;
use File::Spec;
use File::Spec::Functions qw(catdir);
use FindBin qw($Bin);
use lib catdir($Bin, "lib");

# Non-core CPAN modules:
# File::Copy::Recursive and Module::ScanDeps are loaded from
# the 'lib' subdirectory of the directory of this script:
use File::Copy::Recursive qw(fcopy);
use Module::ScanDeps;

print "\nPerl Distribution Compactor for Perl Executing Browser version 0.1.\n\n";

# Directory paths:
my $root = getcwd;
my $app_directory = catdir($root, "resources", "app");
my $perl_directory = catdir($app_directory, "perl");
my $bin_original = catdir($perl_directory, "bin");
my $lib_original = catdir($perl_directory, "lib");

my $bin_compacted;
my $lib_compacted;

if ($ARGV[0] and $ARGV[0] =~ /^--AppImage$/) {
  $bin_compacted = catdir($root, "peb.app", "perl", "bin");
  $lib_compacted = catdir($root, "peb.app", "perl", "lib");
} else {
  $bin_compacted = catdir($perl_directory, "bin-compacted");
  $lib_compacted = catdir($perl_directory, "lib-compacted");
}

# Copying the Perl interpreter:
if ($Config{osname} !~ "MSWin32") {
  fcopy(catdir($bin_original, "perl"), catdir($bin_compacted, "perl"));
}

if ($Config{osname} =~ "MSWin32") {
  fcopy(catdir($bin_original, "wperl.exe"), catdir($bin_compacted, "wperl.exe"));

  my @libraries = traverse_directory($bin_original, ".dll");
  foreach my $library (@libraries) {
    my $filename = basename($library, ".dll");
    fcopy($library, catdir($bin_compacted, $filename.".dll"));
  }
}

print "Perl interpreter copied.\n\n";

# Subroutine invocation to
# get recursively all Perl scripts in the 'resources/app' subdirectory:
my @scripts = traverse_directory($app_directory, ".pl");

# Get all dependencies from all Perl scripts:
my $script_counter;
foreach my $script (@scripts) {
  $script_counter++;
  print "Script Nr. $script_counter: $script\n";

  my $dependencies_hashref =
    scan_deps(files => [$script], recurse => 3,
              compile => 'true', warn_missing => 1);

  my $module_counter;
  while (my($partial_path, $module_name) = each(%{$dependencies_hashref})) {
    foreach my $include_path (@INC) {
      my $module_full_path = catdir($include_path, $partial_path);
      if (-e $module_full_path) {
        $module_counter++;
        print "Dependency Nr. $module_counter: $module_full_path";

        fcopy($module_full_path, catdir($lib_compacted, $partial_path));
        print " ... copied.\n";
      }
    }
  }

  print "\n";
}

# Rename Perl directories:
if ($ARGV[0] and $ARGV[0] !~ /^--AppImage$/) {
  rename $bin_original, catdir($perl_directory, "bin-original");
  rename $bin_compacted, catdir($perl_directory, "bin");

  rename $lib_original, catdir($perl_directory, "lib-original");
  rename $lib_compacted, catdir($perl_directory, "lib");
}

# Perl scripts recursive lister subroutine:
sub traverse_directory {
  my ($entry, $file_extension) = @_;
  my @files;

  return if not -d $entry;
  opendir (my $directory_handle, $entry) or die $!;
  while (my $subentry = readdir $directory_handle) {
    next if $subentry eq '.' or $subentry eq '..';
    my $full_path = catdir($entry, $subentry);
    if (-f $full_path and
      $full_path =~ $file_extension and
      $full_path !~ "bin/" and $full_path !~ "lib/") {
      push @files, $full_path;
    } else {
      my @subdirectory_files =
        traverse_directory($full_path, $file_extension);
      push @files, @subdirectory_files;
    }
  }
  close $directory_handle;

  return @files;
}
