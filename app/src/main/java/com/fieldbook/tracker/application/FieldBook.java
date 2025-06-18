package com.fieldbook.tracker.application;

import androidx.multidex.MultiDexApplication;

import com.fieldbook.tracker.BuildConfig;

import dagger.hilt.android.HiltAndroidApp;
import dagger.hilt.android.EntryPointAccessors;
import dagger.hilt.components.SingletonComponent;
import dagger.hilt.EntryPoint;
import dagger.hilt.InstallIn;
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

        // Register Pigeon host APIs for Flutter using Hilt-injected Kotlin implementations
        AppEntryPoint entryPoint = EntryPointAccessors.fromApplication(this, AppEntryPoint.class);
        com.fieldbook.tracker.pigeon.SharedPreferencesApiHost.SharedPreferencesApi.setUp(
            flutterEngine.getDartExecutor().getBinaryMessenger(),
            entryPoint.sharedPreferencesApiImpl()
        );
        com.fieldbook.tracker.pigeon.PersonNameManagerApiHost.PersonNameManagerApi.setUp(
            flutterEngine.getDartExecutor().getBinaryMessenger(),
            entryPoint.personNameManagerApiImpl()
        );
    }

    public void navigateTo(String route) {
        if (navigationChannel != null) {
            navigationChannel.invokeMethod("navigateTo", route);
        }
    }

    public FlutterEngine getFlutterEngine() {
        return flutterEngine;
    }

    @EntryPoint
    @InstallIn(SingletonComponent.class)
    public interface AppEntryPoint {
        com.fieldbook.tracker.pigeon.SharedPreferencesApiHost.SharedPreferencesApi sharedPreferencesApiImpl();
        com.fieldbook.tracker.pigeon.PersonNameManagerApiHost.PersonNameManagerApi personNameManagerApiImpl();
    }
}
