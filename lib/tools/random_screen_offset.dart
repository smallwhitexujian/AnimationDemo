import 'dart:math';

import 'package:flutter/material.dart';

class RandomScreenOffset {
  ///获取屏幕随机坐标点，全屏幕
  static Offset generateRandomScreenCoordinates(BuildContext context) {
    Random random = Random();

    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    // 计算屏幕中心坐标
    final centerX = screenWidth / 2;
    final centerY = screenHeight / 2;
    // // 生成随机 x 坐标（范围：0 到屏幕宽度）
    // double randomX = random.nextDouble() * screenWidth;

    // // 生成随机 y 坐标（范围：0 到屏幕高度）
    // double randomY = random.nextDouble() * screenHeight;

    // 生成随机 x 偏移量（范围：-屏幕宽度/2 到 屏幕宽度/2）
    double randomXOffset =
        (random.nextDouble() * screenWidth) - (screenWidth / 2);

    // 生成随机 y 偏移量（范围：-屏幕高度/2 到 屏幕高度/2）
    double randomYOffset =
        (random.nextDouble() * screenHeight) - (screenHeight / 2);

    // 计算最终随机坐标
    double randomX = centerX + randomXOffset;
    double randomY = centerY + randomYOffset;

    return Offset(randomXOffset, randomYOffset);
  }

  static Offset generateRandomScreenCoordinates1_4(BuildContext context) {
    Random random = Random();

    // 获取屏幕尺寸
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    // 计算屏幕中心坐标
    final centerX = screenWidth / 2;
    final centerY = screenHeight / 2;

    // 生成随机 x 偏移量（范围：-屏幕宽度/2 到 屏幕宽度/2）
    double randomXOffset =
        (random.nextDouble() * screenWidth) - (screenWidth / 2);

    // 生成随机 y 偏移量（范围：-屏幕高度/2 到 屏幕高度/2）
    double randomYOffset =
        (random.nextDouble() * screenHeight) - (screenHeight / 2);

    // 计算最终随机坐标
    double randomX = centerX + randomXOffset;
    double randomY = centerY + randomYOffset;

    return Offset(randomX, randomY);
  }
}
