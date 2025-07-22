import 'package:fieldbook/com/fieldbook/tracker/activities/collect/traits/numeric_trait.dart';
import 'package:flutter/material.dart';

class CollectInput extends StatefulWidget {
  const CollectInput({Key? key}) : super(key: key);

  @override
  State<CollectInput> createState() => _CollectInputState();
}

class _CollectInputState extends State<CollectInput> {
  String value = "";

  void updateValue(String newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NumericTrait(
        value: value,
        onValueChanged: updateValue,
      ),
    );
  }
}
