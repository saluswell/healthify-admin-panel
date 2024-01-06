import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saluwell_admin_panel/utils/appcolors.dart';

import '../models/option_model.dart';
import '../providers/role_provider.dart';

class CustomRadioGroupButton extends StatelessWidget {
  final List<Role> roles;

  CustomRadioGroupButton({required this.roles});

  @override
  Widget build(BuildContext context) {
    RoleProvider roleProvider = Provider.of<RoleProvider>(context);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: roles.map((role) {
            bool isSelected = role == roleProvider.selectedRole;
            return InkWell(
              onTap: () {
                roleProvider.selectedRole = role;
              },
              child: Container(
                // color: isSelected ? Colors.blue : null,
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      height: 19,
                      width: 19,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        border:
                            Border.all(width: 2, color: AppColors.blackColor),
                      ),
                      child: isSelected
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: AppColors.blackcolor),
                              ),
                            )
                          : SizedBox(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      role.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.blueColor,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ],
    );
  }
}
