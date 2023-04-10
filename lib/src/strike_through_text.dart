import 'package:flutter/material.dart';
import 'package:swipe_through_text/src/strike_through_painter.dart';

/// A widget that allows users to swipe through text and strikethrough it when a
/// certain threshold is met.
class SwipeThroughText extends StatefulWidget {
  /// The text to display.
  final String text;

  /// The style to use for the text.
  final TextStyle textStyle;

  /// The color to use for the strikethrough line.
  final Color strikethroughColor;

  /// The height to use for the strikethrough line.
  final double strikethroughLineHeight;

  /// The swipe threshold at which the strikethrough line is completed.
  final double swipeThreshold;

  /// The dash array to use for the strikethrough line.
  final List<double> dashArray;

  /// A callback that is called when the swipe is completed.
  final ValueChanged<double>? onSwipeComplete;

  /// A callback that is called when the swipe is cancelled.
  final ValueChanged<double>? onSwipeCancel;

  /// Creates a new [SwipeThroughText] instance.
  ///
  /// The [text], [textStyle], and [key] arguments are required.
  ///
  /// The [strikethroughColor], [strikethroughLineHeight], [swipeThreshold], and
  /// [dashArray] arguments have default values.
  ///
  /// The [swipeThreshold] value must be between 0.5 and 1.0 (inclusive).
  const SwipeThroughText({
    super.key,
    required this.text,
    required this.textStyle,
    this.strikethroughColor = Colors.red,
    this.strikethroughLineHeight = 2.0,
    this.swipeThreshold = 0.90,
    this.onSwipeComplete,
    this.onSwipeCancel,
    this.dashArray = const [],
  }) : assert(swipeThreshold >= 0.5 && swipeThreshold <= 1.0,
            'swipeThreshold must be between 0.5 - 1.0');

  @override
  SwipeThroughTextState createState() => SwipeThroughTextState();
}

/// The state for the [SwipeThroughText] widget.
class SwipeThroughTextState extends State<SwipeThroughText>
    with SingleTickerProviderStateMixin {
  double _strikethroughFraction = 0.0;
  bool _swipeRightToLeft = false;
  bool _swipeCompleted = false;
  double _initialSwipePosition = 0;
  double _textWidth = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller and animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _strikethroughFraction = _animation.value;
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Measures the width of the text.
  ///
  /// The [maxWidth] argument is the maximum width available to the text.
  void _measureTextWidth(double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    )..layout(maxWidth: maxWidth);
    _textWidth = textPainter.width;
  }

  /// Handles the start of a swipe.
  ///
  /// The [localDx] argument is the local X coordinate of the swipe.
  ///
  /// The [maxWidth] argument is the maximum width available to the text.
  void _handleSwipeStart(double localDx, double maxWidth) {
    _initialSwipePosition = localDx;
    _swipeRightToLeft = localDx > maxWidth / 2;
  }

  /// Updates the strikethrough fraction based on the current swipe position.
  ///
  /// The [localDx] argument is the local X coordinate of the swipe.
  void _updateStrikethroughFraction(double localDx) {
    setState(() {
      double swipeDistance = _swipeRightToLeft
          ? _initialSwipePosition - localDx
          : localDx - _initialSwipePosition;
      _strikethroughFraction = (swipeDistance / _textWidth).clamp(0, 1);
    });
  }

  /// Handles the end of a swipe.
  void _handleSwipeEnd() {
    if (_strikethroughFraction >= widget.swipeThreshold) {
      _swipeCompleted = true;
      _strikethroughFraction = 1.0;
      setState(() {
        widget.onSwipeComplete?.call(_strikethroughFraction);
      });
    } else {
      widget.onSwipeCancel?.call(_strikethroughFraction);
      _animationController.reverse(from: _strikethroughFraction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _measureTextWidth(constraints.maxWidth);
        return GestureDetector(
          onHorizontalDragDown: _swipeCompleted
              ? null
              : (details) => _handleSwipeStart(
                  details.localPosition.dx, constraints.maxWidth),
          onHorizontalDragUpdate: _swipeCompleted
              ? null
              : (details) =>
                  _updateStrikethroughFraction(details.localPosition.dx),
          onHorizontalDragEnd:
              _swipeCompleted ? null : (details) => _handleSwipeEnd(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                widget.text,
                style: widget.textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Positioned(
                left: _swipeRightToLeft ? null : 0,
                right: _swipeRightToLeft ? 0 : null,
                child: CustomPaint(
                  size: Size(_textWidth * _strikethroughFraction,
                      widget.strikethroughLineHeight),
                  painter: StrikethroughPainter(
                    color: widget.strikethroughColor,
                    width: widget.strikethroughLineHeight,
                    dashArray: widget.dashArray,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
