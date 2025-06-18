package com.fieldbook.tracker.pigeon

import android.content.SharedPreferences
import com.fieldbook.tracker.utilities.PersonNameManager
import javax.inject.Inject
import javax.inject.Named
import javax.inject.Singleton

@Singleton
class PersonNameManagerApiImpl @Inject constructor(
    @Named("pigeon") private val preferences: SharedPreferences
) : PersonNameManagerApiHost.PersonNameManagerApi {
    private val personNameManager = PersonNameManager(preferences)
    override fun getPersonNames(): List<PersonNameManagerApiHost.PersonName> {
        return personNameManager.getPersonNames().map {
            PersonNameManagerApiHost.PersonName().apply {
                firstName = it.firstName
                lastName = it.lastName
            }
        }
    }

    override fun savePersonName(firstName: String, lastName: String): Boolean {
        return personNameManager.savePersonName(firstName, lastName)
    }

    override fun clearPersonNames() {
        personNameManager.clearPersonNames()
    }
}
