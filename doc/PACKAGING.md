Perl Executing Browser - Packaging
--------------------------------------------------------------------------------

## Minimal Portable Perl Distribution for PEB
Sometimes it is important to minimize the size of the relocatable (or portable) Perl distribution used by a PEB-based application. [Perl Distribution Compactor](sdk/compactor.pl) is one solution for this problem. It finds all dependencies of all Perl scripts in the ``{PEB_binary_directory}/resources/app`` directory and copies them in a new ``{PEB_binary_directory}/perl/lib`` folder; a new ``{PEB_binary_directory}/perl/bin`` is also created. The original ``bin`` and ``lib`` folders may be saved as ``bin-original`` and ``lib-original`` respectively.  

Perl Distribution Compactor should be started using [compactor.sh](sdk/compactor.sh) on a Linux machine or [compactor.cmd](sdk/compactor.cmd) on a Windows machine to ensure that only the Perl distribution of PEB is used. This is necessary to avoid dependency mismatches with any other Perl on PATH.  

Perl Distribution Compactor depends on [Module::ScanDeps](https://metacpan.org/pod/Module::ScanDeps) and [File::Copy::Recursive](https://metacpan.org/pod/File::Copy::Recursive) CPAN modules, which are included in the ``{PEB_binary_directory}/sdk/lib`` folder.

## AppImage Support
Any PEB-based application can be easily packed as a single executable Linux [AppImage](https://appimage.org/) file including the PEB binary, all necessary Qt libraries, relocatable Perl distribution and all application files. This can be easily achieved by the [AppImage Maker](sdk/appimage-maker.sh) script. It finds all dependencies of all Perl scripts in the ``{PEB_binary_directory}/resources/app`` directory and copies only the necessary Perl modules using the [Perl Distribution Compactor](sdk/compactor.pl). All Qt dependencies are detected and the final image is built using a special version of the [linuxdeployqt](https://github.com/probonopd/linuxdeployqt/releases/) binary.
