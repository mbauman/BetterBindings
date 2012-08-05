function BetterBindings(command,varargin)

if ~usejava('desktop')
    error('BetterBindings:nojava','Java must be enabled');
end

switch lower(command)
    case {'i' 'install'}
        install(varargin{:});
    case {'b' 'bind'}
        bind(varargin{:});
    case {'u' 'uninstall'}
        uninstall(varargin{:});
    otherwise
        help();
end

end

%% Top level functions
function install()
javaaddpath(getJarFilepath());

cw = BetterBindings.getCommandWindow();
ed = BetterBindings.getEditor();

makeDefaultActionIgnoreModifiedKeystrokes([cw,ed]);

cwKit = BetterBindings.getPrivateJObj(cw,'fCWKit'); % R2011a
attachBetterActionMap(cw,com.mbauman.betterbindings.BetterCmdWinKit(cwKit));

edKit = ed.getEditorKit();
attachBetterActionMap(ed,com.mbauman.betterbindings.BetterEditorKit(edKit));

end

function uninstall()

cmdwin = BetterBindings.getCommandWindow();
editor = BetterBindings.getEditor();

revertDefaultAction([cmdwin,editor]);
revertActionMap([cmdwin,editor]);
% Garbage collection must be run before javarmpath for it to work. 
% It probably happens before now anyways, but just make sure:
java.lang.System.gc() 

s = warning('off','MATLAB:GENERAL:JAVARMPATH:NotFoundInPath');
javarmpath(getJarFilepath());
warning(s);

end

function bind()
error('unimplemented');
end

%% Attaching and removing the custom java elements
function makeDefaultActionIgnoreModifiedKeystrokes(textComponents)
klass = [getPackageName() '.IgnoreModifiedKeystrokesAction'];
for t = textComponents
    defaultAction = t.getKeymap().getDefaultAction();
    if ~strcmp(defaultAction.class(),klass)
        newAction = feval(klass,defaultAction);
        t.getKeymap().setDefaultAction(newAction);
    end
end
end

function revertDefaultAction(textComponents)
klass = [getPackageName() '.IgnoreModifiedKeystrokesAction'];
for t = textComponents
    defaultAction = t.getKeymap().getDefaultAction();
    if strcmp(defaultAction.class(),klass)
        oldAction = defaultAction.getOriginalAction();
        t.getKeymap().setDefaultAction(oldAction);
    end
end
end

function attachBetterActionMap(textComponent,editorKit)
actionMap = textComponent.getActionMap();
if ~strcmp(actionMap.class(),'BetterActionMap')
    newMap = com.mbauman.betterbindings.BetterActionMap(actionMap,editorKit);
    textComponent.setActionMap(newMap);
end
end

function revertActionMap(textComponents)
for t = textComponents
    map = t.getActionMap();
    if strcmp(map.class(),[getPackageName() '.BetterActionMap'])
        oldMap = map.getParent();
        t.setActionMap(oldMap);
    end
end
end


%% Small utilities
function pkg = getPackageName()
pkg = 'com.mbauman.betterbindings';
end


function filename = getJarFilepath()
filename = fullfile(fileparts(mfilename('fullpath')),...
    ['+' mfilename()],'java',[getPackageName() '.jar']);
end
