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
%filtered_noise = filter(fir_coefficients, 1, noise);
%filtered_signal = filter(fir_coefficients, 1, signal);

%fir_coefficients_fixed = fi(fir_coefficients, true, 16, 15);
filtered_noisy_signal_fixed = fi(filtered_noisy_signal, true, 16, 15);
%noisy_signal_fixed = fi(noisy_signal, true, 16, 15);

% Write content to files in hexadecimal format
%write_to_file(fir_coefficients_fixed, 'D:\Digital_Electronics\DSP\DSP_course\dv\FIR\fir_coefficients.hex');
%write_to_file(noisy_signal_fixed, 'D:\Digital_Electronics\DSP\DSP_course\dv\FIR\noisy_signal_array.hex');
write_to_file(filtered_noisy_signal_fixed, 'binary_signal.txt');

% Plot original signal
figure('Position', [100, 100, 1800, 600]);
subplot(2, 1, 1);
plot(t, noisy_signal);
title('Original Signal (Before Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot filtered signal
subplot(2, 1, 2);
plot(t, filtered_noisy_signal,'Color','green');
title('Filtered Signal (After Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');

% Compute frequency content of the original signal
Y = fft(noisy_signal);
f = linspace(-sampling_rate/2, sampling_rate/2, length(Y)); % Shift frequency axis
Y_shifted = fftshift(Y); % Shift the spectrum

% Plot frequency content
figure;
plot(f, abs(Y_shifted),'Color','red');
title('Original SIN Signal (Frequency Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% Compute frequency content of the original signal
Y = fft(filtered_noisy_signal);
f = linspace(-sampling_rate/2, sampling_rate/2, length(Y)); % Shift frequency axis
Y_shifted = fftshift(Y); % Shift the spectrum

% Plot frequency content
figure;
plot(f, abs(Y_shifted),'Color','blue');
title('Filtered SIN Signal (Frequency Domain)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
