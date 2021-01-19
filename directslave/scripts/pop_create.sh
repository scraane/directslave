# This script is executed when new POP account 
# created on master server. It accepts all the VARS in ENV.
# Run it from directslave and you will see all the trace in error.log.

#!/usr/local/bin/perl

foreach $var (sort(keys(%ENV))) {
    $val = $ENV{$var};
    $val =~ s|\n|\\n|g;
    $val =~ s|"|\\"|g;
    print "${var}=\"${val}\"\n";
}

