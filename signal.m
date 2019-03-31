% Using an adaptive filter to eliminate broadband noise from a
% narrowband signal
% Using LMS algorithm 
%
close all; clear all;   
n = 1:1000; %Number of points for plotting
%
% Generate unknown system and noise input
drum=wavread('/signals/guitar.wav'); %input .wav signal
fs=44100; %sampling frequency of input .wav signal
L=16; %optimal filter order
xn=0.01*randn(size(drum));    %random noise
z = drum + xn;     %noisy signal 
subplot(2,2,1)
plot(drum(1:1000)) %plot of original signal for 1000 samples
title('Original input signal');xlabel('Frequency');ylabel('Amplitude');
subplot(2,2,2)
plot(z(1:1000)) %plot of noisy signal for 1000 samples
title('Noisy time domain signal');xlabel('Frequency');ylabel('Amplitude');
%
M=length(z); %length of noisy signal
delay=L; 
delta=0.005; %step size(convergence gain) of adaptive filter
zd=[zeros(1,delay-1) z(delay:M)']; %delaying noisy signal by the filter order
[b ,y, e]= lms(zd(1:441000),z(1:441000)',delta,L); % Apply LMS algorithm using function lms
% display (b);
subplot(2,2,3)
plot(n,y(1:1000))       % Plot of filtered output
title('Filtered Signal');xlabel('Frequency');ylabel('Amplitude');
subplot(2,2,4)
plot(n,e(1:1000))%plot of error signal
title('error signal'); xlabel('Frequency');ylabel('Amplitude');
drum_seg=drum(44100*1:44100*10); 
sound(drum_seg,44100); %original sound for 1st 10 seconds 
noisydrum_seg=z(44100*1:44100*10); 
sound(noisydrum_seg,44100); %noisy sound for 1st 10 seconds
filterdrum_seg=y(44100*1:44100*10);
sound(filterdrum_seg,44100); %filtered sound for 1st 10 seconds