
IF EXIST ./perl/bin/perl.exe (
  ECHO Going to compact the relocatable Perl for this copy of Perl Executing Browser.
  ./perl/bin/perl.exe ./sdk/compactor.pl
) ELSE (
  ECHO Relocatable Perl is not found for this copy of Perl Executing Browser.
)
