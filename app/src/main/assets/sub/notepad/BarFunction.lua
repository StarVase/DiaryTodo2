return {
  {
    intent="head1",
    icon=R.drawable.ic_format_header_1,
    func=function()
      editorHelper.heading()
    end,
  },
  {
    intent="head2",
    icon=R.drawable.ic_format_header_2,
    func=function()
      for i = 1, 2 do
        editorHelper.heading()
      end
    end,
  },
  {
    intent="bold",
    icon=R.drawable.ic_format_bold,
    func=function()
      editorHelper.bold()
    end,
  },
  {
    intent="italic",
    icon=R.drawable.ic_format_italic,
    func=function()
      editorHelper.italic()
    end,
  },
  {
    intent="deleteLine",
    icon=R.drawable.ic_format_strikethrough,
    func=function()
      editorHelper.deleteline()
    end,
  },
  {
    intent="underline",
    icon=R.drawable.ic_format_underline,
    func=function()
      editorHelper.underline()
    end,
  },
  {
    intent="head3",
    icon=R.drawable.ic_format_header_3,
    func=function()
      for i = 1, 3 do
        editorHelper.heading()
      end
    end,
  },
  {
    intent="link",
    icon=R.drawable.ic_link,
    func=function()
      editorHelper.insertLink()
    end,
  },
  {
    intent="picture",
    icon=R.drawable.ic_image_outline,
    func=function()
      editorHelper.insertImg()
    end,
  },
  {
    intent="orderedList",
    icon=R.drawable.ic_format_list_numbered,
    func=function()
      editorHelper.orderedList()
    end,
  },
  {
    intent="unorderedList",
    icon=R.drawable.ic_format_list_bulleted,
    func=function()
      editorHelper.unorderedList()
    end,
  },
  {
    intent="todoList",
    icon=R.drawable.ic_list_status,
    func=function()
      editorHelper.todoList()
    end,
  },
  {
    intent="quote",
    icon=R.drawable.ic_format_quote_open,
    func=function()
      editorHelper.quote()
    end,
  },
  {
    intent="table",
    icon=R.drawable.ic_table,
    func=function()
      editorHelper.insertTable()
    end,
  },
  {
    intent="divider",
    icon=R.drawable.ic_minus,
    func=function()
      editorHelper.divider()
    end,
  },
  {
    intent="code",
    icon=R.drawable.ic_code_braces,
    func=function()
      editorHelper.insertCode()
    end,
  },
  --[[{
    intent="code",
    icon=R.drawable.ic_code_tags,
    func=function()

    end,
  },]]
  {
    intent="asciimath",
    icon=R.drawable.ic_square_root,
    func=function()
      editorHelper.asciimath()
    end,
  },
  {
    intent="head4",
    icon=R.drawable.ic_format_header_4,
    func=function()
      for i = 1, 4 do
        editorHelper.heading()
      end
    end,
  },
  {
    intent="head5",
    icon=R.drawable.ic_format_header_5,
    func=function()
      for i = 1, 5 do
        editorHelper.heading()
      end
    end,
  },
  {
    intent="head6",
    icon=R.drawable.ic_format_header_6,
    func=function()
      for i = 1, 6 do
        editorHelper.heading()
      end
    end,
  },
}