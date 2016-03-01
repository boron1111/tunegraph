function tunegraph(Trace,Ymin,Ymax)
f=figure('name',Trace.String,'numbertitle','off','menubar','none','units','pixels');
set(f,'position',[583 240 1057 773]);
drawnow;
tunegraph_log(1,1,f,Trace,Ymin,Ymax,0);
set(f,'resizefcn',{@tunegraph_log,f,Trace,Ymin,Ymax,1});

function tunegraph_log(~,~,f,Trace,Ymin,Ymax,resizeflag)
persistent handles
figurepos=get(f,'position');
graphheight=figurepos(4)-100;
graphlength=figurepos(3)-100;
label={'A0'	'A#0'	'B0'	'C1'	'C#1'	'D1'	'D#1'	'E1'	'F1'	'F#1'	'G1'	'G#1'	'A1'	'A#1'	'B1'	'C2'	'C#2'	'D2'	'D#2'	'E2'	'F2'	'F#2'	'G2'	'G#2'	'A2'	'A#2'	'B2'	'C3'	'C#3'	'D3'	'D#3'	'E3'	'F3'	'F#3'	'G3'	'G#3'	'A3'	'A#3'	'B3'	'C4'	'C#4'	'D4'	'D#4'	'E4'	'F4'	'F#4'	'G4'	'G#4'	'A4'	'A#4'	'B4'	'C5'	'C#5'	'D5'	'D#5'	'E5'	'F5'	'F#5'	'G5'	'G#5'	'A5'	'A#5'	'B5'	'C6'	'C#6'	'D6'	'D#6'	'E6'	'F6'	'F#6'	'G6'	'G#6'	'A6'	'A#6'	'B6'	'C7'	'C#7'	'D7'	'D#7'	'E7'	'F7'	'F#7'	'G7'	'G#7'	'A7'	'A#7'	'B7'	'C8'};
tick=-48:39;
GridXLim=Trace.XLim+Trace.From;
XGrid=linspace(GridXLim(1),GridXLim(2),11);
YMin=find(strcmp(label,Ymin),1);
YMax=find(strcmp(label,Ymax),1);
if ~resizeflag
    handles.TickAxes=axes('units','pixels','visible','on',...
        'position',[50,50,graphlength,graphheight],'yticklabel',label,'ytick',tick,...
        'ylim',[tick(YMin) tick(YMax)],'xlim',GridXLim,...
        'xtick',XGrid,'ygrid','on','xgrid','on','nextplot','add');
    handles.ImageAxes=axes('units','pixels','visible','off',...
        'position',[50,50,graphlength,graphheight],'xlim',[0 graphlength],'ylim',[0 graphheight]);
    handles.Play=uicontrol('units','pixels','style','togglebutton','string','Play','position',[figurepos(3)-80,figurepos(4)-30,50,30]);
    handles.Cursor=uicontrol('units','pixels','style','togglebutton','string','Cursor','position',[figurepos(3)-150,figurepos(4)-30,50,30]);
    handles.Trace=Trace;
    handles.figure=f;
else
    set(handles.TickAxes,'position',[50,50,graphlength,graphheight]);
    set(handles.Play,'position',[figurepos(3)-80,figurepos(4)-30,50,30]);
    set(handles.Cursor,'position',[figurepos(3)-150,figurepos(4)-30,50,30]);
    delete(handles.ImageAxes);
    handles.ImageAxes=axes('units','pixels','visible','off',...
    'position',[50,50,graphlength,graphheight],'xlim',[0 graphlength],'ylim',[0 graphheight]);
end
set(handles.Play,'callback',{@Play_Callback,handles});
set(handles.Cursor,'callback',{@Cursor_Callback,handles});
set(handles.figure,'CloseRequestFcn',{@Main_Close,handles});
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
cdata(:,:)=Freq.amplitude(round(440*2.^(((x-1)/(graphheight-1)*(tick(YMax)-tick(YMin))+tick(YMin))/12)/22050*(interval/2)+1),:); %now use this
cdata=cdata/max(max(cdata));
image('parent',handles.ImageAxes,'cdata',cdata./cdata*10,'alphadata',cdata);

function Play_Callback(varargin)
handles=varargin{3};
if get(handles.Play,'value')
    player=getappdata(handles.Play,'player');
    if ~isempty(player)
        delete(player);
    end
    Trace=handles.Trace;
    RangeCursor=getappdata(handles.Cursor,'CursorLine');
    if isempty(RangeCursor)
        setappdata(handles.Play,'PlayCursorloc',Trace.From);
        player=audioplayer(Trace.Data(:,2),1/Trace.SampleInterval);
    else
        setappdata(handles.Play,'PlayCursorloc',RangeCursor(1,1)); %:,1 for loc, :,2 for handle
        RangeCursor(:,1)=RangeCursor(:,1)-Trace.From;
        player=audioplayer(Trace.Data(floor(RangeCursor(1,1)/Trace.SampleInterval)+1:floor(RangeCursor(2,1)/Trace.SampleInterval),2),1/Trace.SampleInterval);
    end
    set(player,'stopfcn',{@playerStop,handles});
    playertimer=timer('period',0.05,'startdelay',0.76,'timerfcn',{@playerTimer,handles});
    set(playertimer,'busymode','queue','executionmode','fixedrate');
    setappdata(handles.Play,'playertimer',playertimer);
    setappdata(handles.Play,'player',player);
    play(player);
    start(playertimer);
else
    player=getappdata(handles.Play,'player');
    stop(player);
end

function playerStop(varargin)
handles=varargin{3};
set(handles.Play,'value',0);
PlayCursorHandle=getappdata(handles.Play,'PlayCursorHandle');
delete(PlayCursorHandle);
setappdata(handles.Play,'PlayCursorHandle',[]);
playertimer=getappdata(handles.Play,'playertimer');
stop(playertimer);
delete(playertimer);

function playerTimer(varargin)
handles=varargin{3};
PlayCursorHandle=getappdata(handles.Play,'PlayCursorHandle');
if ~isempty(PlayCursorHandle)
    delete(PlayCursorHandle);
end
PlayCursor=getappdata(handles.Play,'PlayCursorloc');
PlayCursor=PlayCursor+0.05;
PlayCursorHandle=plot(handles.TickAxes,[PlayCursor PlayCursor],get(handles.TickAxes,'ylim'),'g--');
setappdata(handles.Play,'PlayCursorHandle',PlayCursorHandle);
setappdata(handles.Play,'PlayCursorloc',PlayCursor)

function Cursor_Callback(varargin)
hObject=varargin{1};
handles=varargin{3};
if get(hObject,'value')
    CursorLine(:,1)=get(handles.TickAxes,'xlim')';
    CursorLine(:,2)=plot(handles.TickAxes,[CursorLine(1,1) CursorLine(1,1)],get(handles.TickAxes,'ylim'),'m--',...
                                            [CursorLine(2,1) CursorLine(2,1)],get(handles.TickAxes,'ylim'),'m--');
    setappdata(handles.Cursor,'CursorLine',CursorLine);
    set(handles.figure,'windowbuttondownfcn',{@Main_WindowButtonDownFcn,handles},...
                    'windowbuttonupfcn',{@Main_WindowButtonUpFcn,handles});
else
    set(handles.figure,'windowbuttondownfcn',[]);
    set(handles.figure,'windowbuttonupfcn',[]);
    CursorLine=getappdata(handles.Cursor,'CursorLine');
    for CursorIndex=1:2
        if ishandle(CursorLine(CursorIndex,2))
            delete(CursorLine(CursorIndex,2));
        end
    end
    rmappdata(handles.Cursor,'CursorLine');
end

function Main_WindowButtonDownFcn(varargin)
handles=varargin{3};
CurrentPoint=get(handles.TickAxes,'currentpoint');
OscilloXlim=get(handles.TickAxes,'xlim');
CursorLine=getappdata(handles.Cursor,'CursorLine'); %CursorLine is a 2*2 matrix and first row is X second row is handle 
if CurrentPoint(1,1)<= OscilloXlim(2) && CurrentPoint(1,1)>=OscilloXlim(1)
    Diff=abs(CursorLine(:,1)-CurrentPoint(1,1));
    if Diff(1)<Diff(2)
        CursorIndex=1;
    else
        CursorIndex=2;
    end
    CursorLine(CursorIndex,1)=CurrentPoint(1,1);
    if ishandle(CursorLine(CursorIndex,2))
        delete(CursorLine(CursorIndex,2));
    end
    CursorLine(CursorIndex,2)=plot(handles.TickAxes,[CurrentPoint(1,1) CurrentPoint(1,1)],get(handles.TickAxes,'ylim'),'m--');
    set(handles.figure,'windowbuttonmotionfcn',{@DrawLine,handles,CursorIndex});
    setappdata(handles.Cursor,'CursorLine',CursorLine);
end

function DrawLine(varargin)
handles=varargin{3};
CursorIndex=varargin{4};
CurrentPoint=get(handles.TickAxes,'currentpoint');
CursorLine=getappdata(handles.Cursor,'CursorLine');
CursorLine(CursorIndex,1)=CurrentPoint(1,1);
TickAxesXLim=get(handles.TickAxes,'xlim');
if CursorLine(CursorIndex,1)<TickAxesXLim(1)
    CursorLine(CursorIndex,1)=TickAxesXLim(1);
end
if CursorLine(CursorIndex,1)>TickAxesXLim(2)
    CursorLine(CursorIndex,1)=TickAxesXLim(2);
end
if ishandle(CursorLine(CursorIndex,2))
    delete(CursorLine(CursorIndex,2));
end
CursorLine(CursorIndex,2)=plot(handles.TickAxes,[CurrentPoint(1,1) CurrentPoint(1,1)],get(handles.TickAxes,'ylim'),'m--');
setappdata(handles.Cursor,'CursorLine',CursorLine);

function Main_WindowButtonUpFcn(varargin)
handles=varargin{3};
set(handles.figure,'windowbuttonmotionfcn',[]);
CursorLine=getappdata(handles.Cursor,'CursorLine');
CursorLine=sortrows(CursorLine,1);
setappdata(handles.Cursor,'CursorLine',CursorLine);

function Main_Close(varargin)
handles=varargin{3};
if get(handles.Play,'value')
    player=getappdata(handles.Play,'player');
    stop(player);
end
closereq;