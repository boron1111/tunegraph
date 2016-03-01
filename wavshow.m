function wavshow
[filename,filepath]=uigetfile({'*.wav';'*.mp3'});
if filename==0
    return
end
if strcmp(filename(length(filename)-2:length(filename)),'wav')
    [y, Fs] = wavread([filepath,filename]);
elseif strcmp(filename(length(filename)-2:length(filename)),'mp3')
    [y,Fs,~,~,~]=mp3read([filepath,filename]);
end
Trace.SampleInterval=1/Fs;
Trace.XLim=[0 size(y,1)/Fs];
Trace.Data(:,1)=(1:size(y,1))/Fs;
Trace.Data(:,2)=double(mean(y,2));
Trace.String=filename;
continuous(Trace,'single');