import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';


class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        return _CustomListTile(menuItem: appMenuItems[index]);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final MenuItem menuItem;
  const _CustomListTile({
    required this.menuItem
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(menuItem.icon, color: colors.primary),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subtitle),
      // tileColor: Colors.amber,
      onTap: () {
        //  Base navigator
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const ButtonsScreen())
        // );

        //  Base navigator with named routes in homescreen
        // Navigator.pushNamed(context, menuItem.link);

        //  Go router with routes in homescreen
        // context.pushNamed(CardsScreen.name);
        
        context.push(menuItem.link);

      }
    );
  }
}