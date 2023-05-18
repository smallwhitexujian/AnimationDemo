import 'package:flutter/material.dart';

///动画  渐变-缩放-移动-渐变
class AnimationAlphaScaleMoveAlpha extends StatelessWidget {
  //渐变展示——从0-1
  late final Animation<double> alphaIn;
  //渐变消失——1-0
  late final Animation<double> alphaOut;
  //缩放动画
  late final Animation<double> scaleAnim;
  //位移动画
  late final Animation<Offset> moveAnim;
  //起点坐标，终点坐标
  final Offset startOffset, endOffset;
  //动画控制器
  late final Animation<double> controller;
  //向上移动
  final double offSetY;
  //展示的widget
  final Widget? childWidget;
  AnimationAlphaScaleMoveAlpha(
      {super.key,
      required this.controller,
      required this.startOffset,
      required this.endOffset,
      required this.childWidget,
      this.offSetY = 50}) {
    //实现渐变展示
    alphaIn = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        //占总时间的
        curve: const Interval(0.0, 0.07, curve: Curves.easeInOut),
      ),
    );

    //缩放
    scaleAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        //占总时间的
        curve: const Interval(0.0, 0.07, curve: Curves.easeInOut),
      ),
    );

    //停留在这里2300 0.69
    //移动
    moveAnim = Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.65, curve: Curves.easeInOut),
      ),
    );

    //渐变消失
    alphaOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.65, 0.7, curve: Curves.easeInOut),
      ),
    );
  }

  ///动画展示的位置
  Widget _buildAnimation(BuildContext context, child) {
    return FadeTransition(
      opacity: alphaIn,
      child: Transform.scale(
        scale: scaleAnim.value,
        child: Transform.translate(
          offset: moveAnim.value,
          child: Transform.scale(
            scale: alphaOut.value,
            child: childWidget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
