from astropy.io import fits
import numpy as np

list_timetrans_preburst = open('list_timetrans_preburst','w')
list_timetrans_burst = open('list_timetrans_burst','w')

with open("list_burst") as list_burst:
	for burst in list_burst:
		burst = burst.replace("\n","")
		hdul = fits.open(burst)
		head = hdul[1].header
		tstart = head['TSTART']
		timezero = head['TIMEZERO']
		absolute = timezero+tstart

hdul = fits.open("monitor.lc")
data = hdul[1].data
count = data['COUNTS']
time = data['TIME']

i_t0 = np.where(time==absolute)
i_t0 = i_t0[0][0]
fixed_i_t0 = i_t0
t0 = time[i_t0]
t1s=[]
t2s=[]

while i_t0 < fixed_i_t0+60:
	total_count = []
	total_count.append(count[i_t0])
	i = i_t0
	i_t1 = i_t0
	while sum(total_count)<1500:
		total_count.append(count[i])
		i=i+1
		i_t2 = i
		t1 = time[i_t1]
		t2 = time[i_t2]
		i_t0 = i_t2
	t1s.append(t1)
	t2s.append(t2)

i=1
for t1,t2 in zip(t1s,t2s):
	timetrans_burst = open(f'timetrans-burst-{i}','w')
	timetrans_burst.write(f'{t1} {t2}')
	timetrans_burst.close()
	list_timetrans_burst.write(f'timetrans-burst-{i}\n')
	i = i+1
timetrans_preburst = open('timetrans-preburst','w')
timetrans_preburst.write('245157264.87843037 245157280.87843037') #Write background timing here
timetrans_preburst.close()
list_timetrans_preburst.write('timetrans-preburst')

list_timetrans_burst.close()
list_timetrans_preburst.close()
    		
    		
