import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  final List<String> segments;
  final onSelectionChanged;
  final bool editable;
  final int initialSelectionIndex;

  SegmentedControl(
    this.segments, {
    key,
    this.onSelectionChanged,
    this.editable = true,
    this.initialSelectionIndex = 0,
  }) : super(key: key);

  @override
  _SegmentedControlState createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  _SegmentedControlState();
  int selectedIndex;

  void handleSelect(int widgetNum) {
    setState(() => selectedIndex = widgetNum);
    widget.onSelectionChanged(widgetNum);
  }

  Color isEditable() {
    if (widget.editable) {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.grey[500];
    }
  }

  List<Widget> createSegments() {
    if (widget?.segments?.isEmpty == true) {
      return [];
    }
    var lastSegment = widget.segments?.last;
    if (lastSegment == null) return [];
    var childBorders = <Color>[];

    var selectedIndex = this.selectedIndex ?? widget.initialSelectionIndex;

    var segmentWidgets = <Widget>[];
    widget.segments.forEach((segment) {
      var idx = widget.segments.indexOf(segment);

      if (segment == lastSegment) {
        childBorders.add(Colors.transparent);
      } else {
        childBorders.add(isEditable());
      }

      segmentWidgets.add(
        Expanded(
          child: InkWell(
            onTap: widget.editable
                ? () => handleSelect(widget.segments.indexOf(segment))
                : null,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              decoration: BoxDecoration(
                color: selectedIndex == widget.segments.indexOf(segment)
                    ? isEditable()
                    : Colors.white,
                border: Border(
                    right: BorderSide(
                        color: childBorders[
                            idx]) // hide right border on last child
                    ),
              ),
              child: Text(
                segment,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selectedIndex == widget.segments.indexOf(segment)
                      ? Colors.white
                      : isEditable(),
                ),
              ),
            ),
          ),
        ),
      );
    });

    return segmentWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(color: isEditable(), width: 1.3),
        borderRadius: BorderRadius.all(const Radius.circular(3.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: createSegments(),
      ),
    );
  }
}
