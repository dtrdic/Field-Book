import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/data_helper.dart';
import 'collect_activity_provider.dart';

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
          StatusBar(traits: traits, currentIndex: currentIndex),
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

class StatusBar extends StatefulWidget {
  final List<String> traits;
  final int currentIndex;
  const StatusBar({Key? key, required this.traits, required this.currentIndex})
      : super(key: key);

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  Map<String, String> traitsValue = {};
  bool loading = true;
  String? lastPlotId;

  @override
  void initState() {
    super.initState();
    _loadTraitsValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final plotId = Provider.of<CollectActivityProvider>(context).plotId;
    if (plotId != lastPlotId) {
      lastPlotId = plotId;
      _loadTraitsValue();
    }
  }

  Future<void> _loadTraitsValue() async {
    final helper = await DataHelper.open();
    final plotId =
        Provider.of<CollectActivityProvider>(context, listen: false).plotId;
    final value = await helper.getUserDetail(plotId);
    setState(() {
      traitsValue = value;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Expanded(
          child: SizedBox(
              height: 32,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2))));
    }
    return Expanded(
      child: SizedBox(
        height: 32,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.traits.length, (index) {
              final trait = widget.traits[index];
              final isSelected = index == widget.currentIndex;
              final hasObservation = traitsValue.containsKey(trait);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (hasObservation ? Colors.green : Colors.brown[400])
                      : null,
                  shape: isSelected ? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: isSelected ? BorderRadius.circular(6) : null,
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                child: !isSelected && hasObservation
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.brown[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              );
            }),
          ),
        ),
      ),
    );
  }
}
