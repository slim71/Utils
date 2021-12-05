function FigHandle = figure2(varargin)
% FIGURE2 create a new figure in the second screen, if available.
%         Replaces normal figure(); number of figure not (yet) supported.
%
%   Modified by Simone Vollaro
%
%   Credits: 
%   Jan in Mathworks Forum
%   (https://it.mathworks.com/matlabcentral/answers/16663-is-it-possible-to-viewing-the-figure-window-on-second-display)
%
%   'WindowState' added as for
%   https://it.mathworks.com/matlabcentral/answers/98331-is-it-possible-to-maximize-minimize-or-get-the-state-of-my-figure-programmatically-in-matlab
%

    MP = get(0, 'MonitorPositions');
    if size(MP, 1) == 1  % Single monitor
      FigH = figure(varargin{:});
      set(FigH, 'WindowState', 'maximized');
    else                 % Multiple monitors
        % Catch creation of figure with disabled visibility: 
        indexVisible = find(strncmpi(varargin(1:2:end), 'Vis', 3));
        if ~isempty(indexVisible)
            paramVisible = varargin(indexVisible(end) + 1);
        else
           paramVisible = get(0, 'DefaultFigureVisible');
        end
        %
        Shift    = MP(2, 1:2);
        FigH     = figure(varargin{:}, 'Visible', 'off');
        drawnow;
        set(FigH, 'Units', 'pixels');
        pos      = get(FigH, 'Position');
        pause(0.02);  % See Stefan Glasauer's comment

        set(FigH, 'Position', [pos(1:2) + Shift, pos(3:4)], ...
                'Visible', paramVisible,'WindowState','maximized');
        pause(1); %to return the real position after maximization
    end
    if nargout ~= 0
      FigHandle = FigH;
    end
end