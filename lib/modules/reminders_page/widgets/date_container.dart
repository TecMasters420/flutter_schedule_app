import 'package:flutter/material.dart';

class CustomDateContainer extends StatefulWidget {
  final List<int> data;
  final List<int>? selectableValues;
  final void Function(int itemPressed, int index) onPressElement;
  final Widget Function(int currentElement, bool isSelected, int index)
      widgetBuild;
  final int initialElementIndex;
  const CustomDateContainer({
    super.key,
    required this.data,
    required this.initialElementIndex,
    required this.onPressElement,
    required this.widgetBuild,
    this.selectableValues,
  });

  @override
  State<CustomDateContainer> createState() => _CustomDateContainerState();
}

class _CustomDateContainerState extends State<CustomDateContainer> {
  late int _currentSelected;

  @override
  void initState() {
    super.initState();
    _currentSelected = widget.initialElementIndex;
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? values = widget.selectableValues;
    if (_currentSelected >= widget.data.length ||
        (values != null &&
            (!values.contains(widget.data[_currentSelected]) ||
                values.contains(widget.data[widget.initialElementIndex])))) {
      _currentSelected = widget.initialElementIndex;
    }
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
            widget.data.length,
            (index) {
              final bool canPress = widget.selectableValues == null ||
                  widget.selectableValues!.contains(widget.data[index]);
              final bool isSelected = _currentSelected == index;

              if (isSelected) {}
              return GestureDetector(
                onTap: () {
                  if (canPress && !isSelected) {
                    setState(() {
                      _currentSelected = index;
                      widget.onPressElement(widget.data[index], index);
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index < widget.data.length ? 20 : 0,
                  ),
                  child:
                      widget.widgetBuild(widget.data[index], isSelected, index),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
