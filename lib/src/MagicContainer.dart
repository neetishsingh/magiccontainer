import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MagicContainer extends StatefulWidget {
  final child;
  var colors; // = [Colors.amber];
  var doMagic, milliseconds, doGradient;
  MagicContainer(
      {Key? key,
      this.child,
      this.colors = const [Colors.orange, Colors.greenAccent],
      this.doMagic = false,
      this.milliseconds = 1000,
      this.doGradient = false})
      : super(key: key);

  @override
  State<MagicContainer> createState() => _MagicContainerState();
}

class _MagicContainerState extends State<MagicContainer> {
  var _timer;
  int _start = 1000;
  int kitnasec = 5;
  //var oneSec = const Duration(seconds: 1);

  var colourscombo = [Colors.accents, Colors.black];
  var chosencolor = Colors.amber as Color;
  changeColor(inta) {
    setState(() {
      chosencolor = colourscombo[inta % (colourscombo.length)] as Color;
    });
  }

  void startTimer(time) {
    setState(() {
      kitnasec = time;
    });
    var oneSec = Duration(seconds: kitnasec);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            startTimer(time);
          });
        } else {
          changeColor(_start);
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      colourscombo = widget.colors;
    });
    (widget.doMagic ? startTimer(widget.milliseconds) : "");

    return widget.doMagic
        ? Container(
            child: widget.child,
            color: (widget.doMagic ? chosencolor : Colors.black),
          )
        : (widget.doGradient
            ? Container(
                child: widget.child,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [...widget.colors],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      tileMode: TileMode.clamp),
                ),
              )
            : Container(
                child: widget.child,
              ));
  }
}
