function testofdelay
global p
[y,fs]=wavread('2.wav');
p=audioplayer(y,fs);
tic
set(p,'stopfcn',{@stopf});
play(p);

function stopf(varargin)
toc