import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages () {
    const messages = <String>[
      'Loading films',
      'Cooking popcorn',
      'Do you want a finger?',
      'Buying chips',
      'Ordering pizza',
      'This is taking so much :('
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textStyleLarge = Theme.of(context).textTheme.titleLarge;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text('Wait, please', style: textStyleLarge),
          const SizedBox(height: 20),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text('Loading...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}