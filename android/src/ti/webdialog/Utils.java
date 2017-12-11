package ti.webdialog;

import java.lang.reflect.Field;
import java.util.List;

import org.appcelerator.kroll.KrollDict;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.util.TiRHelper;
import org.appcelerator.titanium.util.TiConvert;
import org.appcelerator.titanium.util.TiRHelper.ResourceNotFoundException;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ResolveInfo;
import android.graphics.Bitmap;
import android.net.Uri;
import android.util.DisplayMetrics;

public class Utils {
	public static int getR(String path) {
		// TiRHelper maintains a cache system & uses 0 for not-found resources
		try {
			return TiRHelper.getResource(path);
			
		} catch (ResourceNotFoundException e) {
			return 0;
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
	
	// takes MAX_HEIGHT & MAX_WIDTH in terms of dp
	public static Bitmap rescaleBitmap(Context context, Bitmap bm, final int MAX_HEIGHT, final int MAX_WIDTH) {
		DisplayMetrics displayMetrics = context.getResources().getDisplayMetrics();
		float density = displayMetrics.density;
  
		final int REQ_HEIGHT = (int) density * MAX_HEIGHT;
		final int REQ_WIDTH = (int) density * MAX_WIDTH;
		
		final int bitmapW = bm.getWidth();
		final int bitmapH = bm.getHeight();
		
		if (bitmapH <= REQ_HEIGHT && bitmapW <= REQ_WIDTH) {
			return bm;
		}
		
		int finalH = 0, finalW = 0;
		float ratioWH = (float) bitmapW / bitmapH;
		
		if (bitmapH > REQ_HEIGHT) {
			finalH = REQ_HEIGHT;
			finalW = (int) (finalH * ratioWH);
			
			// check if width is in 48dp bound
			if (finalW > REQ_WIDTH) {
				finalW = REQ_WIDTH;
			}
			
		} else if (bitmapW > REQ_WIDTH) {
			finalW = REQ_WIDTH;
			finalH = (int) (finalW / ratioWH);
			
			// check if height is in 24dp bound
			if (finalH > REQ_HEIGHT) {
				finalH = REQ_HEIGHT;
			}
		}
		
		if (finalH != 0 && finalW != 0) {
			final Bitmap resultBitmap = Bitmap.createScaledBitmap(bm, finalW, finalH, false);
			
			if (bm != null && !bm.isRecycled()) {
				bm.recycle();
			}
			
			return resultBitmap;
			
		} else {
			return bm;
		}
	}
}



