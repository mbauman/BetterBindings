function cw = getCommandWindow()
% getCommandWindow - returns the handle to the command window

if exist('com.mathworks.mde.cmdwin.CmdWin','class') == 8
    base = com.mathworks.mde.cmdwin.CmdWin.getInstance();
elseif exist('com.mathworks.mde.desk.MLDesktop','class') == 8
    base = com.mathworks.mde.desk.MLDesktop.getInstance().getClient('Command Window');
else
    error('BetterBindings:unsupported','Unsupported Matlab version %s',version);
end

try
    % Note that the base has multiple components at this level in R2011a.
    % Do I need to worry if this will ever be ordered differently?
    h = base.getComponent(0).getViewport().getView();
    assert(strcmp(class(h),'com.mathworks.mde.cmdwin.XCmdWndView'));
catch %#ok<CTCH>
    h = BetterBindings.findComponent(base,'com.mathworks.mde.cmdwin.XCmdWndView');
    if isempty(h)
        error('BetterBindings:nocmdwin','Unable to find the Command Window');
    end
end

cw = handle(h,'CallbackProperties');

end
