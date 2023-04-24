import 'package:flutter/material.dart';

class HerMessageBubble extends StatelessWidget {
  const HerMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, 
              borderRadius: BorderRadius.circular(20)
            ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Hola mundo', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 15),
        const _ImageBubble(),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  const _ImageBubble();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
          "https://yesno.wtf/assets/no/3-80a6f5b5d6684674bcfeda34accca4e1.gif",
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress == null) return child;

            return Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: const [
                  Text('Mi amor está enviando una imagen...'),
                ],
              ),
            );
          },
      ),
    );
  }
}
