function continuous(Trace,flag)
%has ToWav function
global handles
ExistFlag=0;
if isempty(handles) || ~strcmp(flag,'single')
    handles.Main=figure('units','pixels',...
                  'position',[500 500 1000 500],...
                  'menubar','none',...
                  'name',['Continuous ----- ',Trace.String],...
                  'numbertitle','off',...
                  'resize','on',...
                  'color',[0.94 0.94 0.94]);

    handles.YSlide=uicontrol('style','slider',...
                    'units','pixels',...
                    'enable','off');

    handles.XSlide=uicontrol('style','slider',...
                    'units','pixels',...
                    'enable','off');

    handles.YGear=uicontrol('style','slider',...
                    'units','pixels',...
                    'sliderstep',[0.0001,0.1],...
                    'value',0.5);

    handles.XGear=uicontrol('style','slider',...
                    'units','pixels',...
                    'sliderstep',[0.0001,0.1],...
                    'value',0.5);

    handles.Oscillo=axes('nextplot','replacechildren',...
                        'units','pixels');

    handles.Zoom=uicontrol('style','pushbutton',...
                        'string','Zoom',...
                        'units','pixels');

    handles.ToNew=uicontrol('style','pushbutton',...
                        'string','ToNew',...
                        'units','pixels');

    handles.Play=uicontrol('style','togglebutton',...
                        'string','Play',...
                        'units','pixels');

    handles.Cursor=uicontrol('style','togglebutton',...
                        'string','Cursor',...
                        'units','pixel');

    handles.Image=axes('nextplot','replacechildren',...
                      'units','pixels');

    handles.CursorAxes=axes('nextplot','add',...
                        'units','pixels');
                    
    handles.FreqSpec=uicontrol('style','pushbutton',...
                        'string','Freq',...
                        'units','pixels');
    
    handles.Save=uicontrol('style','pushbutton',...
                        'string','Save',...
                        'units','pixels');
                    
    handles.TuneGraph=uicontrol('style','pushbutton',...
                        'string','TuneGraph',...
                        'units','pixels');
                    
    handles.Ymin=uicontrol('style','popupmenu',...
                        'string',{'A0'	'A#0'	'B0'	'C1'	'C#1'	'D1'	'D#1'	'E1'	'F1'	'F#1'	'G1'	'G#1'	'A1'	'A#1'	'B1'	'C2'	'C#2'	'D2'	'D#2'	'E2'	'F2'	'F#2'	'G2'	'G#2'	'A2'	'A#2'	'B2'	'C3'	'C#3'	'D3'	'D#3'	'E3'	'F3'	'F#3'	'G3'	'G#3'	'A3'	'A#3'	'B3'	'C4'	'C#4'	'D4'	'D#4'	'E4'	'F4'	'F#4'	'G4'	'G#4'	'A4'	'A#4'	'B4'	'C5'	'C#5'	'D5'	'D#5'	'E5'	'F5'	'F#5'	'G5'	'G#5'	'A5'	'A#5'	'B5'	'C6'	'C#6'	'D6'	'D#6'	'E6'	'F6'	'F#6'	'G6'	'G#6'	'A6'	'A#6'	'B6'	'C7'	'C#7'	'D7'	'D#7'	'E7'	'F7'	'F#7'	'G7'	'G#7'	'A7'	'A#7'	'B7'	'C8'},...
                        'units','pixels','value',37);
                    
    handles.Ymax=uicontrol('style','popupmenu',...
                        'string',{'A0'	'A#0'	'B0'	'C1'	'C#1'	'D1'	'D#1'	'E1'	'F1'	'F#1'	'G1'	'G#1'	'A1'	'A#1'	'B1'	'C2'	'C#2'	'D2'	'D#2'	'E2'	'F2'	'F#2'	'G2'	'G#2'	'A2'	'A#2'	'B2'	'C3'	'C#3'	'D3'	'D#3'	'E3'	'F3'	'F#3'	'G3'	'G#3'	'A3'	'A#3'	'B3'	'C4'	'C#4'	'D4'	'D#4'	'E4'	'F4'	'F#4'	'G4'	'G#4'	'A4'	'A#4'	'B4'	'C5'	'C#5'	'D5'	'D#5'	'E5'	'F5'	'F#5'	'G5'	'G#5'	'A5'	'A#5'	'B5'	'C6'	'C#6'	'D6'	'D#6'	'E6'	'F6'	'F#6'	'G6'	'G#6'	'A6'	'A#6'	'B6'	'C7'	'C#7'	'D7'	'D#7'	'E7'	'F7'	'F#7'	'G7'	'G#7'	'A7'	'A#7'	'B7'	'C8'},...
                        'units','pixels','value',73);

else
    figure(handles.Main);
    ExistFlag=1;
end

set(handles.Main,'ResizeFcn',{@Main_Resize,handles},'DeleteFcn',{@Main_DeleteFcn,flag},'CloseRequestFcn',{@Main_Close,handles});
set(handles.XGear,'callback',{@XGear_Callback,handles});
set(handles.YGear,'callback',{@YGear_Callback,handles});
set(handles.XSlide,'callback',{@XSlide_Callback,handles});
set(handles.YSlide,'callback',{@YSlide_Callback,handles});
set(handles.Zoom,'callback',{@Zoom_Callback,handles});
set(handles.Play,'callback',{@Play_Callback,handles});
set(handles.Cursor,'callback',{@Cursor_Callback,handles});
set(handles.ToNew,'callback',{@ToNew_Callback,handles});
set(handles.FreqSpec,'callback',{@FreqSpec_Callback,handles});
set(handles.Save,'callback',{@ToWav_Callback,handles});
set(handles.TuneGraph,'callback',{@TuneGraph_Callback,handles});

set(handles.Oscillo,'xlim',Trace.XLim);
set(handles.CursorAxes,'xlim',Trace.XLim);
setappdata(handles.Oscillo,'Trace',Trace);
setappdata(handles.Oscillo,'YGearIndex',7); %current YGear
setappdata(handles.Oscillo,'MidPoint',0);
setappdata(handles.Oscillo,'MaxScale',8);

setappdata(handles.XGear,'lastvalue',0.5);
setappdata(handles.YGear,'lastvalue',0.5);

if ExistFlag
    Main_Resize([],[],handles);
end

function SpeedPlot(Trace,handles)
OscXLim=get(handles.Oscillo,'xlim');
Start=round(OscXLim(1)/Trace.SampleInterval);
End=round(OscXLim(2)/Trace.SampleInterval);
Start=Start*(Start>=1)+1*(Start<1);
TraceSize=size(Trace.Data,1);
End=End*(End<=TraceSize)+TraceSize*(End>TraceSize);
Size=End-Start+1;

if Size>500000
    setappdata(handles.Image,'PlotOnOsc',0);
    Oscplot_h=getappdata(handles.Oscillo,'plothandle');
    if ishandle(Oscplot_h)
        delete(Oscplot_h);
    end
    XWholePixel=getappdata(handles.Image,'XWholePixel');
    X=int32((Trace.Data(:,1)-Trace.XLim(1))/(Trace.XLim(2)-Trace.XLim(1))*double(XWholePixel));
    YWholePixel=getappdata(handles.Image,'YWholePixel');
    Y=int32((Trace.Data(:,2)+2.048)/4.096*double(YWholePixel));
    Y(Y>YWholePixel)=YWholePixel;
    Y(Y<1)=1;
    X(X>XWholePixel)=XWholePixel;
    X(X<1)=1;
    W=int32(XWholePixel);
    Z=(Y-1)*W+X;
    M=zeros(XWholePixel,YWholePixel);
    M(Z)=1;
    [x y]=find(M==1);
    ImTrace=sortrows([x y]);
    Imageplot_h=plot(handles.Image,ImTrace(:,1),ImTrace(:,2));
    setappdata(handles.Image,'plothandle',Imageplot_h);
else
    setappdata(handles.Image,'plotflag','part');
    Imageplot_h=getappdata(handles.Image,'plothandle');
    if ishandle(Imageplot_h)
        delete(Imageplot_h)
    end
    ImPos=get(handles.Image,'position');
    if Size>ImPos(3)/5
        Oscplot_h=plot(handles.Oscillo,Trace.Data(Start:End,1),Trace.Data(Start:End,2));
    else
        Oscplot_h=plot(handles.Oscillo,Trace.Data(Start:End,1),Trace.Data(Start:End,2),'.-');
    end
    setappdata(handles.Oscillo,'plothandle',Oscplot_h);
    setappdata(handles.Image,'PlotOnOsc',1);
end

function Main_Resize(varargin)
handles=varargin{3};
MainPosition=get(handles.Main,'position');
set(handles.XGear,'position',[1,70,28,20]);
set(handles.XSlide,'position',[81,0,MainPosition(3)-20-81,20]);
set(handles.Oscillo,'position',[81,70,MainPosition(3)-21-81,MainPosition(4)-70-60]);
set(handles.Image,'position',[81,70,MainPosition(3)-21-81,MainPosition(4)-70-60],...
                  'xlim',[0 MainPosition(3)-21-81],'ylim',[0 MainPosition(4)-70-60],'visible','off');
set(handles.CursorAxes,'position',[81,70,MainPosition(3)-21-81,MainPosition(4)-70-60],'visible','off');
set(handles.YGear,'position',[28,(MainPosition(4)-70-60)/2+70-14,20,28]);
set(handles.YSlide,'position',[MainPosition(3)-21+2,70,20,MainPosition(4)-70-60]);
set(handles.Play,'position',[MainPosition(3)-65,MainPosition(4)-55,60,20]);
set(handles.Zoom,'position',[MainPosition(3)-65,MainPosition(4)-30,60,20]);
set(handles.ToNew,'position',[MainPosition(3)-135,MainPosition(4)-55,60,20]);
set(handles.Cursor,'position',[MainPosition(3)-135,MainPosition(4)-30,60,20]);
set(handles.Save,'position',[MainPosition(3)-205,MainPosition(4)-55,60,20]);
set(handles.FreqSpec,'position',[MainPosition(3)-205,MainPosition(4)-30,60,20]);
set(handles.TuneGraph,'position',[MainPosition(3)-270,MainPosition(4)-30,60,20]);
set(handles.Ymin,'position',[MainPosition(3)-335,MainPosition(4)-30,60,25]);
set(handles.Ymax,'position',[MainPosition(3)-335,MainPosition(4)-55,60,25]);
setappdata(handles.Image,'XWholePixel',MainPosition(3)-21-81);
Trace=getappdata(handles.Oscillo,'Trace');
%To set YWholePixel
OscVerticalOrigin(handles);
%To set XWholePixel
TotalLen=Trace.XLim(2)-Trace.XLim(1);
NewXLim=get(handles.Oscillo,'xlim');
OscLen=NewXLim(2)-NewXLim(1);
XWholePixel=int32((MainPosition(3)-21-81)*TotalLen/OscLen);
set(handles.Image,'xlim',(NewXLim-Trace.XLim(1))/TotalLen*double(XWholePixel));
setappdata(handles.Image,'XWholePixel',XWholePixel);
SpeedPlot(Trace,handles);
    
function XGear_Callback(varargin)
handles=varargin{3};
lastvalue=getappdata(handles.XGear,'lastvalue');
Trace=getappdata(handles.Oscillo,'Trace');
OldYLim=get(handles.Oscillo,'xlim');
if get(handles.XGear,'value')<lastvalue
    NewXLim(1)=(3*OldYLim(1)-OldYLim(2))/2;
    NewXLim(2)=(3*OldYLim(2)-OldYLim(1))/2;
    NewXLim(1)=NewXLim(1)*(NewXLim(1)>=Trace.XLim(1))+Trace.XLim(1)*(NewXLim(1)<Trace.XLim(1));
    NewXLim(2)=NewXLim(2)*(NewXLim(2)<=Trace.XLim(2))+Trace.XLim(2)*(NewXLim(2)>Trace.XLim(2));
    set(handles.Oscillo,'xlim',NewXLim);
    set(handles.CursorAxes,'xlim',NewXLim);
elseif get(handles.XGear,'value')>lastvalue
    NewXLim(1)=(3*OldYLim(1)+OldYLim(2))/4;
    NewXLim(2)=(3*OldYLim(2)+OldYLim(1))/4;
    set(handles.Oscillo,'xlim',NewXLim);
    set(handles.CursorAxes,'xlim',NewXLim);
else
    set(handles.XGear,'value',0.5);
    setappdata(handles.XGear,'lastvalue',0.5);
    return
end
setappdata(handles.XGear,'lastvalue',get(handles.XGear,'value'));
ImPos=get(handles.Image,'position');
TotalLen=Trace.XLim(2)-Trace.XLim(1);
OscLen=NewXLim(2)-NewXLim(1);
if NewXLim(1)>Trace.XLim(1) || NewXLim(2)<Trace.XLim(2)
    Step=[0.1/(TotalLen/OscLen-1),1/(TotalLen/OscLen-1)];
    if Step(2)>1
        Step=Step./Step;
    end
    set(handles.XSlide,'enable','on','min',Trace.XLim(1),'max',Trace.XLim(2)-OscLen,...
                        'value',NewXLim(1),'sliderstep',Step);
else
    set(handles.XSlide,'enable','off');
end
XWholePixel=int32(ImPos(3)*TotalLen/OscLen);
set(handles.Image,'xlim',(NewXLim-Trace.XLim(1))/TotalLen*double(XWholePixel));
setappdata(handles.Image,'XWholePixel',XWholePixel);
SpeedPlot(Trace,handles);

function XSlide_Callback(varargin)
handles=varargin{3};
OldXLim=get(handles.Oscillo,'xlim');
NewXLim(1)=get(handles.XSlide,'value');
NewXLim(2)=NewXLim(1)+OldXLim(2)-OldXLim(1);
set(handles.Oscillo,'xlim',NewXLim);
set(handles.CursorAxes,'xlim',NewXLim);
Trace=getappdata(handles.Oscillo,'Trace');
XWholePixel=getappdata(handles.Image,'XWholePixel');
set(handles.Image,'xlim',(NewXLim)/(Trace.XLim(2)-Trace.XLim(1))*double(XWholePixel));
if getappdata(handles.Image,'PlotOnOsc')
    SpeedPlot(Trace,handles);
end

function YGear_Callback(varargin)
handles=varargin{3};
lastvalue=getappdata(handles.YGear,'lastvalue');
OldYLim=get(handles.Oscillo,'ylim');
if get(handles.YGear,'value')>lastvalue
    if getappdata(handles.Oscillo,'YGearIndex')>1
        setappdata(handles.Oscillo,'YGearIndex',getappdata(handles.Oscillo,'YGearIndex')-1);
        setappdata(handles.Oscillo,'MidPoint',(OldYLim(1)+OldYLim(2))/2);
    end
elseif get(handles.YGear,'value')<lastvalue
    if getappdata(handles.Oscillo,'YGearIndex')<getappdata(handles.Oscillo,'MaxScale')
        setappdata(handles.Oscillo,'YGearIndex',getappdata(handles.Oscillo,'YGearIndex')+1);
        setappdata(handles.Oscillo,'MidPoint',(OldYLim(1)+OldYLim(2))/2);
    end
else
    set(handles.XGear,'value',0.5);
    setappdata(handles.YGear,'lastvalue',0.5);
    return
end
OscVerticalOrigin(handles);
setappdata(handles.YGear,'lastvalue',get(handles.YGear,'value'));
Trace=getappdata(handles.Oscillo,'Trace');
SpeedPlot(Trace,handles)

function YSlide_Callback(varargin)
handles=varargin{3};
OldYLim=get(handles.Oscillo,'ylim');
NewYLim(1)=get(handles.YSlide,'value');
NewYLim(2)=NewYLim(1)+OldYLim(2)-OldYLim(1);
set(handles.Oscillo,'ylim',NewYLim);
set(handles.CursorAxes,'ylim',NewYLim);
YWholePixel=getappdata(handles.Image,'YWholePixel');
set(handles.Image,'ylim',(NewYLim+2.048)/4.096*double(YWholePixel));

function OscVerticalOrigin(handles)
Scales=[-1.024E-02	1.024E-02
-2.048E-02	2.048E-02
-4.096E-02	4.096E-02
-1.024E-01	1.024E-01
-2.048E-01	2.048E-01
-4.096E-01	4.096E-01
-1.024E+00	1.024E+00
-2.048E+00	2.048E+00
-4.096E+00	4.096E+00
-1.024E+01	1.024E+01
-2.048E+01	2.048E+01
];
TotalYLim=Scales(getappdata(handles.Oscillo,'MaxScale'),:);
YGearIndex=getappdata(handles.Oscillo,'YGearIndex'); %current YGear Index
NewYLim=Scales(YGearIndex,:)+getappdata(handles.Oscillo,'MidPoint');
NewYLim(1)=NewYLim(1)*(NewYLim(1)>=TotalYLim(1))+TotalYLim(1)*(NewYLim(1)<TotalYLim(1));
NewYLim(2)=NewYLim(2)*(NewYLim(2)<=TotalYLim(2))+TotalYLim(2)*(NewYLim(2)>TotalYLim(2));
set(handles.Oscillo,'ylim',NewYLim);
set(handles.CursorAxes,'ylim',NewYLim);
setappdata(handles.Oscillo,'MidPoint',0);
ImPos=get(handles.Image,'position');
TotalLen=TotalYLim(2)-TotalYLim(1);
OscLen=NewYLim(2)-NewYLim(1);
if NewYLim(1)>TotalYLim(1) || NewYLim(2)<TotalYLim(2)
    Step=[0.1/(TotalLen/OscLen-1),1/(TotalLen/OscLen-1)];
    if Step(2)>1
        Step=Step./Step;
    end
    set(handles.YSlide,'enable','on','min',TotalYLim(1),'max',TotalYLim(2)-OscLen,...
                        'value',NewYLim(1),'sliderstep',Step);
else
    set(handles.YSlide,'enable','off');
end
YWholePixel=int32(ImPos(4)*TotalLen/OscLen);
set(handles.Image,'ylim',(NewYLim-TotalYLim(1))/TotalLen*double(YWholePixel));
setappdata(handles.Image,'YWholePixel',YWholePixel);

function ToWav_Callback(varargin)
handles=varargin{3};
Trace=getappdata(handles.Oscillo,'Trace');
[filename,filepath]=uiputfile('*.wav','Select file to write','.\wav\');
if filename==0
    return
end
if exist([filepath,filename(1:size(filename,2)-4),'.pk'],'file')
    delete([filepath,filename(1:size(filename,2)-4),'.pk']);
end
wavwrite(Trace.Data(:,2),1/Trace.SampleInterval,[filepath,filename]);
% winopen([filepath,filename]);

function Play_Callback(varargin)
handles=varargin{3};
if get(handles.Play,'value')
    player=getappdata(handles.Play,'player');
    if ~isempty(player)
        delete(player);
    end
    Trace=getappdata(handles.Oscillo,'Trace');
    RangeCursor=getappdata(handles.Cursor,'CursorLine');
    if isempty(RangeCursor)
        setappdata(handles.Play,'playercursorloc',0);
        player=audioplayer(Trace.Data(:,2),1/Trace.SampleInterval);
    else
        setappdata(handles.Play,'playercursorloc',RangeCursor(1,1));
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
playercursor=getappdata(handles.Play,'playercursor');
delete(playercursor);
setappdata(handles.Play,'playercursor',[]);
playertimer=getappdata(handles.Play,'playertimer');
stop(playertimer);
delete(playertimer);

function playerTimer(varargin)
handles=varargin{3};
playercursor=getappdata(handles.Play,'playercursor');
if ~isempty(playercursor)
    delete(playercursor);
end
CursorLine=getappdata(handles.Play,'playercursorloc');
CursorLine=CursorLine+0.05;
playercursor=plot(handles.CursorAxes,[CursorLine CursorLine],[-2.048 2.048],'g--');
setappdata(handles.Play,'playercursor',playercursor);
setappdata(handles.Play,'playercursorloc',CursorLine)

function Cursor_Callback(varargin)
hObject=varargin{1};
handles=varargin{3};
if get(hObject,'value')
    CursorLine(:,1)=get(handles.CursorAxes,'xlim')';
    CursorLine(:,2)=plot(handles.CursorAxes,[CursorLine(1,1) CursorLine(1,1)],[-2.048 2.048],'m--',...
                                            [CursorLine(2,1) CursorLine(2,1)],[-2.048 2.048],'m--');
    setappdata(handles.Cursor,'CursorLine',CursorLine);
    set(handles.Main,'windowbuttondownfcn',{@Main_WindowButtonDownFcn,handles},...
                    'windowbuttonupfcn',{@Main_WindowButtonUpFcn,handles});
else
    set(handles.Main,'windowbuttondownfcn',[]);
    set(handles.Main,'windowbuttonupfcn',[]);
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
CurrentPoint=get(handles.Oscillo,'currentpoint');
OscilloXlim=get(handles.Oscillo,'xlim');
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
    CursorLine(CursorIndex,2)=plot(handles.CursorAxes,[CurrentPoint(1,1) CurrentPoint(1,1)],[-2.048 2.048],'m--');
    set(handles.Main,'windowbuttonmotionfcn',{@DrawLine,handles,CursorIndex});
    setappdata(handles.Cursor,'CursorLine',CursorLine);
end

function DrawLine(varargin)
handles=varargin{3};
CursorIndex=varargin{4};
CurrentPoint=get(handles.Oscillo,'currentpoint');
CursorLine=getappdata(handles.Cursor,'CursorLine');
CursorLine(CursorIndex,1)=CurrentPoint(1,1);
if ishandle(CursorLine(CursorIndex,2))
    delete(CursorLine(CursorIndex,2));
end
CursorLine(CursorIndex,2)=plot(handles.CursorAxes,[CurrentPoint(1,1) CurrentPoint(1,1)],[-2.048 2.048],'m--');
setappdata(handles.Cursor,'CursorLine',CursorLine);

function Main_WindowButtonUpFcn(varargin)
handles=varargin{3};
set(handles.Main,'windowbuttonmotionfcn',[]);
CursorLine=getappdata(handles.Cursor,'CursorLine');
CursorLine=sortrows(CursorLine,1);
setappdata(handles.Cursor,'CursorLine',CursorLine);

function ToNew_Callback(varargin)
NewTrace=CursorToNewTrace(varargin);
if ~isempty(NewTrace)
    continuous(NewTrace,'new');
end

function Main_DeleteFcn(varargin)
if strcmp(varargin{3},'single')
    clear global handles;
end

function FreqSpec_Callback(varargin)
handles=varargin{3};
Trace=getappdata(handles.Oscillo,'Trace');
CursorLine=getappdata(handles.Cursor,'CursorLine');
if isempty(CursorLine)
    msgbox('Select Cursor')
    return
end
if ~ishandle(CursorLine(:,2))
    msgbox('Select Cursor')
    return
end
interval=2^13;
AnalyzePoint=floor(CursorLine(1,1)/Trace.SampleInterval)+1;
added=cat(1,zeros(interval/2,1),Trace.Data(:,2),zeros(interval/2-1,1));
AnalyzeData=added(AnalyzePoint:AnalyzePoint+interval-1);
Freq=FourierSpec(AnalyzeData,1/Trace.SampleInterval);
figure('position',[19         637        1876         468]);
plot(Freq.frequency,Freq.amplitude);
label={'A0'	'A#0'	'B0'	'C1'	'C#1'	'D1'	'D#1'	'E1'	'F1'	'F#1'	'G1'	'G#1'	'A1'	'A#1'	'B1'	'C2'	'C#2'	'D2'	'D#2'	'E2'	'F2'	'F#2'	'G2'	'G#2'	'A2'	'A#2'	'B2'	'C3'	'C#3'	'D3'	'D#3'	'E3'	'F3'	'F#3'	'G3'	'G#3'	'A3'	'A#3'	'B3'	'C4'	'C#4'	'D4'	'D#4'	'E4'	'F4'	'F#4'	'G4'	'G#4'	'A4'	'A#4'	'B4'	'C5'	'C#5'	'D5'	'D#5'	'E5'	'F5'	'F#5'	'G5'	'G#5'	'A5'	'A#5'	'B5'	'C6'	'C#6'	'D6'	'D#6'	'E6'	'F6'	'F#6'	'G6'	'G#6'	'A6'	'A#6'	'B6'	'C7'	'C#7'	'D7'	'D#7'	'E7'	'F7'	'F#7'	'G7'	'G#7'	'A7'	'A#7'	'B7'	'C8'};
tick=[27.5	29.13523509	30.86770633	32.70319566	34.64782887	36.70809599	38.89087297	41.20344461	43.65352893	46.24930284	48.9994295	51.9130872	55	58.27047019	61.73541266	65.40639133	69.29565774	73.41619198	77.78174593	82.40688923	87.30705786	92.49860568	97.998859	103.8261744	110	116.5409404	123.4708253	130.8127827	138.5913155	146.832384	155.5634919	164.8137785	174.6141157	184.9972114	195.997718	207.6523488	220	233.0818808	246.9416506	261.6255653	277.182631	293.6647679	311.1269837	329.6275569	349.2282314	369.9944227	391.995436	415.3046976	440	466.1637615	493.8833013	523.2511306	554.365262	587.3295358	622.2539674	659.2551138	698.4564629	739.9888454	783.990872	830.6093952	880	932.327523	987.7666025	1046.502261	1108.730524	1174.659072	1244.507935	1318.510228	1396.912926	1479.977691	1567.981744	1661.21879	1760	1864.655046	1975.533205	2093.004522	2217.461048	2349.318143	2489.01587	2637.020455	2793.825851	2959.955382	3135.963488	3322.437581	3520	3729.310092	3951.06641	4186.009045];
YMin=tick(get(handles.Ymin,'value'));
YMax=tick(get(handles.Ymax,'value'));
set(gca,'xscale','log','xlim',[YMin YMax],'ylim',[0 0.2],'xticklabel',label,'xtick',tick);

function Rt=CursorToNewTrace(vars)
handles=vars{3};
Trace=getappdata(handles.Oscillo,'Trace');
CursorLine=getappdata(handles.Cursor,'CursorLine');
if isempty(CursorLine)
    msgbox('Select Cursor')
    Rt=[];
    return
end
if ~ishandle(CursorLine(:,2))
    msgbox('Select Cursor')
    Rt=[];
    return
end
Range=round(CursorLine(:,1)/Trace.SampleInterval);
Range(Range<1)=1;
Range(Range>size(Trace.Data,1))=size(Trace.Data,1);
NewRange=Range-Range(1)+1;
NewTrace.Data(:,1)=(NewRange(1):NewRange(2))*Trace.SampleInterval;
NewTrace.Data(:,2)=Trace.Data(Range(1):Range(2),2);
NewTrace.SampleInterval=Trace.SampleInterval;
NewTrace.XLim=[0 NewTrace.Data(NewRange(2),1)];
NewTrace.String=[Trace.String,' from:',num2str(Trace.Data(Range(1),1)),'S'];
NewTrace.From=Trace.Data(Range(1),1);
Rt=NewTrace;

function Zoom_Callback(varargin)
handles=varargin{3};
CursorLine=getappdata(handles.Cursor,'CursorLine');
if isempty(CursorLine)
    msgbox('Select Cursor')
    return
end
if ~ishandle(CursorLine(:,2))
    msgbox('Select Cursor')
    return
end
Trace=getappdata(handles.Oscillo,'Trace');
NewXLim=CursorLine(:,1);
set(handles.Oscillo,'xlim',NewXLim);
set(handles.CursorAxes,'xlim',NewXLim);
ImPos=get(handles.Image,'position');
TotalLen=Trace.XLim(2)-Trace.XLim(1);
OscLen=NewXLim(2)-NewXLim(1);
if NewXLim(1)>Trace.XLim(1) || NewXLim(2)<Trace.XLim(2)
    Step=[0.1/(TotalLen/OscLen-1),1/(TotalLen/OscLen-1)];
    if Step(2)>1
        Step=Step./Step;
    end
    set(handles.XSlide,'enable','on','min',Trace.XLim(1),'max',Trace.XLim(2)-OscLen,...
                        'value',NewXLim(1),'sliderstep',Step);
else
    set(handles.XSlide,'enable','off');
end
XWholePixel=int32(ImPos(3)*TotalLen/OscLen);
set(handles.Image,'xlim',(NewXLim-Trace.XLim(1))/TotalLen*double(XWholePixel));
setappdata(handles.Image,'XWholePixel',XWholePixel);
SpeedPlot(Trace,handles);

function TuneGraph_Callback(varargin)
handles=varargin{3};
Trace=getappdata(handles.Oscillo,'Trace');
Trace.From=0;
RangeCursor=getappdata(handles.Cursor,'CursorLine');
if ~isempty(RangeCursor)
    Trace=CursorToNewTrace(varargin);
end
Ylabel=get(handles.Ymin,'string');
tunegraph(Trace,Ylabel(get(handles.Ymin,'value')),Ylabel(get(handles.Ymax,'value')));

function Main_Close(varargin)
handles=varargin{3};
if get(handles.Play,'value')
    player=getappdata(handles.Play,'player');
    stop(player);
end
closereq;
