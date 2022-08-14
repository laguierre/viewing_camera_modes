import 'package:flutter/material.dart';

enum CameraMode {
  Photo,
  Video,
  Portrait,
  SlowMo,
  TimeLapse,
  Manual,
}

extension CameraModeExtension on CameraMode {
  String get name {
    switch (this) {
      case CameraMode.Photo:
        return "Photo";
      case CameraMode.Video:
        return "Video";
      case CameraMode.Portrait:
        return "Portrait";
      case CameraMode.SlowMo:
        return "Slow Mo";
      case CameraMode.TimeLapse:
        return "Time Lapse";
      case CameraMode.Manual:
        return "Manual";
    }
  }

  Widget get icon {
    switch (this) {
      case CameraMode.Photo:
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.circular(100),
          ),
        );
      case CameraMode.Video:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.redAccent.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.shade400.withOpacity(0.4),
                offset: const Offset(0, 10),
                blurRadius: 5,
              )
            ],
          ),
        );
      case CameraMode.Portrait:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: Icon(
              Icons.portrait,
              size: 40,
              color: Colors.orange,
            ),
          ),
        );
      case CameraMode.SlowMo:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Icon(
              Icons.slow_motion_video,
              size: 40,
              color: Colors.deepOrangeAccent.shade400,
            ),
          ),
        );
      case CameraMode.TimeLapse:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: Icon(
              Icons.timelapse,
              size: 40,
              color: Colors.deepPurple,
            ),
          ),
        );
      case CameraMode.Manual:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: Icon(
              Icons.more_horiz,
              size: 40,
              color: Colors.deepPurpleAccent,
            ),
          ),
        );
    }
  }
}