import 'package:flutter/material.dart';
import 'package:viewing_camera_modes/pages/home_page/panelDown.dart';
import 'dart:math' as math;
import 'package:viewing_camera_modes/pages/home_page/panelUp.dart';

import 'modes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _percentage;

  double get _panelTopHeight => 256;
  double get _panelBottomHeight => MediaQuery.of(context).size.height * 0.7;
  double get _max => MediaQuery.of(context).size.height * 0.5;
  double _yDrag = 0.0;
  CameraMode _cameraMode = CameraMode.Photo;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _percentage =
        Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _animate(double p, {Duration? duration}) {
    if (p > 1) p = 1;
    if (p < 0) p = 0;
    _yDrag = p * _max;

    _animationController.stop();
    _animationController.duration = duration ?? Duration.zero;
    _percentage = Tween<double>(
      begin: _percentage.value,
      end: p,
    ).animate(_animationController);

    _animationController.reset();
    _animationController.forward();
  }

  _animateUp({Duration? duration}) {
    _animate(1.0, duration: duration);
  }

  _animateDown({Duration? duration}) {
    _animate(0.0, duration: duration);
  }

  _onCameraModeTap(CameraMode cameraMode) {
    setState(() {
      _cameraMode = cameraMode;
    });

    _animateDown(duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (_) {
          var val = _yDrag - _.delta.dy;
          var p = val / _max;
          _animate(p);
        },
        onVerticalDragEnd: (_) {
          if (_.velocity.pixelsPerSecond.dy.abs() < 2) {
            if (_percentage.value > 0.5) {
              _animateUp(duration: const Duration(milliseconds: 300));
            } else {
              _animateDown(duration: const Duration(milliseconds: 300));
            }
            return;
          }

          if (_.velocity.pixelsPerSecond.dy > 0.0) {
            _animateDown(duration: const Duration(milliseconds: 300));
          } else {
            _animateUp(duration: const Duration(milliseconds: 300));
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.shade200,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/d/d3/Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, Widget? child) {
                  return Opacity(
                    opacity: _percentage.value,
                    child: child,
                  );
                },
                child: Container(
                  color: Colors.black26,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, Widget? child) {
                    return Opacity(
                      opacity: 1 - _percentage.value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.brightness_7),
                        Icon(Icons.settings),
                        Icon(Icons.camera_front),
                        Icon(Icons.flash_on),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).padding.top + 16,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, Widget? child) {
                    return Opacity(
                      opacity: _percentage.value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: Text(
                      'CAMERA MODES',
                      style: Theme.of(context).textTheme.headline6,
                    )),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, Widget? child) {
                    return Transform.translate(
                      offset:
                          Offset(0, -_panelBottomHeight * _percentage.value),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(-math.pi / 2 * _percentage.value),
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: <Widget>[
                            child!,
                            IgnorePointer(
                              ignoring: true,
                              child: Opacity(
                                opacity: _percentage.value * 0.3,
                                child: Container(
                                  height: _panelTopHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(1),
                                        Colors.black.withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: _panelTopHeight,
                    width: double.infinity,
                    child: PanelUp(
                      cameraMode: _cameraMode,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0.0,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, Widget? child) {
                    return Transform.translate(
                      offset:
                          Offset(0, -_panelBottomHeight * _percentage.value),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateX(
                            (-math.pi / 2) + (-math.pi / 2 * _percentage.value),
                          ),
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: <Widget>[
                            child!,
                            IgnorePointer(
                              ignoring: true,
                              child: Opacity(
                                opacity: (1 - _percentage.value) * 0.3,
                                child: Container(
                                  height: _panelBottomHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(1),
                                        Colors.black.withOpacity(0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: _panelBottomHeight,
                    width: double.infinity,
                    child: Transform(
                      transform: Matrix4.rotationX(-math.pi),
                      alignment: Alignment.center,
                      child: PanelDown(
                        onCameraModeTap: _onCameraModeTap,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
