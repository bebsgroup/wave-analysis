function w=hanning(L)

N=L-1;
w=sin(pi.*(0:N)'./N).^2;

