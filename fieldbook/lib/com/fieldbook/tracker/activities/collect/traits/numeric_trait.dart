import 'package:flutter/material.dart';

class NumericTrait extends StatelessWidget {
  final String value;
  final ValueChanged<String> onValueChanged;

  const NumericTrait(
      {Key? key, required this.value, required this.onValueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keys = [
      [';', '1', '2', '3'],
      ['+', '4', '5', '6'],
      ['-', '7', '8', '9'],
      ['*', '.', '0', '⌫'],
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value,
              style: const TextStyle(fontSize: 28, color: Colors.red)),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemCount: 16,
          itemBuilder: (context, index) {
            final row = index ~/ 4;
            final col = index % 4;
            final label = keys[row][col];
            return ElevatedButton(
              onPressed: () {
                if (label == '⌫') {
                  if (value.isNotEmpty) {
                    onValueChanged(value.substring(0, value.length - 1));
                  }
                } else {
                  onValueChanged(value + label);
                }
              },
              child: Text(label),
            );
          },
        ),
      ],
    );
  }
}
