#!/usr/bin/env bash

relocatable_perl="./perl/bin/perl"

if [ -e "$relocatable_perl" ]; then
  printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
  $relocatable_perl ./sdk/compactor.pl
else
  printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
fi
