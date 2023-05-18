import 'package:flutter/material.dart';

///动画  渐变-Y轴移动-渐变
class AnimationAlpahMoveAlpha extends StatelessWidget {
  late final Animation<double> alphaOut2;
  late final Animation<double> alphaIn2;
  late final Animation<Offset> moveUpAnim;
  final Offset startOffset, endOffset;
  //动画控制器
  late final Animation<double> controller;
  late final double offSetY;
  final Widget? childWidget;

  AnimationAlpahMoveAlpha(
      {super.key,
      required this.controller,
      required this.startOffset,
      required this.endOffset,
      this.offSetY = 50,
      required this.childWidget}) {
    //渐变出现0-1
    alphaIn2 = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 0.74, curve: Curves.easeInOut),
      ),
    );

    /// 向上移动在指定的坐标endOffset位置向上Y轴移动offSetY距离
    moveUpAnim = Tween<Offset>(
      begin: endOffset,
      end: Offset(endOffset.dx, endOffset.dy - offSetY),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.74, 0.91, curve: Curves.easeInOut),
      ),
    );

    ///渐变消失 1-0
    alphaOut2 = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.91, 1, curve: Curves.easeInOut),
      ),
    );
  }

  ///动画展示的位置
  Widget _buildAnimation(BuildContext context, child) {
    return FadeTransition(
      opacity: alphaIn2,
      child: Transform.translate(
        offset: moveUpAnim.value,
        child: FadeTransition(
          opacity: alphaOut2,
          child: childWidget,
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
