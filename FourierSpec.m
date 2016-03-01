function Rt=FourierSpec(Data,Fs)
%Length is already 2^n, otherwise use NFFT=2^nextpow2(L);
NFFT=size(Data,1);
Y=fft(Data,NFFT)/NFFT;
f=Fs/2*linspace(0,1,NFFT/2+1);
Rt.frequency=f;
Rt.amplitude=2*abs(Y(1:NFFT/2+1,:));
