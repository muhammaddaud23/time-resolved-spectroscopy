while read line1; do
	while read line2; do
		echo "From file: $line1"
		echo "and by timetrans: $line2"
		echo "Spectra will be extracted for Event-mode"

		seextrct infile=$line1 gtiorfile=APPLY gtiandfile=gti-${line1} outroot=seextrct-${line2} extenpha='.pha' extenlc='.lc' bitfile=bitfile-otomasi timecol=TIME columns='Event' multiple='no' binsz=0.5 mfracexp=INDEF tnull=0.0 printmode=SPECTRUM lcmode=RATE spmode=SUM mlcinten=INDEF mspinten=INDEF timemin=INDEF timemax=INDEF timeint=@${line2} gticols='START STOP' chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF ephem=INDEF period=INDEF phaseint=INDEF obsdate='MJDREF' obstime='TSTART TSTOP' sensecase=no chkit=no clobber=yes negative=IGNORE bailout=no mode='h'
  
	done<"list_timetrans_burst"
done<"list_event"

echo "Source extraction done"

while IFS= read -r -u 4 line1 && IFS= read -r -u 5 line2; do
	echo "From file: $line1"
	echo "and by timetrans: $line2"
	echo "Spectra will be extracted for Background"
	seextrct infile=$line1 gtiorfile=APPLY gtiandfile=gti-${line1} outroot=seextrct-${line2} extenpha='.pha' extenlc='.lc' bitfile=bitfile-otomasi timecol=TIME columns='Event' multiple='no' binsz=16 mfracexp=INDEF tnull=0.0 printmode=SPECTRUM lcmode=RATE spmode=SUM mlcinten=INDEF mspinten=INDEF timemin=INDEF timemax=INDEF timeint=@${line2} gticols='START STOP' chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF ephem=INDEF period=INDEF phaseint=INDEF obsdate='MJDREF' obstime='TSTART TSTOP' sensecase=no chkit=no clobber=yes negative=IGNORE bailout=no mode='h'
done 4<"list_event" 5<"list_timetrans_preburst"

echo "Background extraction done"
