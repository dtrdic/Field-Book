package com.fieldbook.shared.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

private val MainLightColors = lightColorScheme(
    primary = Color(0xFF8BC34A),
    onPrimary = Color(0xFF000000),
    primaryContainer = Color(0xFF689F38),
    onPrimaryContainer = Color(0xFF000000),
    secondary = Color(0xFF795548),
    onSecondary = Color(0xFF000000),
    background = Color(0xFFFFFFFF),
    onBackground = Color(0xFF000000),
    surface = Color(0xFFFFFFFF),
    onSurface = Color(0xFF000000),
    error = Color(0xFFD50000),
    onError = Color(0xFFFFFFFF)
)

@Composable
fun MainTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = MainLightColors,
        typography = MaterialTheme.typography,
        content = content
    )
}
