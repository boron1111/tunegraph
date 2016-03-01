function record(varargin)
tunegraphflag=0;
SoundLenth=10;
if ~isempty(varargin)
    SoundLenth=varargin{1};
    if length(varargin)>=2
        tunegraphflag=varargin{2};
    end
end
Fs=44100;
fprintf('%g seconds of recording...\n',SoundLenth);
y=wavrecord(Fs*SoundLenth,Fs);
y=y./max(abs(y)).*0.98;
Trace.SampleInterval=1/Fs;
Trace.XLim=[0 size(y,1)/Fs];
Trace.Data(:,1)=(1:size(y,1))/Fs;
Trace.Data(:,2)=double(y);
Trace.String='Record';
Trace.From=0;
continuous(Trace,'single');
if tunegraphflag
    tunegraph(Trace,'A3','A6');
end