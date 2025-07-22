import 'package:flutter/material.dart';

import '../../database/data_helper.dart';

class TraitBox extends StatefulWidget {
  const TraitBox({Key? key}) : super(key: key);

  @override
  State<TraitBox> createState() => _TraitBoxState();
}

class _TraitBoxState extends State<TraitBox> {
  List<String> traits = [];
  int currentIndex = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadTraits();
  }

  Future<void> _loadTraits() async {
    final helper = await DataHelper.open();
    final traitList = await helper.getVisibleTrait();
    setState(() {
      traits = traitList;
      loading = false;
    });
  }

  void _moveLeft() {
    setState(() {
      currentIndex = (currentIndex - 1 + traits.length) % traits.length;
    });
  }

  void _moveRight() {
    setState(() {
      currentIndex = (currentIndex + 1) % traits.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    const size = 52.0;
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (traits.isEmpty) {
      return const Center(child: Text('No traits available'));
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Icons.chevron_left, size: size, color: Colors.green),
            onPressed: _moveLeft,
          ),
          Column(
            children: [
              Text(traits[currentIndex],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              // Placeholder for trait details, can be expanded later
              const Text('', style: TextStyle(fontSize: 16)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right,
                size: size, color: Colors.green),
            onPressed: _moveRight,
          ),
        ],
      ),
    );
  }
}
