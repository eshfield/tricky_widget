import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _isChecked = widget.isChecked;
    super.initState();
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
    return Text(widget.text);
  }

  Widget _dashes() {
    return const Text('--DASH--LINE--PLACEHOLDER--');
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
