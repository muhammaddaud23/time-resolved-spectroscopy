from astropy.io import fits
import pandas as pd
##This code block is to open the filter file and take the value of some parameter from the file
with open('list_filter') as file1:
	timetrans_collect = []
	for xfl in file1:
		xfl = xfl.replace("\n","")
		hdul = fits.open(xfl)
		data = hdul[1].data
		time = data['Time']
		num_pcu_on = data['NUM_PCU_ON']
		subdata = pd.DataFrame(zip(time,num_pcu_on),columns=['Time','Num_PCU_on'])
		file3 = pd.read_csv('timetrans-burst-1', delim_whitespace=True)
		for column in file3.columns:
			timetrans_collect.append(column)
		ti = float(timetrans_collect[0]) - 100
		tf = float(timetrans_collect[1]) + 30
		criteria = (subdata['Time'] >= ti) & (subdata['Time'] <= tf)
		subsubdata = subdata[criteria]

#This code block is to check whether the number of pcu on is the same from ti to tf
#If there is a difference in value, then more advance data grouping treament should be applied
if len(set(subsubdata['Num_PCU_on']))==1:
	for val in set(subsubdata['Num_PCU_on']):
		total_pcu = val
		print(total_pcu)
	print("Safe")
else:
	print("***WARNING: NEED MORE ADVANCE TREATMENT FOR DEADTIME CORRECTION")
	print("NOT SAFE")
	exit()
##Define some useful functions to read file
def count_line(x):
	count = 0
	with open(x) as file:
		for line in file:
			count = count+1
	return count
def list_file_to_list(x):
	z = []
	with open(x) as y:
		for line in y:
			z.append(line.replace("\n",""))
	return z
##Calculating the correction factor for deadtime##
DCOR = []
with open("NonVLE_output_standard1") as file1, open("VLE_output_standard1") as file2:
	for line1,line2 in zip(file1,file2):
		NonVLE_Countrate = line1
		NonVLE_Countrate = NonVLE_Countrate.replace("Total Counts/Time for FITS Spectrum:","")
		NonVLE_Countrate = NonVLE_Countrate.replace("\n","")
		NonVLE_Countrate = NonVLE_Countrate.replace(" ","")
		NonVLE_Countrate = float(NonVLE_Countrate)
		VLE_Countrate = line2
		VLE_Countrate = VLE_Countrate.replace("Total Counts/Time for FITS Spectrum:            ","")
		VLE_Countrate = VLE_Countrate.replace("\n","")
		VLE_Countrate = VLE_Countrate.replace(" ","")
		VLE_Countrate = float(VLE_Countrate)

		DTF = NonVLE_Countrate * 1.0E-5/total_pcu  + VLE_Countrate * 1.5E-04/total_pcu
		DCOR.append(1/(1-DTF))
##Append the correction factor to fits file##
limit = count_line("list_timetrans_burst")
list_event = list_file_to_list("list_timetrans_burst")
list_preburst = "timetrans-preburst"
DCOR_burst = DCOR[0:limit]
DCOR_preburst = DCOR[-1]
for i,value in enumerate(DCOR_burst):
	hdul = fits.open(f"seextrct-{list_event[i]}.pha")
	hdr = hdul[1].header
	exptime = hdr['exposure']
	hdr['exposure'] = exptime/DCOR_burst[i]
	hdul.writeto(f"ready-{list_event[i]}.pha", overwrite=True)
	hdul.close()
hdul = fits.open(f"seextrct-{list_preburst}.pha")
hdr = hdul[1].header
exptime = hdr['exposure']
hdr['exposure'] = exptime/DCOR_preburst
hdul.writeto(f"ready-{list_preburst}.pha", overwrite=True)
hdul.close()
