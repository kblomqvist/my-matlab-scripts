% My comparator :: Kim Blomqvist 2010
% This function tries to behave like a comparator in electronics.
%
% Usage:
%   output = kb_comparator(input, [scale], [bias])
% Example:
%   x = -2*pi:0.01:2*pi; output = kb_comparator(sin(x));
%   plot(x, sin(x)); hold on; plot(x, output, 'r'); hold off;
%
function output = kb_comparator(input, scale, bias)
if nargin < 3 || isempty(bias)
    bias = 0;
end
if nargin < 2 || isempty(scale)
    scale = max(input);
end

L = length(input);
output = ones(L,1);
for i = 1:L
    if input(i) < bias
        output(i) = -1;
    end
end

output = output' .* scale;