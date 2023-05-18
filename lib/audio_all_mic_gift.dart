import 'package:flutter/material.dart';

import 'animation/animation_alpha_move_alpha.dart';
import 'animation/animation_alpha_scale_move_alpha.dart';

///动画状态回调 [status]动画状态每个阶段状态
typedef AnimationStateCallback = Function(AnimationStatus status);

class AudioAllMicGift extends StatefulWidget {
  //动画状态监听
  final AnimationStateCallback? animationStateCallback;
  //起点坐标 默认屏幕中间点
  final Offset startOffset;
  //终点坐标
  final Offset endOffset;
  //动画控制的空间组件widget
  final Widget? childWidget;
  //y坐标移动的距离 默认50
  final double offSetY;
  //动画持续的时间 默认4500
  final int durationTime;

  ///多轨迹动画
  ///[startOffset] 起始位置，默认参数为屏幕中心点
  ///[childWidget] 动画控制的小组件，widget，
  ///[endOffset]   结束位置，#Offset(dx,dy)
  ///[offSetY]     最后偏移位置的距离 Y轴偏移量
  ///[durationTime]动画持续时间，int 单位毫秒
  ///[animationStateCallback] 动画状态回调，开始，结束，重播回调
  const AudioAllMicGift(
      {super.key,
      this.startOffset = Offset.zero,
      required this.childWidget,
      required this.endOffset,
      this.offSetY = 50,
      this.durationTime = 4500,
      this.animationStateCallback});

  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }
}

class AnimationState extends State<AudioAllMicGift>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationTime));
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationTime));

    controller.addStatusListener((status) {
      //动画状态回调
      widget.animationStateCallback?.call(status);
    });

    playAnimation();
  }

  @override
  void dispose() {
    ///释放动画
    controller.reset();
    controller2.reset();
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  ///开始播放动画
  playAnimation() {
    //重置动画
    controller.reset();
    controller2.reset();
    //正向播放动画
    controller.forward();
    controller2.forward();
  }

  //创建动画前部分
  createGiftViewAnimation() {
    return AnimationAlphaScaleMoveAlpha(
      controller: controller2,
      startOffset: widget.startOffset,
      endOffset: widget.endOffset,
      offSetY: widget.offSetY,
      childWidget: widget.childWidget,
    );
  }

  //创建动画后部分
  createGiftViewAnimation2() {
    return AnimationAlpahMoveAlpha(
      controller: controller2,
      startOffset: widget.startOffset,
      endOffset: widget.endOffset,
      offSetY: widget.offSetY,
      childWidget: widget.childWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [createGiftViewAnimation(), createGiftViewAnimation2()],
    );
  }
}
