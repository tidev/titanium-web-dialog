package ti.webdialog;

import java.lang.reflect.Field;
import java.util.List;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.titanium.util.TiRHelper;
import org.appcelerator.titanium.util.TiConvert;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.net.Uri;

public class Utils {
	public static int getR(String path) {
		try {
			return TiRHelper.getResource(path);
			
		} catch (Exception exc) {
			return -1;
		}
	}
	
	public static int[] getStyleableIntArray(String packageName, String name) {
        try {
            Field[] fields2 = Class.forName(packageName + ".R$styleable" ).getFields();

            for (Field f : fields2) {
                if ( f.getName().equals( name ) ) {
                    int[] ret = (int[])f.get( null );
                    return ret;
                }
            }
        }  catch ( Throwable t ) {}

        return null;
    }
	
	// return the list of all available & enabled browsers in device
	public static List<ResolveInfo> allBrowsers(Context context) {
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("http://www.testingurl.com"));
		return context.getPackageManager().queryIntentActivities(intent, 0);
	}
	
	public static String getString(KrollDict options, String key) {
		String value = "" + (options.containsKeyAndNotNull(key) ? options.get(key) : "");
		return value.trim();
	}
	
	public static boolean getBool(KrollDict options, String key) {
		return (Boolean) (options.containsKeyAndNotNull(key) ? options.get(key) : false);
	}
	
	public static int getColor(KrollDict options, String key) {
		if (options.containsKeyAndNotNull(key)) {
			return TiConvert.toColor( (String) options.get(key));
					
		} else {
			return getR("color.colorPrimary");
		}
	}
}
