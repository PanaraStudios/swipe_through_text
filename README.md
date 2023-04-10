# SwipeThroughText Flutter Package

[![Pub Version](https://img.shields.io/pub/v/swipe_through_text?style=plastic)](https://pub.dev/packages/swipe_through_text) [![GitHub](https://img.shields.io/github/license/PanaraStudios/swipe_through_text?style=plastic)](https://pub.dev/packages/swipe_through_text/license) 


SwipeThroughText is a customizable Flutter widget that allows users to swipe through a text and strikethrough it when a certain swipe threshold is met. The package is suitable for use in various types of Flutter apps, including to-do lists, notes, and more.


## Preview

<img src="https://raw.githubusercontent.com/PanaraStudios/swipe_through_text/master/preview/preview.gif" height="400"/>

## Limitations

> Currently this package only supports single line text, overflow text
> will be trimmed and ellipses `...` will be added the end. Still this
> is temporary limitation, feel free contribute to add support for
> multi-lines.

## Getting Started

### Installation

Add the following line to your `pubspec.yaml` file:

    dependencies:
      swipe_through_text: ^0.0.3 

Then, run `flutter pub get` in your terminal.

### Usage

Import the package into your Dart code:

    import 'package:swipe_through_text/swipe_through_text.dart';

To use the `SwipeThroughText` widget, simply add it to your widget tree with the required parameters, such as `text` and `textStyle`, and any optional parameters such as `strikethroughColor`, `strikethroughLineHeight`, `swipeThreshold`, `onSwipeComplete`, `onSwipeCancel`, and `dashArray`.

    SwipeThroughText(
      text: 'Swipe me!',
      textStyle: TextStyle(fontSize: 24),
      strikethroughColor: Colors.red,
      strikethroughLineHeight: 4,
      swipeThreshold: 0.8,
      onSwipeComplete: (fraction) {
        // Do something when swiping is complete
      },
      onSwipeCancel: (fraction) {
        // Do something when swiping is cancelled
      },
    )

You can also customize the strikethrough line using the `dashArray` parameter, which takes in a list of double values that determine the length of the dashes and gaps in the strikethrough line. For example, `[10, 5]` will create a dashed line with a 10-pixel dash and a 5-pixel gap.

### Example

    import 'package:flutter/material.dart';
    import 'package:swipe_through_text/swipe_through_text.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'SwipeThroughText Demo',
          home: Scaffold(
            appBar: AppBar(
              title: Text('SwipeThroughText Demo'),
            ),
            body: Center(
              child: SwipeThroughText(
                text: 'Swipe me!',
                textStyle: TextStyle(fontSize: 24),
                strikethroughColor: Colors.red,
                strikethroughLineHeight: 4,
                swipeThreshold: 0.8,
                onSwipeComplete: (fraction) {
                  print('Swipe completed at $fraction');
                },
                onSwipeCancel: (fraction) {
                  print('Swipe cancelled at $fraction');
                },
                dashArray: [10, 5],
              ),
            ),
          ),
        );
      }
    }

## Contributing

Contributions to this package are welcome! If you find a bug or have a feature request, please open an issue or submit a pull request.
