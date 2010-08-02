% Phase sensitive detector demonstration :: Kim Blomqvist 2010
%
%% Add library path
CURRENT_PATH = cd;
LIBRARY_PATH = [CURRENT_PATH, '/../../library'];

addpath([LIBRARY_PATH, '/kb/signals'], '-begin');
addpath([LIBRARY_PATH, '/kb/electronics'], '-begin');
addpath([LIBRARY_PATH, '/kb/math'], '-begin');

%% Static demo
Fs = 10000;     % Samplig frequency
T = 1/Fs;       % Sample time
L = 1000;       % Length of signal
t = (0:L-1)*T;  % Time vector

% Local oscillators
A_lo = 1; f_lo = 50;
lo_i = A_lo*sin(2*pi*f_lo*t);        % LO oscillator in phase
lo_q = A_lo*sin(2*pi*f_lo*t + pi/2); % LO quadrature phase

% Use comparator for LO signals
% Try to comment these two lines and check what happens
lo_i = kb_comparator(lo_i);
lo_q = kb_comparator(lo_q);

% Input signal, try variate phase (and frequency, but take care of Fs)
A_in = 1; f_in = 50; pha = 0;
in = A_in*sin(2*pi*f_in*t + pha);

% Detected signal
i = lo_i.*in;       % Input signal mixed in phase local oscillator
q = lo_q.*in;       % Input signal mixed quadrature phase local oscillator

% Low-pass filtering to grab dc from mixed signal, ideal fc = 0 Hz!
i_filt = kb_integral(i);
q_filt = kb_integral(q);

% Plot time domain signals
figure(1);
subplot(3,2,1); plot(t, lo_i, 'r--', 'lineWidth', 2); hold on; plot(t, in);
title('Signal and local in-phase oscillator waveforms');
xlabel('Time (ms)'); ylabel('Amplitude (V)'); hold off;

subplot(3,2,2); plot(t, lo_q, 'r--', 'lineWidth', 2), hold on; plot(t, in);
title('Signal and local quadrature phase oscillator waveforms');
xlabel('Time (ms)'); ylabel('Amplitude (V)'); hold off;

subplot(3,2,3); plot(t, i_filt, 'r--', 'lineWidth', 2); hold on; plot(t, i);
title('In-phase channel and dc');
xlabel('Time (ms)'); ylabel('Amplitude (V)'); hold off;

subplot(3,2,4); plot(t, q_filt, 'r--', 'lineWidth', 2), hold on; plot(t, q);
title('Quadrature phase channel and dc');
xlabel('Time (ms)'); ylabel('Amplitude (V)'); hold off;

% Plot FFT
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y_i = fft(i,NFFT)/L;
Y_q = fft(q,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

subplot(3,2,5); plot(f, abs(Y_i(1:NFFT/2+1)));
title('FFT of in-phase channel');
xlabel('Frequency (Hz)'); ylabel('|Y(f)|');

subplot(3,2,6); plot(f, abs(Y_q(1:NFFT/2+1)));
title('FFT of quadrature phase channel');
xlabel('Frequency (Hz)'); ylabel('|Y(f)|');