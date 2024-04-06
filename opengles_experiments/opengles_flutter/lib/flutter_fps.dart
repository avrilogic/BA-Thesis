import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

extension FPS on Duration {
  double get fps => (1000 / inMilliseconds);
}

class FlutterFps extends StatefulWidget {
  final Widget? child;
  final void Function(int fps)? onFpsSignal;
  const FlutterFps({
    super.key,
    this.child,
    this.onFpsSignal,
  });

  @override
  FlutterFpsState createState() => FlutterFpsState();
}

class FlutterFpsState extends State<FlutterFps> {
  Duration? previous;
  List<Duration> timings = [];
  StreamSubscription? subscription;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(update);
    subscription = Stream.periodic(const Duration(seconds: 1)).listen((event) {
      //average fps time
      final fps = timings
              .fold<Duration>(Duration.zero,
                  (previousValue, element) => previousValue + element)
              .fps *
          timings.length;
      timings.clear();
      widget.onFpsSignal?.call(fps.round());
    });
    super.initState();
  }

  update(Duration duration) {
    if (!mounted) {
      return;
    }

    setState(() {
      if (previous != null) {
        timings.add(duration - previous!);
      }

      previous = duration;
    });

    SchedulerBinding.instance.addPostFrameCallback(update);
  }

  @override
  void didUpdateWidget(covariant FlutterFps oldWidget) {
    SchedulerBinding.instance.addPostFrameCallback(update);

    super.didUpdateWidget(oldWidget);
  }

  @override
  dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
