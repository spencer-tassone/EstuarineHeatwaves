#  Peforms low-pass filtering by multiplication in frequency domain using
#  a 3-point taper (in frequency space) between pass-band and stop band.
#  Coefficients suggested by D. Coats, Battelle, Ventura.
#  Written by Chris Sherwood, 1999 (https://github.com/csherwood-usgs/FI_processing/blob/master/lpfilt.m); revised by Patricia Wiberg, 2003.

lpfilt = function(data,delta_t,cutoff_f) {
n=length(data)
mn=mean(data)
data=data-mn  #remove mean
P=fft(data) 
N=length(P)
filt=rep(1,N)
k=floor(cutoff_f*N*delta_t)
o=c(mn,n,N,k)
print(o)
# filt is a tapered box car, symmetric over the 1st and 2nd half of P,
# with 1's for frequencies < cutoff_f and 0's for frequencies > cutoff_f
filt[(k+1):(k+3)]=c(0.715,0.24,0.024)
filt[(k+4):(N-(k+4))]=0*filt[(k+4):(N-(k+4))]
filt[N-((k+1):(k+3))]=c(0.715,0.24,0.024)
P=P*filt
fdata=Re(fft(P,inverse=T))/N  #inverse fft of modified data series
fdata=fdata[1:n]+mn  #add mean back into filtered series
return(fdata)
}
