import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class TimeStampChatBubble extends LeafRenderObjectWidget {
  const TimeStampChatBubble({
    super.key,
    required this.text,
    required this.sentAt,
    required this.textStyle,
  });
  final String text;
  final String sentAt;
  final TextStyle? textStyle;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = textStyle;
    if (textStyle == null || textStyle!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(textStyle);
    }
    return TimeStampedChatRenderObject(
      text: text,
      sentAt: sentAt,
      textDirection: Directionality.of(context),
      textStyle: effectiveTextStyle!,
      sentAtStyle: effectiveTextStyle.copyWith(color: Colors.grey),
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant TimeStampedChatRenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = textStyle;
    if (textStyle == null || textStyle!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(textStyle);
    }
    renderObject.text = text;
    renderObject.textStyle = effectiveTextStyle!;
    renderObject.sentAt = sentAt;
    renderObject.sentAtStyle = effectiveTextStyle.copyWith(color: Colors.grey);
    renderObject.textDirection = Directionality.of(context);
  }
}

class TimeStampedChatRenderObject extends RenderBox {
  TimeStampedChatRenderObject(
      {required String text,
      required String sentAt,
      required TextStyle textStyle,
      required TextDirection textDirection,
      required TextStyle sentAtStyle}) {
    _text = text;
    _sentAt = sentAt;
    _textStyle = textStyle;
    _textDirection = textDirection;
    _sentAtStyle = sentAtStyle;
    _textPainter = TextPainter(
        text: TextSpan(text: _text, style: _textStyle),
        textDirection: _textDirection);
    _sentAtTextPainter = TextPainter(
      text: TextSpan(text: _sentAt, style: _textStyle),
      textDirection: _textDirection,
    );
  }

  late String _text;
  late String _sentAt;
  late TextStyle _textStyle;
  late TextDirection _textDirection;
  late TextPainter _textPainter;
  late TextPainter _sentAtTextPainter;

  late bool _sentAtFitsOnLastLine;
  late double _lineHeight;
  late double _lastMessageLineWidth;
  double _longestLineWidth = 0;
  late double _sentAtLineWidth;
  late int _numMessageLines;
  late TextStyle _sentAtStyle;

  String get text => _text;
  set text(String value) {
    if (value == _text) return;
    _text = value;
    _textPainter.text = textSpan;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  String get sentAt => _sentAt;
  set sentAt(String value) {
    if (value == _sentAt) return;
    _sentAt = value;
    _sentAtTextPainter.text = sentAtTextSpan;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set sentAtStyle(TextStyle val) {
    if (val == _sentAtStyle) return;
    _sentAtStyle = val;
    // `sentAtTextSpan` is a computed property that incorporates both the raw
    // string value and the [TextStyle], so we have to update the whole [TextSpan]
    // any time either value is updated.
    _sentAtTextPainter.text = sentAtTextSpan;
    markNeedsLayout();
  }

  TextStyle get textStyle => _textStyle;
  set textStyle(TextStyle value) {
    if (value == _textStyle) return;
    _textStyle = value;
    _textPainter.text = textSpan;
    _sentAtTextPainter.text = sentAtTextSpan;
    markNeedsLayout();
  }

  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection value) {
    if (value == _textDirection) return;
    _textDirection = value;
    _textPainter.textDirection = textDirection;
    _sentAtTextPainter.textDirection = textDirection;
    markNeedsSemanticsUpdate();
  }

  TextSpan get textSpan => TextSpan(text: _text, style: _textStyle);
  TextSpan get sentAtTextSpan => TextSpan(
      text: _text,
      style: _textStyle.copyWith(
        color: Colors.grey,
      ));

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    // Set this to `true` because individual chat bubbles are perfectly
    // self-contained semantic objects.
    config.isSemanticBoundary = true;

    config.label = '$_text, sent $_sentAt';
    config.textDirection = _textDirection;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    // Ignore `height` parameter because chat bubbles' height grows as a
    // function of available width and text length.

    _layoutText(double.infinity);
    return _longestLineWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) =>
      computeMaxIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) {
    final computedSize = _layoutText(width);
    return computedSize.height;
  }

  @override
  void performLayout() {
    final unconstrainedSize = _layoutText(constraints.maxWidth);
    size = constraints.constrain(
      Size(unconstrainedSize.width, unconstrainedSize.height),
    );
  }

  // Lays out the text within a given width constraint and returns its [Size].
  ///
  /// Because [_layoutText] is called from multiple places with multiple concerns,
  /// like intrinsics which could have different width parameters than a typical
  /// layout, this logic is moved out of `performLayout` and into a dedicated
  /// method which accepts and works with any width constraint.
  Size _layoutText(double maxWidth) {
    // Draw nothing (requiring no size) if the string doesn't exist. This is one
    // of many opinionated choices we could make here if the text is empty.
    if (_textPainter.text?.toPlainText() == '') {
      return Size.zero;
    }
    assert(
      maxWidth > 0,
      'You must allocate SOME space to layout a TimestampedChatMessageRenderObject. Received a '
      '`maxWidth` value of $maxWidth.',
    );

    // Layout the raw message, which saves expected high-level sizing values
    // to the painter itself.
    _textPainter.layout(maxWidth: maxWidth);
    final textLines = _textPainter.computeLineMetrics();

    // Now make similar calculations for `sentAt`.
    _sentAtTextPainter.layout(maxWidth: maxWidth);
    _sentAtLineWidth = _sentAtTextPainter.computeLineMetrics().first.width;

    // Reset cached values from the last frame if they're assumed to start at 0.
    // (Because this is used in `max`, if it opens a new frame still holding the
    // value from a previous frame, we could fail to accurately calculate the
    // longest line.)
    _longestLineWidth = 0;

    // Next, we calculate a few metrics for the height and width of the message.

    // First, chat messages don't actually grow to their full available width
    // if their longest line does not require it. Thus, we need to note the
    // longest line in the message.
    for (final line in textLines) {
      _longestLineWidth = max(_longestLineWidth, line.width);
    }
    // If the message is very short, it's possible that the longest line is
    // is actually the date.
    _longestLineWidth = max(_longestLineWidth, _sentAtTextPainter.width);

    // Because [_textPainter.width] can be the maximum width we passed to it,
    // even if the longest line is shorter, we use this logic to determine its
    // real size, for our purposes.
    final sizeOfMessage = Size(_longestLineWidth, _textPainter.height);

    // Cache additional variables used both in the rest of this method and in
    // `paint` later on.
    _lastMessageLineWidth = textLines.last.width;
    _lineHeight = textLines.last.height;
    _numMessageLines = textLines.length;

    // Determine whether the message's last line and the date can share a
    // horizontal row together.
    final lastLineWithDate = _lastMessageLineWidth + (_sentAtLineWidth * 1.08);
    if (textLines.length == 1) {
      _sentAtFitsOnLastLine = lastLineWithDate < maxWidth;
    } else {
      _sentAtFitsOnLastLine =
          lastLineWithDate < min(_longestLineWidth, maxWidth);
    }

    late Size computedSize;
    if (!_sentAtFitsOnLastLine) {
      computedSize = Size(
        // If `sentAt` does not fit on the longest line, then we know the
        // message contains a long line, making this a safe value for `width`.
        sizeOfMessage.width,
        // And similarly, if `sentAt` does not fit, we know to add its height
        // to the overall size of just-the-message.
        sizeOfMessage.height + _sentAtTextPainter.height,
      );
    } else {
      // Moving forward, of course, we know that `sentAt` DOES fit into the last
      // line.

      if (textLines.length == 1) {
        computedSize = Size(
          // When there is only 1 line, our width calculations are in a special
          // case of needing as many pixels as our line plus the date, as opposed
          // to the full size of the longest line.
          lastLineWithDate,
          sizeOfMessage.height,
        );
      } else {
        computedSize = Size(
          // But when there's more than 1 line, our width should be equal to the
          // longest line.
          _longestLineWidth,
          sizeOfMessage.height,
        );
      }
    }
    return computedSize;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Draw nothing (requiring no paint calls) if the string doesn't exist. This
    // is one of many opinionated choices we could make here if the text is empty.
    if (_textPainter.text?.toPlainText() == '') {
      return;
    }

    // This line writes the actual message to the screen. Because we use the
    // same offset we were passed, the text will appear in the upper-left corner
    // of our available space.
    _textPainter.paint(context.canvas, offset);

    late Offset sentAtOffset;
    if (_sentAtFitsOnLastLine) {
      sentAtOffset = Offset(
        offset.dx + (size.width - _sentAtLineWidth),
        offset.dy + (_lineHeight * (_numMessageLines - 1)),
      );
    } else {
      sentAtOffset = Offset(
        offset.dx + (size.width - _sentAtLineWidth),
        offset.dy + _lineHeight * _numMessageLines,
      );
    }

    // Finally, place the `sentAt` value accordingly.
    _sentAtTextPainter.paint(context.canvas, sentAtOffset);
  }
}
