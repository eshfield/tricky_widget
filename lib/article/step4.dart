import 'package:flutter/material.dart';

const dashesMinSize = 10.0;
const dashWidth = 5.0;
const dashHeight = 1.0;
const dashColor = Colors.black;

class TrickyWidget extends StatefulWidget {
  final String text;
  final bool isChecked;

  const TrickyWidget({
    super.key,
    required this.text,
    required this.isChecked,
  });

  @override
  State<TrickyWidget> createState() => _TrickyWidgetState();
}

class _TrickyWidgetState extends State<TrickyWidget> {
  late bool _isChecked;
  var _isCompact = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _text(),
        _dashes(),
        _checkbox(),
      ],
    );
  }

  Widget _text() {
    return Text(
      widget.text,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _dashes() {
    return Expanded(
      child: LayoutBuilder(builder: (_, constraints) {
        final width = constraints.maxWidth;
        if (width <= dashesMinSize) {
          setState(() => _isCompact = true);
        }
        return _dottedLine(width);
      }),
    );
  }

  Widget _dottedLine(double width) {
    final dashesCount = (width / (dashWidth * 2)).floor();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        dashesCount,
        (_) {
          return const SizedBox(
            width: dashWidth,
            height: dashHeight,
            child: ColoredBox(color: dashColor),
          );
        },
      ),
    );
  }

  Widget _checkbox() {
    return Checkbox(
      value: _isChecked,
      onChanged: _setCheckbox,
    );
  }

  void _setCheckbox(bool? value) {
    if (value != null) {
      setState(() => _isChecked = value);
    }
  }
}
