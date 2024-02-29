import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashController extends GetxController {
  RxInt screenIndex = 0.obs;
  Rx<PageController> pageController = PageController(initialPage:0).obs;
}