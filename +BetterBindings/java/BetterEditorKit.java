package com.mbauman.betterbindings;

import javax.swing.text.DefaultEditorKit;
import javax.swing.text.EditorKit;
import javax.swing.Action;
import javax.swing.text.TextAction;
import java.awt.event.ActionEvent;

import javax.swing.text.Caret;
import javax.swing.text.ViewFactory;
import javax.swing.text.Document;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.Writer;


public class BetterEditorKit extends EditorKit
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

    /* Abstract API that is imlemented by the base editorKit */
    public Caret createCaret()
    {
        return baseEditorKit.createCaret();
    }
    public Document createDefaultDocument()
    {
        return baseEditorKit.createDefaultDocument();
    }
    public String getContentType()
    {
        return baseEditorKit.getContentType();
    }
    public ViewFactory getViewFactory()
    {
        return baseEditorKit.getViewFactory();
    }
    public void read(InputStream in, Document doc, int pos)
        throws java.io.IOException, javax.swing.text.BadLocationException
    {
        baseEditorKit.read(in,doc,pos);
    }
    public void read(Reader in, Document doc, int pos)
        throws java.io.IOException,javax.swing.text.BadLocationException
    {
        baseEditorKit.read(in,doc,pos);
    }
    public void write(OutputStream out, Document doc, int pos, int len)
        throws java.io.IOException,javax.swing.text.BadLocationException
    {
        baseEditorKit.write(out,doc,pos,len);
    }
    public void write(Writer out, Document doc, int pos, int len)
        throws java.io.IOException,javax.swing.text.BadLocationException
    {
        baseEditorKit.write(out,doc,pos,len);
    }
}
