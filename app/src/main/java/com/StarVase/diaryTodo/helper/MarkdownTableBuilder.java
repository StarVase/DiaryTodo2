package com.StarVase.diaryTodo.helper;

public class MarkdownTableBuilder {
    //行
    int rows;
    //列
    int cols;
    
    MarkdownTableBuilder(int r, int c) {
        rows = r;
        cols = c;
    }
    
    public String toString() { 
        String head=tableHead(cols);
        String style= tableStyle(cols);
        String body=tableBody(cols, rows);
        return head+style+body;
    }
    /**   
     * 生成表头
     * @param cols 表格的列数
     * @return 表头的字符串
     */  
    private static String tableHead(int cols){
        StringBuilder buf=new StringBuilder();

        for(int j=1;j<=cols;j++) {
            buf.append("|Title"+j);
        }
        buf.append("|  \n");
        return buf.toString();
    }
    
    /**
     * 生成默认格式的markdown表格对齐样式。
     * @param cols 表格的列数
     * @return markdown表格对齐样式语句字符串。
     */
    private static String tableStyle(int cols) {
        StringBuilder buf=new StringBuilder();
        //打印表格样式使用默认
        for(int j=1;j<=cols;j++) {
            buf.append("|---");
        }

        buf.append("|  \n");
        return buf.toString();
    }
    
    /**
     * 生成表格体markdown语句。
     * @param cols 表格的列数
     * @param rows 表格的行数
     * @return 带编号的表格体markdown语句，表格体第一行编号1,第二行编号2.
     */
    private static String tableBody(int cols, int rows) {
        StringBuilder buf=new StringBuilder();
        for(int i=0;i<rows;i++) {
            for(int j=1;j<=cols+1;j++) {
                buf.append("| ");
                if(j==1) {                  
                    buf.append(" ");
                }
            }
            buf.append("  \n");
        }
        return buf.toString();
    }
}
