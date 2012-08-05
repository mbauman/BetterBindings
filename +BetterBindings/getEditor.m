function ed = getEditor()
% getEditor - get a handle to an EditorSyntaxTextPane instance
% Try to do so in the least undocumented (and most robust) way

if exist('matlab.desktop.editor.Document','class') == 8
    doc = matlab.desktop.editor.getActive(); % <- A real API! (R2011a+)
    viewclient = doc.JavaEditor.getComponent(); % Here be undocumented dragons
elseif exist('com.mathworks.mde.desk.MLDesktop','class') == 8
    viewclients = com.mathworks.mde.desk.MLDesktop.getInstance().getGroupMembers('Editor');
    viewclient = viewclients(1);
else
    error('BetterBindings:unsupported','Unsupported Matlab version %s',version);
end

try
    % Simply implementing the STP Interface is insufficient for changing keybindings
    ed = handle(viewclient.getEditorView().getSyntaxTextPane().getActiveTextComponent(),'CallbackProperties');
    assert(strcmp(class(ed),'javahandle_withcallbacks.com.mathworks.mde.editor.EditorSyntaxTextPane'));
catch %#ok<CTCH>
    ed = BetterBindings.findComponent(viewclient,'com.mathworks.mde.editor.EditorSyntaxTextPane');
end

if isempty(ed)
    error('MB:BetterBindings:NoEditorWindow','Unable to find the Editor Window');
end

end

% function b = implementsSTPInterface(jHandle)
%     b = any(arrayfun(@(iface) ...
%         strcmp(iface.getCanonicalName(),'com.mathworks.mde.editor.EditorSTPInterface'),...
%         jHandle.getClass().getInterfaces()));
% end
