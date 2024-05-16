
% FIR Low-pass Filter Design using Hamming Window

% Specifications
order = 50;                     % Filter order
cutoff_frequency = 3.5e3;       % Cutoff frequency in Hz
sampling_rate = 44.1e3;         % Sampling rate in Hz

% Design the FIR filter using Hamming window
fir_coefficients = fir1(order, cutoff_frequency/(sampling_rate/2), ...
                    'low', hamming(order + 1));

% Display the coefficients
%disp('FIR Coefficients:');
%disp(fir_coefficients);

% Time vector
t = 0:1/sampling_rate:0.005;

% Generate signals
signal = (sin(2*pi*1000*t));
noise = (0.5*sin(2*pi*11000*t)).*(0.8*cos(2*pi*9000*t));
noisy_signal = noise + signal;

filtered_noisy_signal = filter(fir_coefficients, 1, noisy_signal);
t = 0:1/sampling_rate:0.005;

% Generate signals
%signal = (sin(2*pi*1000*t))+(0.8*cos(2*pi*2000*t));  
%noise = (0.5*sin(2*pi*70000*t));
%noise2 = (0.5*sin(2*pi*20000*t));
%noise3 = (0.5*sin(2*pi*200000*t)).*(0.8*cos(2*pi*90000*t));
%signal2 =(sin(2*pi*3000*t));
%noisy_signal = noise + signal;
%noisy_signal2 = noise3 + signal2;

choice = noisy_signal;
%noise, noise2 ,signal ,noisy_siganl, noise3,signal2,noisy_siganl2

% Scale the signal to fit within the range of a 16-bit integer
scaled_signal = int16(choice * (2^15 - 1));
scaled_output = int16(filtered_noisy_signal *(2^15 -1));

% Convert the scaled signal to binary representation
binary_signal = dec2hex(typecast(scaled_signal, 'uint16'), 4);
binary_output = dec2hex(typecast(scaled_output, 'uint16'), 4);

%Save each 16-bit binary value on a separate line in the text file
fileID = fopen('Input_signal.txt', 'w');
for i = 1:size(binary_signal, 1)
    fprintf(fileID, '%s\n', binary_signal(i, :));
 end
fclose(fileID);

fileID = fopen('Output_signal.txt', 'w');
for i = 1:size(binary_output, 1)
    fprintf(fileID, '%s\n', binary_output(i, :));
 end
fclose(fileID);

% Plot the original signal in time domain
figure('Position', [100, 200, 2500, 600]);
plot(t, choice);
title('Original Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');


% Plot the original signal in time domain
figure('Position', [100, 200, 2500, 600]);
plot(t, filtered_noisy_signal);
title('Original Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
