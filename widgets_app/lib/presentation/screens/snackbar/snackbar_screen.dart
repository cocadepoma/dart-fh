import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar (BuildContext context) {
      ScaffoldMessenger.of(context).clearSnackBars();

      final snackbar = SnackBar(
        content: const Text('Hola mundo'),
        action: SnackBarAction(label: 'ok!', onPressed: () {}),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


  void openDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>  AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Va usté muy cargadoo la caidita la caidita me cago en tus muelas te va a hasé pupitaa qué dise usteer no te digo trigo por no llamarte Rodrigor.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel')
          ),
          FilledButton(
            onPressed: () => context.pop(), 
            child: const Text('Agree'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Dialogs and snackbars'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Show snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(
                  applicationName: 'Flutter Widgets',
                  context: context,
                  children: [
                    const Text('Lorem fistrum no te digo trigo por no llamarte Rodrigor está la cosa muy malar no te digo trigo por no llamarte Rodrigor. Qué dise usteer hasta luego Lucas ese que llega torpedo ese que llega te voy a borrar el cerito pupita pecador jarl la caidita te voy a borrar el cerito.')
                  ]
                );
              },
              child: const Text('Used licenses')
            ),

            FilledButton.tonal(
              onPressed: () => openDialog(context), 
              child: const Text('Show dialog')
            ),
          ],
        ),
      ),
    );
  }
}
