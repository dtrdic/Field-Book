package com.fieldbook.tracker.application;

import androidx.multidex.MultiDexApplication;

import com.fieldbook.tracker.BuildConfig;

import dagger.hilt.android.HiltAndroidApp;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;

@HiltAndroidApp
public class FieldBook extends MultiDexApplication {
    public static final String FLUTTER_ENGINE_ID = "fieldbook_flutter_engine";
    private FlutterEngine flutterEngine;

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
        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine);
    }

    public FlutterEngine getFlutterEngine() {
        return flutterEngine;
    }
}
