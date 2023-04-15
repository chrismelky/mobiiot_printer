package tz.co.chrismelky.mobiiot_printer;

import android.app.Service;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;

import com.sagereal.printer.PrinterInterface;

public class MobiIotPrinterMethod {

    private static final String TAG = "PrinterServiceUtil";
    public static PrinterInterface atService;
    private final Context context;

    public MobiIotPrinterMethod(Context context) {
        this.context = context;
    }

    private final ServiceConnection serviceConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            Log.e(TAG,  "aidl connect success");
            atService = PrinterInterface.Stub.asInterface(service);
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            Log.e(TAG,  "aidl connect fail");
            atService = null;
        }
    };

    public void   bindPrinterService() {
        Intent aidlIntent = new Intent();
        aidlIntent.setAction("sagereal.intent.action.START_PRINTER_SERVICE_AIDL");
        aidlIntent.setPackage("com.sagereal.printer");
        context.bindService(aidlIntent, serviceConnection, Service.BIND_AUTO_CREATE);
    }

    public void unbindPrinterService() {
        context.unbindService(serviceConnection);
    }

    public Boolean printText(String text, Integer size, Integer direction, Integer font, Integer align, Boolean bold,Boolean underline) {
        try {
            return atService.printText_FullParam_r(text,size,direction,font,align,bold,underline);
        } catch (Exception e) {
            return false;
        }
    }

    public void lineWrap(Integer lines) {
        try {
            for (int i = 0; i < lines; i++) {
                atService.printText_r("");
            }
        } catch (Exception e) {
        }
    }

    public Boolean printImage(Bitmap bitmap) {
        try {
           return atService.printBitmap_btm_speed_r(bitmap, 0);
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public Boolean sync(Boolean sync) {
        try {
           return atService.printSetSyncMode(sync);
        } catch (RemoteException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
    }

    public void darkness(Integer dark) {
        try {
            atService.printSetDarkness(dark);
        } catch (RemoteException e) {
        } catch (NullPointerException e) {
        }
    }

    public Boolean setAlignment(Integer align) {
        try {
            return atService.printText_FullParam_r("", 0, 3, 0, align, false, false);
        } catch (Exception e) {
            return false;
        }
    }


}
