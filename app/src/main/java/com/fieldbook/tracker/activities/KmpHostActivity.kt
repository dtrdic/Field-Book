package com.fieldbook.tracker.activities

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.fieldbook.shared.ConfigScreen

class KmpHostActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val screen = intent.getStringExtra(EXTRA_SCREEN)
        val hostScreenType = KmpHostScreenType.fromValue(screen ?: KmpHostScreenType.CONFIG.value)
        setContent {
            when (hostScreenType) {
                KmpHostScreenType.CONFIG -> ConfigScreen(onBack = { finish() })
            }
        }
    }

    companion object {
        const val EXTRA_SCREEN = "kmp_screen"
    }
}
