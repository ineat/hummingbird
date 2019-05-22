import 'dart:math' as Math;

import 'package:flutter_web/material.dart';

class Session extends StatelessWidget {
  final Widget child;
  final bool primary;

  const Session({Key key, this.child, this.primary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const diagonalHeight = 120.0;
    final contentChild = Container(
      padding: const EdgeInsets.symmetric(vertical: diagonalHeight),
      width: double.infinity,
      child: this.child,
    );

    if (!primary) {
      return contentChild;
    }
    return CustomPaint(
      painter: _DiagonalPainter(color: Theme.of(context).primaryColor, height: diagonalHeight),
      child: contentChild,
    );

  }
}

class _DiagonalPainter extends CustomPainter {
  final double height;
  final Color color;

  const _DiagonalPainter({this.height, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = this.color;
    final Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height - this.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, this.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GridSession extends StatelessWidget {

  final Widget firstChild;
  final Widget secondChild;
  final bool isVerticalReversed;

  const GridSession({Key key, this.firstChild, this.secondChild, this.isVerticalReversed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final parentWidth = constraints.biggest.width;
        final width = Math.min(1416, parentWidth);
        final isVertical = width < 1024;
        final horizontalPadding = isVertical ? 32.0 : 80.0;
        return Flex(
          mainAxisAlignment: MainAxisAlignment.center,
          direction: isVertical ? Axis.vertical : Axis.horizontal,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: horizontalPadding, right: isVertical ? horizontalPadding : 0.0),
              alignment: Alignment.center,
              width: isVertical ? width : width / 2,
              child: (isVertical && isVerticalReversed ) ? this.secondChild : this.firstChild,
            ),
            SizedBox(height: isVertical ? 50 : 0, width: isVertical ? width : 0.0,),
            Container(
              padding: EdgeInsets.only(right: horizontalPadding, left: isVertical ? horizontalPadding : 0.0),
              alignment: Alignment.center,
              width: isVertical ? width : width / 2,
              child: (isVertical && isVerticalReversed ) ? this.firstChild : this.secondChild,
            )
          ],
        );
      },
    );
  }
}
