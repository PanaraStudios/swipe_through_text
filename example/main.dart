import 'package:flutter/material.dart';
import 'package:swipe_through_text/swipe_through_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwipeThroughText Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SwipeThroughText Demo'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwipeThroughText(
                text: 'Swipe Through me! limited to 1 line',
                textStyle: const TextStyle(fontSize: 24),
                strikethroughColor: Colors.red,
                strikethroughLineHeight: 4,
                swipeThreshold: 0.5,
                onSwipeComplete: (fraction) {
                  debugPrint('Swipe completed at $fraction');
                },
                onSwipeCancel: (fraction) {
                  debugPrint('Swipe cancelled at $fraction');
                },
                dashArray: const [], // for dotted line use: const [10, 5],
              ),
              const SizedBox(
                height: 10,
              ),
              SwipeThroughText(
                text: 'Swipe Through me! limited to 1 line',
                textStyle: const TextStyle(fontSize: 24),
                strikethroughColor: Colors.green,
                strikethroughLineHeight: 4,
                swipeThreshold: 0.5,
                onSwipeComplete: (fraction) {
                  debugPrint('Swipe completed at $fraction');
                },
                onSwipeCancel: (fraction) {
                  debugPrint('Swipe cancelled at $fraction');
                },
                dashArray: const [10, 5],
              ),
              const SizedBox(
                height: 10,
              ),
              SwipeThroughText(
                text: 'Swipe Through me! limited to 1 line',
                textStyle: const TextStyle(fontSize: 24),
                strikethroughColor: Colors.purple,
                strikethroughLineHeight: 4,
                swipeThreshold: 0.5,
                onSwipeComplete: (fraction) {
                  debugPrint('Swipe completed at $fraction');
                },
                onSwipeCancel: (fraction) {
                  debugPrint('Swipe cancelled at $fraction');
                },
                dashArray: const [], // for dotted line use: const [10, 5],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
