import 'package:flutter/material.dart';
import 'modes.dart';

class PanelUp extends StatelessWidget {
  final CameraMode cameraMode;

  PanelUp({
    required this.cameraMode,
  });

  double get _labelWidth => 100;

  double get _labelMargin => 16;

  @override
  Widget build(BuildContext context) {
    int index = cameraMode.index;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 16,
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16.0),
            child: Transform.translate(
              offset: Offset(
                  ((MediaQuery.of(context).size.width - _labelWidth - _labelMargin * 2) / 2) -
                      (index) * (_labelWidth + _labelMargin),
                  0),
              child: Row(
                children: <Widget>[
                  ...CameraMode.values.map((e) {
                    return Container(
                      width: _labelWidth,
                      color: Colors.transparent,
                      margin: EdgeInsets.only(right: _labelMargin),
                      child: Center(
                        child: Text(
                          e.name.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black.withOpacity(cameraMode == e ? 1.0 : 0.4), fontSize: 16),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Container(
            height: 16,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: const Center(
                      child: Icon(Icons.refresh),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(132),
                ),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 20),
                        blurRadius: 30,
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: cameraMode.icon,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(48),
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
