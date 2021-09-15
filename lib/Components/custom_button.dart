import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final EdgeInsets padding;
  final double height;
  final Color bgColor;
  final TextStyle labelStyle;
  final double width;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final Function onTap;
  CustomButton(
      {this.label,
      this.padding,
      this.height,
      this.bgColor,
      this.labelStyle,
      this.width,
      this.margin,
      this.borderRadius,
      this.onTap});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin ?? EdgeInsets.all(12),
        padding: widget.padding ?? EdgeInsets.all(8),
        height: widget.height ?? 60,
        width: widget.width ?? double.infinity,
        decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            color: widget.bgColor ?? Theme.of(context).primaryColor),
        child: Center(
            child: Text(
          widget.label,
          style: widget.labelStyle ?? theme.textTheme.subtitle2,
        )),
      ),
    );
  }
}
