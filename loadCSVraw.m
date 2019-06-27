function data=loadCSVraw(pname,fname)
% function data=loadCSVraw(pname,fname)
%
%Created by Brad Morris
%Tuesday 21 March 2017
%Last modified Tuesday 21 March 2017

global last_data_path

if isempty(last_data_path)||~ischar(last_data_path)
    init_data_path=pwd;
else
    init_data_path=last_data_path;
end

if nargin==0
    [fname,pname]=uigetfile([init_data_path filesep '*.csv'],...
        'Get .csv file');
end

if ~isempty(strfind(fname,'*'))
    [fname,pname]=uigetfile([pname filesep fname '.csv'],...
        'Get .csv file');
end

last_data_path=pname;

if isnumeric(fname)||isnumeric(pname)
    error('No file selected !!')
end

fid=fopen([pname fname]);
%ARQUIVO01 - PT2X
%d=textscan(fid,'%f%s%f%f','headerlines',29,'delimiter',',');

%ARQUIVO02 - RBR
d = textscan(fid,'%D%f%f%f', 'headerlines',1,'delimiter',',');

fclose(fid);

data.info.pname=pname;
data.info.fname=fname;

%ARQUIVO01 - PT2X
% tic
%data.rec=d{1};
%data.datestr=char(d{2});
%data.time=datenum(char(d{2}));
%data.temp=d{3};
%data.press=d{4};
% toc

%ARQUIVO02 - RBR
%data.datestr=char(d{1});
data.time = datenum(char(d{1})); 
data.press = d{3}; 


% rl=15;%min
% dt=0.25;%sec
% bl=(rl/dt)*60;
% nbl=floor(size(data.time,1)/bl);
% 
% time=reshape(data.time(1:nbl*bl),bl,nbl);
% press=reshape(data.press(1:nbl*bl),bl,nbl);
% temp=reshape(data.temp(1:nbl*bl),bl,nbl);