package com.fieldbook.tracker.application;

import androidx.multidex.MultiDexApplication;

import com.fieldbook.tracker.BuildConfig;

import dagger.hilt.android.HiltAndroidApp;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;

@HiltAndroidApp
public class FieldBook extends MultiDexApplication {
    public static final String FLUTTER_ENGINE_ID = "fieldbook_flutter_engine";
    private FlutterEngine flutterEngine;
    private static final String NAVIGATION_CHANNEL = "com.fieldbook/navigation";
    private MethodChannel navigationChannel;

    public FieldBook() {
        if (BuildConfig.DEBUG) {
            //StrictMode.enableDefaults();
            //un-comment to enable strict warnings in logcat
        }
    }

    @Override
    public void onCreate() {
        super.onCreate();
        // Initialize and cache the FlutterEngine
        flutterEngine = new FlutterEngine(this);
        flutterEngine.getNavigationChannel().setInitialRoute("/");
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
        );
        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine);
        navigationChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), NAVIGATION_CHANNEL);
    }

    public void navigateTo(String route) {
        if (navigationChannel != null) {
            navigationChannel.invokeMethod("navigateTo", route);
        }
    }

    public FlutterEngine getFlutterEngine() {
        return flutterEngine;
    }
}
