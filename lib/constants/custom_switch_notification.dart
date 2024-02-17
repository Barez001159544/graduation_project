import 'package:flutter/material.dart';

class CustomSwitchBtn extends StatelessWidget {
  final bool value;
  final Color inactiveTrackColor;
  final Function(dynamic) doFunction;
  const CustomSwitchBtn(this.value, this.inactiveTrackColor, this.doFunction);
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: inactiveTrackColor,
      hoverColor: Colors.transparent,
      trackOutlineColor: MaterialStateProperty.resolveWith(
            (final Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return null;
          }
          return inactiveTrackColor;
        },
      ),
      onChanged: (bool value) {
        doFunction(value);
      },
    );
  }
}