%Compacts data from the matfiles obtained with PT_tool_final and gets them
%ready to be merged with the rest of the deployments to create one single
%mat file with all data.


w3c.data=data;
w3c.data_raw=data_raw;
clear data
clear data_raw
w3c.IGwave=IGwave;
clear IGwave
w3c.p=p;
clear p
w3c.wave=wave;
clear wave

clear bl
clear dt
clear k
clear nbl
clear out
clear rl

w3c.zeroup.NonFilt=NonFilt;
clear NonFilt

w3c.zeroup=zeroup;
clear zeroup

clear b
clear Fc
clear Fcc
clear Fs

