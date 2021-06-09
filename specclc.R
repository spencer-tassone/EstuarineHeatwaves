# Computes the power spectral density of a time series
# Written by Patricia Wiberg

specclc <- function(x,fs) {
#x = time series, fs = sampling frequency (1/dt)
#cx = vector of Fourier coefficients, fx = vector of frequencies
nw = 256
no = 128 #nw=window length; no=overlap length;
nx = length(x)  #nx is length of record
if (nx<nw) {
  x0 = rep(0,nw-nx)
  x = c(x,x0)
  #x[nx+1:nw]=0  #add zeros if n<nw
  nx=nw 
}
nseg=floor(2*nx/nw-1)  #calculate number of segments
iw=seq(0,no-1)  #window index
halfwin=0.5*(1-cos(pi*iw/(no-1)))  #Tukey-Hanning window
win=c(halfwin,halfwin[length(halfwin):1])
sswn=sum(abs(win^2))/nw  #square of the window's L2-norm / nw
csum=rep(0,nw)  
for (i in 1:nseg) {
  iseg=seq(1,nw)+(i-1)*no   #segment index
  xseg=win*x[iseg]  
  cseg=abs(fft(xseg,nw))^2   #fft of segment
  csum=csum+cseg   #sum contributions from each segment
}
cx=csum/nseg  #average summed fft
#cx is 2*normalized first half of average summed fft
cx=2*cx[1:no+1]/(nw*fs*sswn) 
fx=seq(1,no)*fs/nw  #fx is frequency vector
spout = cbind(cx,fx)
return(spout)
}
