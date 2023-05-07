import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.link,
    required this.icon
    });
}

const appMenuItems = <MenuItem>[
  MenuItem(
      icon: Icons.smart_button_outlined,
      link: '/buttons',
      title: 'Buttons',
      subtitle: 'Some Flutter buttons'),

  MenuItem(
      icon: Icons.credit_card,
      link: '/cards',
      title: 'Cards',
      subtitle: 'An stylized container'),

  MenuItem(
      icon: Icons.refresh_rounded,
      link: '/progress',
      title: 'ProgressIndicators',
      subtitle: 'An stylized container'),

  MenuItem(
      icon: Icons.info_outline,
      link: '/snackbars',
      title: 'Dialogs and snackbars',
      subtitle: 'Indicators in your screen'),

  MenuItem(
      icon: Icons.check_box_outline_blank_rounded,
      link: '/animated',
      title: 'Animated container',
      subtitle: 'Animated stateful widget'),

  MenuItem(
      icon: Icons.car_rental_outlined,
      link: '/ui-controls',
      title: 'UI controls + Tiles',
      subtitle: 'Controls from Flutter'),

  MenuItem(
      icon: Icons.accessible_rounded,
      link: '/tutorial',
      title: 'App Tutorial',
      subtitle: 'Smnall introductory tutorial'),

  MenuItem(
      icon: Icons.list_alt_outlined,
      link: '/infinite',
      title: 'Inifnite scroll',
      subtitle: 'Infinite scroll example'),
];
