package com.fieldbook.tracker.activities;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.fieldbook.tracker.application.FieldBook;
import com.fieldbook.tracker.application.FieldBook.AppEntryPoint;
import com.fieldbook.tracker.pigeon.NavigationApiImpl;

import dagger.hilt.android.EntryPointAccessors;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class FlutterScannerActivity extends FlutterActivity {
    private NavigationApiImpl navigationApiImpl;

    @Nullable
    @Override
    public FlutterEngine provideFlutterEngine(@NonNull Context context) {
        FieldBook app = (FieldBook) getApplication();
        return app.getFlutterEngine();
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d("FlutterScannerActivity", "onCreate called");
        super.onCreate(savedInstanceState);
        AppEntryPoint entryPoint = EntryPointAccessors.fromApplication(getApplicationContext(), AppEntryPoint.class);
        navigationApiImpl = (NavigationApiImpl) entryPoint.navigationApiImpl();
        navigationApiImpl.attachActivity(this);
    }

    @Override
    protected void onDestroy() {
        if (navigationApiImpl != null) {
            navigationApiImpl.detachActivity(this);
        }
        super.onDestroy();
    }

    public void finishWithResult(String result) {
        Log.d("FlutterScannerActivity", "Finishing with result: " + result);
        Intent data = new Intent();
        data.putExtra(ScannerActivity.EXTRA_BARCODE, result);
        data.putExtra(FieldBook.EXTRA_IS_FLUTTER_CODE, true);
        setResult(Activity.RESULT_OK, data);
        finish();
    }
}
