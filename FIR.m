clear;
clc;
close all;

f = [0 0.5 0.5 1]; % defines normalized frequency points
m = [1 1 0 0]; % defines the desired magnitude of the filter at each frequency point
b = fir2(20, f, m); % designs the FIR filter
[h, w] = freqz(b, 1, 128); % calculates the frequency response of the filter
plot(f, m, w/pi, abs(h)); % plots two curves
% f m is the ideal
% w/pi abs(h) is the actual FIR response

grid on;
xlabel('Normalized Frequency');
ylabel('Magnitude');
title('20th-Order Low-Pass FIR Filter');
legend('Ideal Response', 'Actual FIR Response');

% Normalize the FIR coefficients
b_normalized = b * (32767 / sum(b));

% Round to integer values
b_integer = round(b_normalized);

% Display the coefficients
disp('Normalized integer FIR coefficients:');
disp(b_integer);

% Verify coefficient count
disp(length(b_integer));

% Display minimum and maximum values
disp(min(b_integer));
disp(max(b_integer));

% Check the coefficient sum
disp(sum(b_integer));

% Check symmetry
disp(isequal(b_integer, fliplr(b_integer)));

writematrix(b_integer(:), 'fir_coefficients.txt');