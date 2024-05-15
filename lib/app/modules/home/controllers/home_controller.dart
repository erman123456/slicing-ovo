import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final up = false.obs;
  final down = false.obs;
  final visible = false.obs;

  final GlobalKey keyDraggable = GlobalKey();
  final top = 322.0.obs;
  final left = 300.0.obs;
  final animationSpeed = 0.obs;
  final isHide = false.obs;

  final count = 0.obs;
  final index = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void changeIndex(index) => this.index.value = index;


  void onDragUpdate(drag) {
    top.value = top.value + drag.delta.dy;
    left.value = left.value + drag.delta.dx;
  }

  void onDragEnd() {
    animationSpeed.value = 500;
    if (!isHide.value) {
      left.value = left.value > 178 ? 300 : -30;
    } else {
      left.value = left.value > 178 ? 330 : -60;
    }
  }

  void swapHide() {
    if (isHide.value) {
      left.value = left.value < 0 ? -30 : 300;
    } else {
      left.value = left.value > 0 ? 330 : -60;
    }
    isHide.value = !isHide.value;
  }

}
