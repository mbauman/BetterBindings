package com.mbauman.betterbindings;

import javax.swing.ActionMap;
import javax.swing.Action;
import javax.swing.text.TextAction;
import java.awt.event.ActionEvent;

public class BetterEditorActionMap extends ActionMap
{
    private static ActionMap betterActionMap;
    private static final Action[] betterActions = 
        new Action[] { };
    
    public BetterEditorActionMap(ActionMap actionMap)
    {
        super();
        this.setParent(actionMap);
        for (int i=0; i < betterActions.length; i++) {
            this.put(betterActions[i].getValue("Name"),betterActions[i]);
        }
    }
        
    public Action getOriginalAction(String name)
    {
        return this.getParent().get(name);
    }
    
}
