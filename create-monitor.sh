#! /bin/bash
while IFS= read -r line; do
	seextrct infile=$line gtiorfile=APPLY gtiandfile=gti-${line} outroot=monitor extenpha='.pha' extenlc='.lc' bitfile=bitfile-otomasi timecol=TIME columns='Event' multiple='no' binsz=0.25 mfracexp=INDEF tnull=0.0 printmode=LIGHTCURVE lcmode=SUM spmode=SUM mlcinten=INDEF mspinten=INDEF timemin=INDEF timemax=INDEF timeint=INDEF gticols='START STOP' chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF ephem=INDEF period=INDEF phaseint=INDEF obsdate='MJDREF' obstime='TSTART TSTOP' sensecase=no chkit=no clobber=yes negative=IGNORE bailout=no mode='h'

echo "Monitor lightcurve has been created for $line file"
done < "list_event"
