import 'package:flutter/material.dart';

const dashesElementMinSize = 10.0;
const dashWidth = 5.0;

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
  var _isCompact = false;
  late bool _isChecked;
  late TextPainter _textPainter;

  @override
  void initState() {
    _isChecked = widget.isChecked;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TextPainter инициализируется здесь, так как в initState() невозможно
    // использовать InheritedWidget для получения стиля текста по умолчанию
    _textPainter = TextPainter(
      maxLines: 1,
      text: TextSpan(
        text: widget.text,
        style: DefaultTextStyle.of(context).style,
      ),
      textDirection: TextDirection.ltr,
    );
    super.didChangeDependencies();
  }

  void _setCheckbox(bool? value) {
    if (value != null) {
      setState(() {
        _isChecked = value;
      });
    }
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
    if (!_isCompact) return Text(widget.text);
    return Expanded(
      child: LayoutBuilder(
        builder: (_, constraints) {
          if (_isCompact && !_isTextOverflowed(constraints.maxWidth)) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => setState(() {
                _isCompact = false;
              }),
            );
          }
          return Text(
            widget.text,
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
    );
  }

  Widget _dashes() {
    if (_isCompact) return const SizedBox(width: dashesElementMinSize);
    return Expanded(
      child: LayoutBuilder(builder: (_, constraints) {
        final width = constraints.maxWidth;
        if (width <= dashesElementMinSize) {
          if (!_isCompact) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => setState(() {
                _isCompact = true;
              }),
            );
          }
          return const SizedBox(width: dashesElementMinSize);
        }
        return _dottedLine(width);
      }),
    );
  }

  Widget _checkbox() {
    return Checkbox(
      value: _isChecked,
      onChanged: _setCheckbox,
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
            height: 1,
            child: ColoredBox(color: Colors.black),
          );
        },
      ),
    );
  }

  bool _isTextOverflowed(double width) {
    _textPainter.layout(maxWidth: width);
    return _textPainter.didExceedMaxLines;
  }
}
