function varargout = Compress_Watermark(varargin)
% COMPRESS_WATERMARK MATLAB code for Compress_Watermark.fig
%      COMPRESS_WATERMARK, by itself, creates a new COMPRESS_WATERMARK or raises the existing
%      singleton*.
%
%      H = COMPRESS_WATERMARK returns the handle to a new COMPRESS_WATERMARK or the handle to
%      the existing singleton*.
%
%      COMPRESS_WATERMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPRESS_WATERMARK.M with the given input arguments.
%
%      COMPRESS_WATERMARK('Property','Value',...) creates a new COMPRESS_WATERMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Compress_Watermark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Compress_Watermark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Compress_Watermark

% Last Modified by GUIDE v2.5 08-May-2020 12:02:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compress_Watermark_OpeningFcn, ...
                   'gui_OutputFcn',  @Compress_Watermark_OutputFcn, ...
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


% --- Executes just before Compress_Watermark is made visible.
function Compress_Watermark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Compress_Watermark (see VARARGIN)

% Choose default command line output for Compress_Watermark
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Compress_Watermark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Compress_Watermark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path]=uigetfile({'*.jpg'}, 'Select an image');
global img
img=imread([path,file]);
axes(handles.axes1);
imshow(img);





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path]=uigetfile({'*.jpg'}, 'Select an image');
water=imread([path,file]);
axes(handles.axes3);
imshow(water);
global QV
QV = get(handles.edit1,'String');
global bit
bit = get(handles.edit2,'String');
bit = str2double(bit);
global img
[y,x,z]=size(img);
water=imresize(water,[y,x]);
waterR=im2bw(water(:,:,1));
waterG=im2bw(water(:,:,2));
waterB=im2bw(water(:,:,3));
watered_img=img;

for i = 1:y
    for j = 1:x
        img_hostR=dec2bin(img(i,j,1),8);
        img_hostG=dec2bin(img(i,j,2),8);
        img_hostB=dec2bin(img(i,j,3),8);
        img_hostR(bit)=num2str(waterR(i,j));
        img_hostG(bit)=num2str(waterG(i,j));
        img_hostB(bit)=num2str(waterB(i,j));
        watered_img(i,j,1)=bin2dec(img_hostR);
        watered_img(i,j,2)=bin2dec(img_hostG);
        watered_img(i,j,3)=bin2dec(img_hostB);
    end
end

imwrite(watered_img,'Compressed_img.jpg','jpg','Quality',str2double(QV));
global Comp_img
Comp_img=imread('Compressed_img.jpg');
axes(handles.axes2);
imshow(Comp_img);





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Comp_img
global bit
[y,x,z]=size(Comp_img);
CompR=Comp_img(:,:,1);
CompG=Comp_img(:,:,2);
CompB=Comp_img(:,:,3);
check_wR=zeros(y,x);
check_wG=zeros(y,x);
check_wB=zeros(y,x);
for i =1:y
    for j = 1:x
        C_waterR=dec2bin(CompR(i,j),8);
        C_waterG=dec2bin(CompG(i,j),8);
        C_waterB=dec2bin(CompB(i,j),8);
        check_wR(i,j)=str2double(C_waterR(bit));
        check_wG(i,j)=str2double(C_waterG(bit));
        check_wB(i,j)=str2double(C_waterB(bit));
    end
end
water_mark(:,:,1)=check_wR;
water_mark(:,:,2)=check_wG;
water_mark(:,:,3)=check_wB;
axes(handles.axes4);
imshow(water_mark);

        
        
        





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
