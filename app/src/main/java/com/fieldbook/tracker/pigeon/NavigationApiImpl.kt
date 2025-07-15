package com.fieldbook.tracker.pigeon

import android.util.Log
import androidx.compose.ui.platform.LocalGraphicsContext
import com.fieldbook.tracker.activities.FlutterScannerActivity
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NavigationApiImpl @Inject constructor() : NavigationApiHost.NavigationApi {
    private var activity: FlutterScannerActivity? = null

    fun attachActivity(activity: FlutterScannerActivity) {
        Log.d("NavigationApiImpl", "attachActivity: $activity")
        this.activity = activity
    }

    fun detachActivity(activity: FlutterScannerActivity) {
        Log.d("NavigationApiImpl", "detachActivity: $activity")
        if (this.activity == activity) {
            this.activity = null
        }
    }

    override fun onNavigatorPop(result: String?) {
        Log.d("NavigationApiImpl", "onNavigatorPop: $result")
        if (activity != null && result != null) {
            activity?.finishWithResult(result)
        }
    }
}

