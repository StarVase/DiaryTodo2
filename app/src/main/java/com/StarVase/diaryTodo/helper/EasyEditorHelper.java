package com.StarVase.diaryTodo.helper;

import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.AppCompatEditText;
import com.StarVase.diaryTodo.R;
import com.StarVase.diaryTodo.helper.MarkdownTableBuilder;

/**

 * An action class of editor.

 */
public class EasyEditorHelper {
    private Context context; // context instance

    private AppCompatEditText editText; // edittext instance

    private UndoRedoHelper undoRedoHelper;

    public EasyEditorHelper() {
    }

    public EasyEditorHelper(Context context) {
        this.context = context;
    }

    public EasyEditorHelper(Context context, AppCompatEditText editText) {
        this.context = context;
        this.editText = editText;
        this.undoRedoHelper = new UndoRedoHelper(editText);
    }

    /**

     * Insert markdown heading markup, if there was nothing input, insert "#" markup to 0 position.

     * Otherwise, insert the markup at position which after line break.

     */
    public void heading() {
        int start = editText.getSelectionStart();
        String textContent = editText.getText().toString();
        int lineBreakPos = textContent.lastIndexOf("\n", start);
        int insertPos;
        if (lineBreakPos == -1) {
            insertPos = 0;
        } else {
            insertPos = lineBreakPos + 1;
        }
        editText.getText().insert(insertPos, "#");
        String afterInsert = editText.getText().toString().substring(insertPos + 1);
        if (!afterInsert.startsWith("#") && !afterInsert.startsWith(" ")) {
            editText.getText().insert(insertPos + 1, " ");
        }
    }

    /**

     * Add markdown bold markup.

     * If there was select something, add markup beside the selected text.

     * Otherwise, just add the markup and set the cursor position at the middle of markup.

     */
    public void bold() {
        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(start, "****");
            editText.setSelection(start + 2);
        } else {
            editText.getText().insert(start, "**");
            editText.getText().insert(end + 2, "**");
        }
    }

    /**

     * Add markdown italic markup.

     * If there was select something, add markup beside the selected text.

     * Otherwise, just add the markup and set cursor position at the middle of markup.

     */
    public void italic() {
        // Add markdown italic markup

        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(start, "**");
            editText.setSelection(start + 1);
        } else {
            editText.getText().insert(start, "*");
            editText.getText().insert(end + 1, "*");
        }
    }

    /**

     * Add Add html underline tag

     * If there was select something, add markup beside the selected text.

     * Otherwise, just add the markup and set cursor position at the middle of markup.

     */
    public void underline() {
        // Add html underline tag

        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(start, "<u></u>");
            editText.setSelection(start + 3);
        } else {
            editText.getText().insert(start, "<u>");
            editText.getText().insert(end + 3, "</u>");
        }
    }


    /**

     * Add Add html deleteline tag

     * If there was select something, add markup beside the selected text.

     * Otherwise, just add the markup and set cursor position at the middle of markup.

     */
    public void deleteline() {
        // Add html underline tag

        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(start, "~~~~");
            editText.setSelection(start + 2);
        } else {
            editText.getText().insert(start, "~~");
            editText.getText().insert(end + 2, "~~");
        }
    }

    /**

     * Add markdown code markup.

     * If there was select something, add markup beside the selected text.

     * Otherwise, open a dialog to input programming language name,

     * and insert block code markup after input.

     */
    public void insertCode() {
        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) { // Insert block code markup if there was nothing selected.

            AlertDialog.Builder blockCodeDialog = new AlertDialog.Builder(context);
            blockCodeDialog.setTitle(R.string.editor_dialog_title_insert_block_code);

            LayoutInflater inflater = ((AppCompatActivity) context).getLayoutInflater();
            final View view = inflater.inflate(R.layout.dialog_insert_code, null);
            blockCodeDialog.setView(view);

            blockCodeDialog.setNegativeButton(R.string.cancel,
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.cancel();
                    }
                });
            blockCodeDialog.setPositiveButton(R.string.dialog_btn_insert,
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        EditText langNameET = view.findViewById(R.id.lang_name);
                        String langName = langNameET.getText().toString();
                        int end = editText.getSelectionEnd();
                        editText.getText().insert(end, "\n```" + langName + "\n\n```\n");
                        editText.setSelection(end + 5 + langName.length());
                    }
                });
            blockCodeDialog.show();
        } else { // Otherwise, insert inline code markup

            editText.getText().insert(start, "`");
            editText.getText().insert(end + 1, "`");
        }
    }
    
    
    /**

     * Add markdown block quote markup.

     */
    public void asciimath() {
        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(end, "\n```asciimath\n\n```\n");
            editText.setSelection(end + 12);
        } else {
            editText.getText().insert(start, "\n```asciimath");
            editText.getText().insert(end + 12, "\n```\n");
        }
    }

    

    /**

     * Add markdown block quote markup.

     */
    public void quote() {
        int start = editText.getSelectionStart();
        int end = editText.getSelectionEnd();
        if (start == end) {
            editText.getText().insert(start, "> ");
            editText.setSelection(start + 2);
        } else {
            editText.getText().insert(start, "\n\n> ");
            editText.setSelection(end + 4);
        }
    }

    /**

     * Add markdown ordered list markup.

     */
    public void orderedList() {
        int start = editText.getSelectionStart();
        editText.getText().insert(start, "\n1. ");
    }

    /**

     * Add markdown unordered list markup.

     */
    public void unorderedList() {
        int start = editText.getSelectionStart();
        editText.getText().insert(start, "\n* ");
    }


    /**

     * Add markdown todo list markup.

     */
    public void todoList() {
        int start = editText.getSelectionStart();
        editText.getText().insert(start, "\n- [x] ");
    }


    /**

     * Add markdown divider markup.

     */
    public void divider() {
        int start = editText.getSelectionStart();
        editText.getText().insert(start, "\n------ \n\n");
    }


    /**

     * Insert markdown link markup.

     */
     
    public void insertLink() {
        AlertDialog.Builder linkDialog = new AlertDialog.Builder(context);
        linkDialog.setTitle(R.string.dialog_title_insert_link);
        LayoutInflater inflater = ((AppCompatActivity) context).getLayoutInflater();
        final View view = inflater.inflate(R.layout.dialog_insert_link, null);
        final EditText linkDisplayTextET = view.findViewById(R.id.link_display_text);
        final EditText linkContentET = view.findViewById(R.id.link_content);

        final int start = editText.getSelectionStart();
        final int end = editText.getSelectionEnd();
        if (start < end) {
            String selectedContent = editText.getText().subSequence(start, end).toString();
            linkDisplayTextET.setText(selectedContent);
            linkContentET.requestFocus();
        }
        linkDialog.setView(view);
        linkDialog.setNegativeButton(R.string.cancel,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    dialog.cancel();
                }
            });

        linkDialog.setPositiveButton(R.string.dialog_btn_insert,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String linkDisplayText = linkDisplayTextET.getText().toString();
                    String linkContent = linkContentET.getText().toString();
                    if (linkDisplayText.equals("")) {
                        linkDisplayText = "Link";
                    }
                    String content = "[" + linkDisplayText + "]" + "(" + linkContent + ")";
                    if (start == end) {
                        editText.getText().insert(start, content);
                    } else {
                        editText.getText().replace(start, end, content);
                    }
                    if (linkContent.equals("")) {
                        editText.setSelection(content.length() - 1);
                    }
                }
            });
        linkDialog.show();
    }
    
    /**

     * Insert markdown link markup.

     */
     
    public void insertImg() {
        AlertDialog.Builder linkDialog = new AlertDialog.Builder(context);
        linkDialog.setTitle(R.string.dialog_title_insert_image);
        LayoutInflater inflater = ((AppCompatActivity) context).getLayoutInflater();
        final View view = inflater.inflate(R.layout.dialog_insert_image, null);
        final EditText displayET = view.findViewById(R.id.image_display_text);
        final EditText uriET = view.findViewById(R.id.image_uri);

        final int start = editText.getSelectionStart();
        final int end = editText.getSelectionEnd();
        if (start < end) {
            String selectedContent = editText.getText().subSequence(start, end).toString();
            displayET.setText(selectedContent);
            uriET.requestFocus();
        }
        linkDialog.setView(view);
        linkDialog.setNegativeButton(R.string.cancel,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    dialog.cancel();
                }
            });

        linkDialog.setPositiveButton(R.string.dialog_btn_insert,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String linkDisplayText = displayET.getText().toString();
                    String linkContent = uriET.getText().toString();
                    if (linkDisplayText.equals("")) {
                        linkDisplayText = "Image";
                    }
                    String content = "![" + linkDisplayText + "]" + "(" + linkContent + ")";
                    if (start == end) {
                        editText.getText().insert(start, content);
                    } else {
                        editText.getText().replace(start, end, content);
                    }
                    if (linkContent.equals("")) {
                        editText.setSelection(content.length() - 1);
                    }
                }
            });
        linkDialog.show();
    }
    

    /**

     * Insert markdown image markup.

     * @param displayText display text of image.

     * @param imageUri the uri of image.

     */
    public void insertImage(String displayText, String imageUri) {
        int start = editText.getSelectionStart();
        editText.getText().insert(start, "\n\n![" + displayText + "](" + imageUri + ")\n\n");
    }
    
    
        /**

     * Insert markdown link markup.

     */
     
    public void insertTable() {
        AlertDialog.Builder linkDialog = new AlertDialog.Builder(context);
        linkDialog.setTitle(R.string.dialog_title_insert_table);
        LayoutInflater inflater = ((AppCompatActivity) context).getLayoutInflater();
        final View view = inflater.inflate(R.layout.dialog_insert_table, null);
        final EditText rows = view.findViewById(R.id.table_rows);
        final EditText cols = view.findViewById(R.id.table_cols);
        final int start = editText.getSelectionStart();
        final int end = editText.getSelectionEnd();

        linkDialog.setView(view);
        linkDialog.setNegativeButton(R.string.cancel,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    dialog.cancel();
                }
            });

        linkDialog.setPositiveButton(R.string.dialog_btn_insert,
            new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                
                    int rowsNum = Integer.valueOf(rows.getText().toString());
                    int colsNum = Integer.valueOf(cols.getText().toString());
                    String tabString=""; 
                    if (rowsNum > 0 && colsNum > 0) {
                        tabString = new MarkdownTableBuilder(rowsNum,colsNum).toString();
                    }
                    String content =tabString;
                    if (start == end) {
                        editText.getText().insert(start, content);
                    } else {
                        editText.getText().replace(start, end, content);
                    }
                }
            });
        linkDialog.show();
    }
    
    

    /**

     * Undo

     */
    public void undo() {
        if (undoRedoHelper != null) {
            undoRedoHelper.undo();
        }
    }

    /**

     * Redo

     */
    public void redo() {
        if (undoRedoHelper != null) {
            undoRedoHelper.redo();
        }
    }

    public void setDefaultText(String str) {
        if (undoRedoHelper != null) {
            undoRedoHelper.setDefaultText(str);
        }
    }
    
    public void clearHistory() {
        if (undoRedoHelper != null) {
            undoRedoHelper.clearHistory();
        }
    }

    /**

     * Toggle keyboard according flag. If flag equals 0, hide or close keyboard. Otherwise, open.

     * @param flag A flag which indicate it should open keyboard or not.

     */
    
}
