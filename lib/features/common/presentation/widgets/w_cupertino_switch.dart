import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fikrat_online/assets/colors/colors.dart';

class WCupertinoSwitch extends StatefulWidget {
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final double width;
  final bool isSwitched;
  final double padding;

  /// switching duration in milliseconds
  final int switchingDuration;
  final ValueChanged<bool> onChange;

  const WCupertinoSwitch({
    required this.onChange,
    this.isSwitched = false,
    this.width = 44,
    this.padding = 2,
    this.height = 25,
    this.activeColor = mainColor,
    this.inactiveColor = const Color(0xffF9F9FD),
    this.switchingDuration = 150,
    Key? key,
  })  : assert(width - 5 >= height, '(Width - 5) cannot be less than height'),
        super(key: key);

  @override
  State<WCupertinoSwitch> createState() => _WCupertinoSwitchState();
}

class _WCupertinoSwitchState extends State<WCupertinoSwitch> {
  bool isSwitched = false;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
  }

  @override
  Widget build(BuildContext context) => Listener(
        onPointerDown: (value) {
          setState(() {
            isClicked = true;
          });
        },
        onPointerUp: (value) {
          setState(() {
            isClicked = false;
          });
        },
        onPointerCancel: (value) {
          setState(() {
            isClicked = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              isSwitched = !isSwitched;
              widget.onChange(isSwitched);
            });
            widget.onChange(isSwitched);
          },
          onHorizontalDragStart: (details) {
            setState(() {
              if (details.localPosition.dx < widget.height - 5) {
                isSwitched = false;
                widget.onChange(isSwitched);
              } else {
                isSwitched = true;
                widget.onChange(isSwitched);
              }

              isClicked = true;
            });
          },
          onHorizontalDragUpdate: (details) {
            setState(() {
              if (details.localPosition.dx < widget.height - 5) {
                isSwitched = false;
                widget.onChange(isSwitched);
              } else {
                isSwitched = true;
                widget.onChange(isSwitched);
              }

              isClicked = true;
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              isClicked = false;
            });
          },
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: widget.switchingDuration),
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSwitched ? white : quartz,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  color: isSwitched ? widget.activeColor : widget.inactiveColor,
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: widget.switchingDuration),
                right: isClicked && isSwitched
                    ? widget.padding
                    : isClicked && !isSwitched
                        ? widget.width -
                            (widget.height - 4 + 5) -
                            widget.padding
                        : isSwitched
                            ? 2
                            : widget.width -
                                (widget.height - 5) -
                                widget.padding,
                left: isClicked && isSwitched
                    ? widget.width - (widget.height - 4 + 5) - widget.padding
                    : isClicked && !isSwitched
                        ? widget.padding
                        : !isSwitched
                            ? widget.padding
                            : widget.width -
                                (widget.height - 4) -
                                widget.padding,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: widget.switchingDuration),
                  width: widget.height - 5,
                  height: widget.height - 5,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular((widget.height - 5) / 2),
                    color: isSwitched ? white : quartz,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
