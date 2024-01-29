import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final ValueNotifier<int> groupValue;
  final void Function(dynamic) onChanged;
  final String label;
  const CustomRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.label,
      required this.onChanged})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue.value);

    return InkWell(
      onTap: () {
        widget.onChanged(widget.value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                color: selected
                    ? const Color(0xfff1c452)
                    : const Color(0xff909094)),
          ),
          Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Icon(
              Icons.circle,
              size: 12,
              color: selected ? const Color(0xfff1c452) : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
