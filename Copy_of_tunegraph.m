function tunegraph(Trace,Ymin,Ymax)
% tunegraph_linear(Trace);
f=figure('name',Trace.String,'numbertitle','off','menubar','none','units','pixels');
jFrame=getJFrame(f);
jFrame.setMaximized(1);
drawnow;
tunegraph_log(1,1,f,Trace,Ymin,Ymax,0);
set(f,'resizefcn',{@tunegraph_log,f,Trace,Ymin,Ymax,1});

% function tunegraph_linear(Trace)
% f=figure('name',Trace.String,'numbertitle','off','menubar','none','units','pixels');
% jFrame=getJFrame(f);
% jFrame.setMaximized(1);
% graphheight=figurepos(4)-100;
% graphlength=figurepos(3)-100;
% GridXLim=Trace.XLim+Trace.From;
% XGrid=linspace(GridXLim(1),GridXLim(2),11);
% tick=linspace(200,1800,17);
% YMin=1;
% YMax=17;
% axes('units','pixels','visible','on',...
%     'position',[50,50,graphlength,graphheight],'ytick',tick,...
%     'ylim',[tick(YMin) tick(YMax)],'xlim',GridXLim,...
%     'xtick',XGrid,'ygrid','on','xgrid','on');
% ImageAxes=axes('units','pixels','visible','off',...
%                 'position',[50,50,graphlength,graphheight],'xlim',[0 graphlength],'ylim',[0 graphheight]);
% cdata=zeros(graphheight,graphlength);
% interval=2^13;
% added=cat(1,zeros(interval/2,1),Trace.Data(:,2),zeros(interval/2-1,1));
% AnalyzePoints=floor(linspace(1,size(Trace.Data,1),graphlength));
% AnalyzeData=zeros(interval,graphlength);
% for i=1:graphlength
%     AnalyzeData(:,i)=added(AnalyzePoints(i):AnalyzePoints(i)+interval-1);
% end
% Freq=FourierSpec(AnalyzeData,1/Trace.SampleInterval);
% x=1:graphheight;
% cdata(:,:)=Freq.amplitude(round(((x-1)/(graphheight-1)*(tick(YMax)-tick(YMin))+tick(YMin))/22050*(interval/2)+1),:);
% cdata=cdata/max(max(cdata));
% image('parent',ImageAxes,'cdata',cdata*255,'alphadata',cdata);

%once the 'yscale' set to 'log' the 'alphadata' doesn't work

function tunegraph_log(~,~,f,Trace,Ymin,Ymax,resizeflag)
figurepos=get(f,'position');
graphheight=figurepos(4)-100;
graphlength=figurepos(3)-100;
label={'A0'	'A#0'	'B0'	'C1'	'C#1'	'D1'	'D#1'	'E1'	'F1'	'F#1'	'G1'	'G#1'	'A1'	'A#1'	'B1'	'C2'	'C#2'	'D2'	'D#2'	'E2'	'F2'	'F#2'	'G2'	'G#2'	'A2'	'A#2'	'B2'	'C3'	'C#3'	'D3'	'D#3'	'E3'	'F3'	'F#3'	'G3'	'G#3'	'A3'	'A#3'	'B3'	'C4'	'C#4'	'D4'	'D#4'	'E4'	'F4'	'F#4'	'G4'	'G#4'	'A4'	'A#4'	'B4'	'C5'	'C#5'	'D5'	'D#5'	'E5'	'F5'	'F#5'	'G5'	'G#5'	'A5'	'A#5'	'B5'	'C6'	'C#6'	'D6'	'D#6'	'E6'	'F6'	'F#6'	'G6'	'G#6'	'A6'	'A#6'	'B6'	'C7'	'C#7'	'D7'	'D#7'	'E7'	'F7'	'F#7'	'G7'	'G#7'	'A7'	'A#7'	'B7'	'C8'};
% tick=440*2.^((-48:39)/12); 
tick=-48:39; %now use linear scale
GridXLim=Trace.XLim+Trace.From;
XGrid=linspace(GridXLim(1),GridXLim(2),11);
YMin=find(strcmp(label,Ymin),1);
YMax=find(strcmp(label,Ymax),1);
% axes('units','pixels','visible','on',...
%     'position',[50,50,graphlength,graphheight],'yticklabel',label,'ytick',tick,...
%     'ylim',[tick(YMin) tick(YMax)],'xlim',GridXLim,'yscale','log',...
%     'xtick',XGrid,'ygrid','on','xgrid','on');
persistent TickAxes ImageAxes
if ~resizeflag
    TickAxes=axes('units','pixels','visible','on',...
        'position',[50,50,graphlength,graphheight],'yticklabel',label,'ytick',tick,...
        'ylim',[tick(YMin) tick(YMax)],'xlim',GridXLim,...
        'xtick',XGrid,'ygrid','on','xgrid','on');
    ImageAxes=axes('units','pixels','visible','off',...
        'position',[50,50,graphlength,graphheight],'xlim',[0 graphlength],'ylim',[0 graphheight]);
else
    set(TickAxes,'position',[50,50,graphlength,graphheight]);
    delete(ImageAxes);
    ImageAxes=axes('units','pixels','visible','off',...
    'position',[50,50,graphlength,graphheight],'xlim',[0 graphlength],'ylim',[0 graphheight]);
end
cdata=zeros(graphheight,graphlength);
interval=2^13;
added=cat(1,zeros(interval/2,1),Trace.Data(:,2),zeros(interval/2-1,1));
AnalyzePoints=floor(linspace(1,size(Trace.Data,1),graphlength));
AnalyzeData=zeros(interval,graphlength);
for i=1:graphlength
    AnalyzeData(:,i)=added(AnalyzePoints(i):AnalyzePoints(i)+interval-1);
end
Freq=FourierSpec(AnalyzeData,1/Trace.SampleInterval);
x=1:graphheight;
% cdata(:,:)=Freq.amplitude(round(10.^((x-1)/(graphheight-1)*log10(tick(YMax)/tick(YMin))+log10(tick(YMin)))/22050*(interval/2)+1),:);
cdata(:,:)=Freq.amplitude(round(440*2.^(((x-1)/(graphheight-1)*(tick(YMax)-tick(YMin))+tick(YMin))/12)/22050*(interval/2)+1),:); %now use this
cdata=cdata/max(max(cdata));
image('parent',ImageAxes,'cdata',cdata./cdata*10,'alphadata',cdata);

% figure;
% mesh(AnalyzePoints,Freq.frequency,Freq.amplitude);
% set(gca,'ylim',[200 1800],'yscale','log');

% GridAxes=axes('nextplot','add','units','pixels','visible','off',...
%     'position',[50,50,graphlength,graphheight],...
%     'ylim',[tick(YMin) tick(YMax)],'yscale','log','xlim',GridXLim);
% for i=YMin+1:YMax-1
%     plot(GridAxes,GridXLim,[tick(i) tick(i)],'--','color',[0.8 0.8 0.8]);
% end
% for i=2:length(XGrid)-1
%     plot(GridAxes,[XGrid(i) XGrid(i)],[tick(YMin) tick(YMax)],'--','color',[0.8 0.8 0.8])
% end
