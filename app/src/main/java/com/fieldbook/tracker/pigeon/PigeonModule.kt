package com.fieldbook.tracker.pigeon

import android.content.Context
import android.content.SharedPreferences
import androidx.preference.PreferenceManager
import dagger.Binds
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Named
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
abstract class PigeonModule {
    @Binds
    abstract fun bindSharedPreferencesApi(
        impl: SharedPreferencesApiImpl
    ): SharedPreferencesApiHost.SharedPreferencesApi

    @Binds
    abstract fun bindPersonNameManagerApi(
        impl: PersonNameManagerApiImpl
    ): PersonNameManagerApiHost.PersonNameManagerApi

    companion object {
        @Provides
        @Singleton
        @Named("pigeon")
        fun providePigeonSharedPreferences(
            @ApplicationContext app: Context
        ): SharedPreferences {
            return PreferenceManager.getDefaultSharedPreferences(app)
        }
    }
}
