function out = outval(fun, indexes, varargin)
% OUTVAL returns the output values of function FUN(varargin) at 
%   positions specified by INDEXES.
%
%   INDEXES can be a single integer or an array of integers.
%
%   OUT is of type 'cell' to support different types of data to be returned
%   in the same array.
%
%   FUN must be a function handle.
%
%   Error handling is left to standard behaviours.
%
% Example:
%   out = OUTVAL(@bounds, 1, [4,5,1,12]) returns the first return value of
%   the function 'bounds' (so the smallest element of the array given as
%   input)

% Implementation by Simone Vollaro (https://github.com/slim71)

    % Get 'fun' number of return values
    mycell = cell(1, nargout(fun));
    
    % Get 'fun' return values
    [mycell{:}] = fun(varargin{:});

    % Return selected elements
    out = cell(size(indexes));
    for i=indexes
        out(i) = mycell(i);
    end
end