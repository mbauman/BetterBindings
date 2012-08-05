package com.mbauman.betterbindings;

import javax.swing.ActionMap;
import javax.swing.Action;
import javax.swing.text.TextAction;
import javax.swing.text.EditorKit;
import java.awt.event.ActionEvent;

public class BetterActionMap extends ActionMap
{
    private static Action[] betterActions;

    public BetterActionMap(ActionMap actionMap, EditorKit editorKit)
    {
        super();
        betterActions = editorKit.getActions();
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
