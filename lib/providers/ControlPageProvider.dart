import 'package:flutter/material.dart';

class ControlPageProvider with ChangeNotifier {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;
}