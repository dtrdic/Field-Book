import 'package:fieldbook/app_widgets.dart';
import 'package:flutter/material.dart';
import '../database/data_helper.dart';
import '../database/models/field_object.dart';

class FieldEditorActivity extends StatefulWidget {
  const FieldEditorActivity({Key? key}) : super(key: key);

  @override
  State<FieldEditorActivity> createState() => _FieldEditorActivityState();
}

class _FieldEditorActivityState extends State<FieldEditorActivity> {
  late Future<List<FieldObject>> _fieldsFuture;

  @override
  void initState() {
    super.initState();
    _fieldsFuture = _loadFields();
  }

  Future<List<FieldObject>> _loadFields() async {
    final dataHelper = await DataHelper.open();
    return await dataHelper.getAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Fields'),
      body: FutureBuilder<List<FieldObject>>(
        future: _fieldsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \\${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No fields found.'));
          }
          final fields = snapshot.data!;
          return ListView.separated(
            itemCount: fields.length,
            itemBuilder: (context, index) {
              final field = fields[index];
              return ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.grid_on,
                    color: Colors.grey.shade600,
                    size: 28,
                  ),
                ),
                title: Text(
                  field.expAlias.isNotEmpty ? field.expAlias : field.expName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text('Count: ${field.count ?? "0"}'),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                onTap: () {
                  // TODO: Navigate to field details or perform action
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}
