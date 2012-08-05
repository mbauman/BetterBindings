package com.mbauman.betterbindings;

import javax.swing.text.DefaultEditorKit;
import javax.swing.text.EditorKit;
import javax.swing.Action;
import javax.swing.text.TextAction;
import java.awt.event.ActionEvent;


public class BetterEditorKit extends DefaultEditorKit
/*  implements ClipboardListener */
{
    private EditorKit baseEditorKit;

    public BetterEditorKit(EditorKit kit)
    {
        baseEditorKit = kit;
    }

    public Action[] getActions()
    {
        return new Action[] {};
    }
}
