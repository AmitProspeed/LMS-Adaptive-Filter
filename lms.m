function [b,y,e] = lms(x,d,delta,L)
%
% Inputs: x = input(delayed noisy signal)
% d = desired signal(noisy output signal)
% delta = the convergence gain
% L is the length (order) of the FIR filter
% Outputs: b = FIR filter coefficients
% y = ALE output
% e = residual error
% LMS function to adjust filter coefficients using LMS Algorithm
% Adjusts filter coefficients, b, to provide the best match
% between the input, x(n), and a desired waveform, d(n),
% Both waveforms must be the same length
% Uses a standard FIR filter
%
N = length(x);
b = zeros(1,L); %initialize filter coefficients
y = zeros(1,N); % Initialize outputs
for n=L:N
x1 = x(n:-1:n-L+1); % Select input for convolution
y(n) = b * x1'; % Convolve (multiply)weights with input
e(n) = d(n)-y(n); % Calculate error
b = b + delta*e(n)*x1% Adjust weights
end

