function obj = findComponent(parent,classname)
% findComponent  Search Java AWT 'parent' for a component of class 'classname'
% - Recursively descends through a GUI hierarchy depth-first with getComponent
% - Returns the first object of the class it discovers (or empty if not found)
obj = [];

if ~ismethod(parent,'getComponentCount') || ~ismethod(parent,'getComponent')
    return
end

for i=0:parent.getComponentCount()-1
    child = parent.getComponent(i);
    if strcmp(child.class(),classname)
        obj = child;
    else
        obj = BetterBindings.findComponent(child,classname);
    end
    if ~isempty(obj)
        obj = handle(obj,'CallbackProperties');
        break
    end
end

end
