function PT_outCSV(wave)
% function PT_outCSV(wave)
%
%Created by Brad Morris
%Wednesday 22 March 2017
%Last modified Wednesday 22 March 2017

opname=wave.info.pname;
ofname=strrep(wave.info.fname,'.csv','_waves.csv');

vnames={'time','Hm0','Hrms','Hmax','Tm02','Tm01','Tpeak','Hsig','Hmax','Tz'};
% vnames={'time','Hm0','Hrms','Hmax','Tm02','Tm01','Tpeak'};

v=[]; vq=[];pf=[];

for k=1:size(vnames,2)
    v=[v vnames{k} ','];
    
    if k==1
        pf=[pf '%s,'];
    else
        pf=[pf '%05.2f,'];
        switch vnames{k}
            case {'Hsig','Hmax','Tz'}
        vq=[vq wave.zeroup.(vnames{k})'];    
            otherwise
        vq=[vq wave.(vnames{k})'];
        end
    end
end
v=v(1:end-1);
pf=[pf(1:end-1) ' \n'];

fid=fopen([opname ofname],'w');
fprintf(fid,'%s\n',v);
for k=1:size(vq,1)
    fprintf(fid,pf,datestr(wave.time(k),0),vq(k,:));
end
fclose(fid);