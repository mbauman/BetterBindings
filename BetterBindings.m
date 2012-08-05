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

function install()

javaaddpath(getJarFilepath());
cmdwin = BetterBindings.getCommandWindow();
editor = BetterBindings.getEditor();

makeDefaultActionIgnoreModifiedKeystrokes([cmdwin,editor]);
attachBetterActionMap(cmdwin,'BetterCmdWinActionMap');
attachBetterActionMap(editor,'BetterEditorActionMap');

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

function attachBetterActionMap(textComponents,klass)
klass = [getPackageName() '.' klass];
for t = textComponents
    actionMap = t.getActionMap();
    if ~strcmp(actionMap.class(),klass)
        newMap = feval(klass,actionMap);
        t.setActionMap(newMap);
    end
end
end

function revertActionMap(textComponents)
for t = textComponents
    map = t.getActionMap();
    if any(strcmp(map.class(),{[getPackageName() '.BetterCmdWinActionMap'],...
                               [getPackageName() '.BetterEditorActionMap']}))
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
