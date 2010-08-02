% Integral :: Kim Blomqvist 2010
% Integrates the input signal
%
% Usage:
%   y = kb_integral(x);
% Example:
%   x = -2*pi:0.01:2*pi; y = kb_integral(sin(x))
%
function y = kb_integral(x)
L = length(x);
y = sum(x)/L;
