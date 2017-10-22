#!/usr/bin/perl

while (<>) {

    # desetinna carka, carka meze dvema cislicemi se nahradi {,}
    $_ =~ s/(?<=\d)\,(?=\d)/{,}/g;

    # mezera mezi cislem a fyzikalni jednotkou se nahradi zuzenou mezerou
    $_ =~ s/(?<=\d)\s?(?=km)/\\,/g;
    $_ =~ s/(?<=\d)\s?(?=m(\s|\.|\,|$))/\\,/g;
    $_ =~ s/(?<=\d)\s?(?=kč(\s|\.|\,|$))/\\,/g;
    $_ =~ s/(?<=\d)\s?(?=Kč(\s|\.|\,|$))/\\,/g;
    $_ =~ s/(?<=\d)\s?(?=K(\s|\.|\,|$))/\\,/g;
    $_ =~ s/(?<=\d)\s?(?=ha(\s|\.|\,|$))/\\,/g;
    $_ =~ s/(?<=\d)\s*m2/\\,\$m^2\$/g;

    # procento neni komentar
    $_ =~ s/%/\\%/g;

    # nezlomna mezera pred jedno pismeno
    $_ =~ s/\s(?=[aioz]\s)/~/g;

    print $_
}
