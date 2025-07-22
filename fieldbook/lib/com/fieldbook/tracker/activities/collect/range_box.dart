import 'package:flutter/material.dart';

class RangeBox extends StatelessWidget {
  const RangeBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.chevron_left, size: size, color: Colors.black),
          Column(
            children: [
              Text('row: 1', style: TextStyle(fontSize: 18)),
              Text('plot: 15', style: TextStyle(fontSize: 18)),
            ],
          ),
          Icon(Icons.chevron_right, size: size, color: Colors.black),
        ],
      ),
    );
  }
}
