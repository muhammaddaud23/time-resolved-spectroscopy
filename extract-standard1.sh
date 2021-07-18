#! /bin/bash
##This looping extract standard-1 burst spectra and store the count value to some files##
while IFS= read -r line1; do
	while IFS= read -r line2; do
		echo "From file: $line1"
		echo "and by timetrans: $line2"
		echo "Standard-1 file will be extracted"

		saextrct infile=$line1 gtiorfile=- gtiandfile=- outroot=saextrct-${line1} extenpha=".pha" extenlc='.lc' accumulate="ONE" timecol="TIME" columns=@column-deadtime binsz=0.25 printmode=SPECTRUM lcmode=RATE spmode=SUM timemin=INDEF timemax=INDEF timeint=@${line2} chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF clobber=yes > NonVLE_output_dummy
 
		saextrct infile=$line1 gtiorfile=- gtiandfile=- outroot=saextrct-${line1} extenpha=".pha" extenlc='.lc' accumulate="ONE" timecol="TIME" columns=VLECnt binsz=0.25 printmode=SPECTRUM lcmode=RATE spmode=SUM timemin=INDEF timemax=INDEF timeint=@${line2} chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF clobber=yes > VLE_output_dummy
 
		grep -w "Total Counts/Time for FITS Spectrum:" NonVLE_output_dummy >> NonVLE_output_standard1
		grep -w "Total Counts/Time for FITS Spectrum:" VLE_output_dummy >> VLE_output_standard1

	done <"list_timetrans_burst"
done <"list_standard1"
##This looping extract one standard-1 background spectrum and store the count value to some files##
while IFS= read -r line1; do 
	echo "From file: $line1"
	echo "and by timetrans: timetrans-preburst"
	echo "Standard-1 file will be extracted"

	saextrct infile=$line1 gtiorfile=- gtiandfile=- outroot=saextrct-${line1} extenpha=".pha" extenlc='.lc' accumulate="ONE" timecol="TIME" columns=@column-deadtime binsz=16 printmode=SPECTRUM lcmode=RATE spmode=SUM timemin=INDEF timemax=INDEF timeint=@timetrans-preburst chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF clobber=yes > NonVLE_output_dummy

	saextrct infile=$line1 gtiorfile=- gtiandfile=- outroot=saextrct-${line1} extenpha=".pha" extenlc='.lc' accumulate="ONE" timecol="TIME" columns=VLECnt binsz=16 printmode=SPECTRUM lcmode=RATE spmode=SUM timemin=INDEF timemax=INDEF timeint=@timetrans-preburst chmin=INDEF chmax=INDEF chint=INDEF chbin=INDEF clobber=yes > VLE_output_dummy

	grep -w "Total Counts/Time for FITS Spectrum:" NonVLE_output_dummy >> NonVLE_output_standard1
	grep -w "Total Counts/Time for FITS Spectrum:" VLE_output_dummy >> VLE_output_standard1

done <"list_standard1"

echo "Standard-1 extraction done"
##This code remove the by-product file
rm NonVLE_output_dummy
rm VLE_output_dummy
