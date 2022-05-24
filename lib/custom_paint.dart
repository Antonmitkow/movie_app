import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintWidget extends StatefulWidget {
  const CustomPaintWidget({Key? key}) : super(key: key);

  @override
  State<CustomPaintWidget> createState() => _CustomPaintWidgetState();
}

class _CustomPaintWidgetState extends State<CustomPaintWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          child: RadialPersentWidget(
            persent: 0.7,
            fillColor: Colors.blue,
            lineColor: Colors.greenAccent,
            freeColor: Colors.blueGrey,
            lineWidth: 5,
          ),
        ),
      ),
    );
  }
}

class RadialPersentWidget extends StatelessWidget {
  // final Widget child;

  final double persent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;

  const RadialPersentWidget(
      {Key? key,
      // required this.child,
      required this.persent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor,
      required this.lineWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: MyPainter(
            persent: persent,
            fillColor: fillColor,
            lineColor: lineColor,
            freeColor: freeColor,
            lineWidth: lineWidth,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Center(
              child: Text(
            '${persent * 100}%',
            style: const TextStyle(color: Colors.white),
          )),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final double persent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;
  final double lineWidth;
  MyPainter({
    required this.persent,
    required this.fillColor,
    required this.lineColor,
    required this.freeColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const linesMargin = 3;
    final offset = lineWidth / 2 + linesMargin;
    final arcRect = Offset(offset, offset) &
        Size(size.width - offset * 2, size.height - offset * 2);

    final backgroundPaint = Paint();
    backgroundPaint.color = fillColor;
    backgroundPaint.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);

    final freePaint = Paint();
    freePaint.color = freeColor;
    freePaint.style = PaintingStyle.stroke;
    freePaint.strokeWidth = lineWidth;
    canvas.drawArc(
        arcRect,
        pi * 2 * persent - (pi / 2), //начальная точка
        pi * 2 * (1.0 - persent), //конечная
        false, // использования центра (полноценный график)
        freePaint);

    final feelPaint = Paint();
    feelPaint.color = lineColor;
    feelPaint.style = PaintingStyle.stroke;
    feelPaint.strokeWidth = 5;
    feelPaint.strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, -pi / 2, pi * 2 * persent, false, feelPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  MyPainter copyWith({
    double? persent,
    Color? fillColor,
    Color? lineColor,
    Color? freeColor,
    double? lineWidth,
  }) {
    return MyPainter(
      persent: persent ?? this.persent,
      fillColor: fillColor ?? this.fillColor,
      lineColor: lineColor ?? this.lineColor,
      freeColor: freeColor ?? this.freeColor,
      lineWidth: lineWidth ?? this.lineWidth,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'persent': persent});
    result.addAll({'fillColor': fillColor.value});
    result.addAll({'lineColor': lineColor.value});
    result.addAll({'freeColor': freeColor.value});
    result.addAll({'lineWidth': lineWidth});

    return result;
  }

  factory MyPainter.fromMap(Map<String, dynamic> map) {
    return MyPainter(
      persent: map['persent']?.toDouble() ?? 0.0,
      fillColor: Color(map['fillColor']),
      lineColor: Color(map['lineColor']),
      freeColor: Color(map['freeColor']),
      lineWidth: map['lineWidth']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyPainter.fromJson(String source) =>
      MyPainter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyPainter(persent: $persent, fillColor: $fillColor, lineColor: $lineColor, freeColor: $freeColor, lineWidth: $lineWidth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyPainter &&
        other.persent == persent &&
        other.fillColor == fillColor &&
        other.lineColor == lineColor &&
        other.freeColor == freeColor &&
        other.lineWidth == lineWidth;
  }

  @override
  int get hashCode {
    return persent.hashCode ^
        fillColor.hashCode ^
        lineColor.hashCode ^
        freeColor.hashCode ^
        lineWidth.hashCode;
  }
}
