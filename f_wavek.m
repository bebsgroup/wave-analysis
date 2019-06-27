
function [wk]=f_wavek (w1,w2,w3)

g=9.8;    %m/s2 - gravity constant

% For w1
T=w1.wave.Tm02;
depth=w1.wave.mpress;

depth=abs(depth);
depth(isnan(depth))=0; 
T(isnan(T))=0;

%if length(depth)>=length(T)
for i=1:length(depth)
    if depth==0;
        wk.w1(i)=nan;
    elseif T==0;
        wk.w1(i)=nan;
    else
        %w=2.*pi./T;
        %h=depth(i);
        Lo(i)=(g*T(i)^2)/(2*pi)^2; % deepwater wavelength
        wk.w1(i)=2*pi/Lo(i);
        %x=fzero('dispn',guess,optimset('disp','off'));
        %wk(i)=x;
    end
end


%for w2

T=w2.wave.Tm02;
depth=w2.wave.mpress;

depth=abs(depth);
depth(isnan(depth))=0; 
T(isnan(T))=0;

%if length(depth)>=length(T)
    for i=1:length(depth)
        if depth==0;
        wk.w2(i)=nan;
        elseif T==0;
        wk.w2(i)=nan;
        else
        %w=2.*pi./T;
        %h=depth(i);
        Lo(i)=(g*T(i)^2)/(2*pi)^2; % deepwater wavelength
        wk.w2(i)=2*pi/Lo(i);
        %x=fzero('dispn',guess,optimset('disp','off'));
        %wk(i)=x;
	    end
    end

%for w3

T=w3.wave.Tm02;
depth=w3.wave.mpress;

depth=abs(depth);
depth(isnan(depth))=0; 
T(isnan(T))=0;

%if length(depth)>=length(T)
    for i=1:length(depth)
        if depth==0;
        wk.w3(i)=nan;
        elseif T==0;
        wk.w3(i)=nan;
        else
        %w=2.*pi./T;
        %h=depth(i);
        Lo(i)=(g*T(i)^2)/(2*pi)^2; % deepwater wavelength
        wk.w3(i)=2*pi/Lo(i);
        %x=fzero('dispn',guess,optimset('disp','off'));
        %wk(i)=x;
	    end
    end

