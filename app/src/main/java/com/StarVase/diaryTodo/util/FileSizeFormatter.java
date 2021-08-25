package com.StarVase.diaryTodo.util;

import java.text.DecimalFormat;

public class FileSizeFormatter {
    
    static long Kb = 1 * 1024;

    static long Mb = Kb * 1024;

    static long Gb = Mb * 1024;

    static long Tb = Gb * 1024;

    static long Pb = Tb * 1024;

    static long Eb = Pb * 1024;
    
    public static String format(long size){
        if (size < Kb) return floatForm( size ) + " byte";

        if (size >= Kb && size < Mb) return floatForm((double)size / Kb) + " Kb";

        if (size >= Mb && size < Gb) return floatForm((double)size / Mb) + " Mb";

        if (size >= Gb && size < Tb) return floatForm((double)size / Gb) + " Gb";

        if (size >= Tb && size < Pb) return floatForm((double)size / Tb) + " Tb";

        if (size >= Pb && size < Eb) return floatForm((double)size / Pb) + " Pb";

        if (size >= Eb) return floatForm((double)size / Eb) + " Eb";

        return "null";
    };
    
    public static String format(int size){
        return format(Long.valueOf(size));
    };
    
    private static String floatForm (double d)

    {
        return new DecimalFormat("#.##").format(d);

    }

    
}
