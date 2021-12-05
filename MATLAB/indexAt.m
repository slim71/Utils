function out = indexAt(expr, varargin)
% INDEXAT(...) returns the element OUT resulting from EXPR which can be
% indexed with the indexes in VARARGIN.
%
%   Example:
%       indexAt([[1,2,3];[4,5,6];[7,8,9]],1,3)
%   --> 3
%       indexAt([[1,2,3];[4,5,6];[7,8,9]],1:3,3)
%   --> 3 6 9
%
%   Input
%       expr:       expression from which to extract the elements
%       varargin:   indexes to use
%   Output
%       out:        elements selected
%
%
%   Credits:
%   Walter Roberson & Stephen
%   Answers at https://it.mathworks.com/matlabcentral/answers/127342-access-a-single-element-of-an-anonymous-function-that-returns-an-array
%

    out = expr(varargin{:});
end