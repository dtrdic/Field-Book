package com.fieldbook.shared

import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
//import field_book.shared.generated.resources.Res
//import field_book.shared.generated.resources.ic_nav_drawer_collect_data
//import field_book.shared.generated.resources.ic_nav_drawer_fields
//import field_book.shared.generated.resources.ic_nav_drawer_settings
//import field_book.shared.generated.resources.ic_nav_drawer_statistics
//import field_book.shared.generated.resources.ic_nav_drawer_traits
//import field_book.shared.generated.resources.ic_tb_info
//import field_book.shared.generated.resources.trait_date_save
import org.jetbrains.compose.resources.painterResource


@Composable
fun ConfigScreen() {
    val configItems = listOf(
        "Fields",
        "Traits",
        "Collect",
        "Export",
        "Advanced",
        "Statistics",
        "About"
    )
    // FIXME
    /*val configIcons = listOf(
        Res.drawable.ic_nav_drawer_fields,
        Res.drawable.ic_nav_drawer_traits,
        Res.drawable.ic_nav_drawer_collect_data,
        Res.drawable.ic_nav_drawer_settings,
        Res.drawable.trait_date_save,
        Res.drawable.ic_nav_drawer_statistics,
        Res.drawable.ic_tb_info
    )*/
    Surface(modifier = Modifier.fillMaxSize()) {
        LazyColumn(modifier = Modifier.fillMaxSize()) {
            itemsIndexed(configItems ) { index, item ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    /*Icon(
                        painter = painterResource(configIcons[index]),
                        contentDescription = item,
                        modifier = Modifier.padding(end = 16.dp).size(24.dp)
                    )*/
                    Text(
                        text = item,
                        style = MaterialTheme.typography.bodyLarge
                    )
                }
                Divider()
            }
        }
    }
}
