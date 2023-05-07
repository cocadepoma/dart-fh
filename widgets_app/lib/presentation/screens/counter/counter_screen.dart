import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final bool isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: Icon(
              !isDarkMode 
                ? Icons.light_mode_outlined 
                : Icons.dark_mode_outlined
              ),
            // icon: Icon(Icons.dark_mode_outlined),
            onPressed:  () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier)
            .state++;
            // .update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text('Value: $clickCounter', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}