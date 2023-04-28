import 'package:flutter/material.dart';
import 'package:fudeo_hackaton/theme/fonts.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    required this.backgroundColor,
    required this.buttonColor,
    required this.textColor,
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width * 0.11;
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            initialPosition = !initialPosition;
            var index = 0;
            if (!initialPosition) {
              index = 1;
            }
            widget.onToggleCallback(index);
            setState(() {});
          },
          child: Container(
            height: height,
            decoration: ShapeDecoration(
              color: widget.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.values.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    widget.values[index],
                    style: AppFonts.jobListToggle,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.decelerate,
          alignment:
              initialPosition ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: width * 0.45,
            height: height,
            decoration: ShapeDecoration(
              color: widget.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.1),
              ),
            ),
            child: Text(
              initialPosition ? widget.values[0] : widget.values[1],
              style: AppFonts.jobListToggleActive,
            ),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
