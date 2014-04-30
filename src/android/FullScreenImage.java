//
//  FullScreenImage.java
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

package es.keensoft.fullscreenimage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.annotation.SuppressLint;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;


import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.util.Log;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;



@SuppressLint("DefaultLocale")
public class FullScreenImage extends CordovaPlugin {
    
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		JSONObject json = args.getJSONObject(0);
		String url = getJSONProperty(json, "url");
        
		try {
			doSendIntent(url);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
    
	private String getJSONProperty(JSONObject json, String property) throws JSONException {
		if (json.has(property)) {
			return json.getString(property);
		}
		return null;
	}
    
	private void doSendIntent(String url) throws Exception {
		String filenameArray[] = url.split("\\.");
	    String extension = filenameArray[filenameArray.length-1];
		InputStream inputStream = null;
		OutputStream outputStream = null;
        
        File pPath= Environment.getExternalStorageDirectory();
        
        if(!pPath.exists()) {
            boolean bReturn= pPath.mkdirs();
        }
        try {
            File f= new File(pPath, "output."+extension);
            f.createNewFile();
            inputStream = this.cordova.getActivity().getAssets().open("www/"+url);
            outputStream =new FileOutputStream(f);
            byte buf[]=new byte[1024];
            int len;
            while((len=inputStream.read(buf))>0)
                outputStream.write(buf,0,len);
            outputStream.close();
            inputStream.close();
            
            Uri path = Uri.fromFile(f);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.setDataAndType(path, "image/"+extension);
            this.cordova.getActivity().startActivity(intent);
            
        } catch (IOException e) {
            Log.d("FullScreenImagePlugin", "Could not create file: " + e.toString());
            
        }
        
        
    }
	
}