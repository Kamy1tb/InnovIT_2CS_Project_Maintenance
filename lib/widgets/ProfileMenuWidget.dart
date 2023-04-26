import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innovit_2cs_project_paiement/utilities/constants.dart';

class ProfileMenuWidget extends StatefulWidget {

  Icon icon;
  String label;
  VoidCallback onClick;

  ProfileMenuWidget({
    Key? key,
    required this.icon,
    required this.label,
    required this.onClick,
  }) : super(key: key);

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: GestureDetector(
              onTap: widget.onClick,
              child: Row(
                children: [
                  widget.icon,
                  const SizedBox(width: 10),
                  Text(
                    widget.label
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: cadetGray,
            thickness: 1,
          ),
        ],
      ),
    );  }
}
