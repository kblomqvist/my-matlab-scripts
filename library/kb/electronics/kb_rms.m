% My root mean square :: Kim Blomqvist 2010
% Calculates the RMS value of input signal.
%
% Usage:
%   rms = kb_rms(input);
% Example:
%   x = -2*pi:0.01:2*pi; kb_rms(sin(x))
%
function rms = kb_rms(input)
L = length(input);
input = input.*input;   % Square
input = sum(input)/L;   % Mean
rms = sqrt(input);      % Root