package com.fieldbook.tracker.pigeon

import android.content.SharedPreferences
import javax.inject.Inject
import javax.inject.Named
import javax.inject.Singleton

@Singleton
class SharedPreferencesApiImpl @Inject constructor(
    @Named("pigeon") private val preferences: SharedPreferences
) : SharedPreferencesApiHost.SharedPreferencesApi {
    override fun getString(key: String): String? = preferences.getString(key, null)

    override fun setString(key: String, value: String): Boolean =
        preferences.edit().putString(key, value).commit()

    override fun remove(key: String): Boolean =
        preferences.edit().remove(key).commit()

    override fun getAllKeys(): List<String> = preferences.all.keys.toList()
}
