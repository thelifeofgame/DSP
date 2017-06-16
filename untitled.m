function varargout = untitled(varargin)
% UNTITLED M-file for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 21-May-2017 10:38:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Fs=12000;                               %抽样频率
time=10;                                %录音时间
x=wavrecord(time*Fs,Fs,'double');            %录制语音信号
wavwrite(x,Fs,'20130829.wav ');   %存储语音信号

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
y=wavread('20130829.wav ');
wavplay(y,12000);    %播放录音

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[z1,fs,bits]=wavread(' F:\52102426\20130829.wav ')
y1=z1(1:18000);
Y1=fft(y1);

wp=0.2*pi;
ws=0.25*pi;
wdel=ws-wp;
N=ceil(8*pi/wdel);
Wn=(ws+wp)/2;
window=hamming(N+1);
b=fir1(N,Wn/pi,window);
x=fftfilt(b,z1);
sound(x,fs,bits);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
[z1,fs,bits]=wavread('20130829.wav ')
y1=z1(1:18000);
Y1=fft(y1);
wp=0.2*pi;
ws=0.25*pi;
tr_width=ws-wp;
M=ceil(8*pi/tr_width)+1;%求序列长度
n=0:M-1;
wc=(ws+wp)/2;
alpha=(M-1)/2;
m=n-alpha+eps;%右移
hd=sin(wc*m)./(pi*m);%给定的HD
w_ham=(hamming(M))';%汉明窗
h=hd.*w_ham;%加窗
[mag,db,pha,w]=freqz_m(h,[1]);
axes(handles.axes1);
plot(w/pi,db);
title('滤波器幅度响应');
axis([0,1,-100,10]);
ylabel('H(db)');

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
function [mag,db,pha,w]=freqz_m(b,a)
[H,w]=freqz(b,a,1000,'whole');
H=(H(1:501))';
w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
[z1,fs,bits]=wavread('20130829.wav ')
y1=z1(1:18000);
Y1=fft(y1);
wp=0.2*pi;
ws=0.25*pi;
wdel=ws-wp;
N=ceil(8*pi/wdel);
Wn=(ws+wp)/2;
window=hamming(N+1);
b=fir1(N,Wn/pi,window);
x=fftfilt(b,z1);
X=fft(x,18000);
axes(handles.axes4);
plot(abs(Y1));axis([0,10000,0,100]);
title('滤波前信号频谱');
axes(handles.axes2);
plot(z1);
title('滤波前信号波形');
axes(handles.axes5);
plot(abs(X));axis([0,10000,0,100]);
title('滤波后信号频谱')
axes(handles.axes3);
plot(x);
title('滤波后信号波形');

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


