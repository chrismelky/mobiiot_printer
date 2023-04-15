package tz.co.chrismelky.mobiiot_printer;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import java.util.Objects;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * MobiiotPrinterPlugin
 */
public class MobiIotPrinterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private MobiIotPrinterMethod mobiIotPrinterMethod;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mobiiot_printer");
        mobiIotPrinterMethod = new MobiIotPrinterMethod(flutterPluginBinding.getApplicationContext());
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "BIND_PRINTER_SERVICE":
                mobiIotPrinterMethod.bindPrinterService();
                result.success(true);

                break;
            case "UNBIND_PRINTER_SERVICE":
                mobiIotPrinterMethod.unbindPrinterService();
                result.success(true);
                break;

            case "PRINT_TEXT":
                String text = call.argument("text");
                Integer size = call.argument("size") != null ? call.argument("size") : 0;
                Integer direction = call.argument("direction") != null ? call.argument("direction") : 0;
                Integer font = call.argument("font") != null ? call.argument("font") : 5;
                Integer align1 = call.argument("align") != null ? call.argument("align") : 0;
                Boolean bold = call.argument("bold") != null ? call.argument("bold") : false;
                Boolean underline = call.argument("underline") != null ? call.argument("underline") : false;
                mobiIotPrinterMethod.printText(text, size, direction, font, align1, bold, underline);
                result.success(true);
                break;

            case "LINE_WRAP":
                Integer lines = call.argument("lines");
                mobiIotPrinterMethod.lineWrap(lines);
                result.success(true);
                break;

            case "PRINT_IMAGE":
                byte[] bytes = call.argument("bitmap");
                Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);
                mobiIotPrinterMethod.printImage(bitmap);
                result.success(true);
                break;
            case "SET_SYNC":
                Boolean clearEnter = call.argument("sync");
                mobiIotPrinterMethod.sync(clearEnter);
                result.success(true);
                break;
            case "SET_DARKNESS":
                Integer darkness = call.argument("darkness");
                mobiIotPrinterMethod.darkness(darkness);
                result.success(true);
                break;
            case "SET_ALIGNMENT":
                Integer align = call.argument("align");
                mobiIotPrinterMethod.setAlignment(align);
                result.success(true);
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
