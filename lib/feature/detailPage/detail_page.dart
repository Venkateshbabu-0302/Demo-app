import 'package:flutter/material.dart';

import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../../core/utils/styles.dart';
import '../../repo/user_model.dart';

class DetailPage extends StatelessWidget{
DetailPage({super.key, required this.user});
final UserModel user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(detailPage)
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x3600000F),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.network(
                        user.avatar.toString(),
                        width: alertPaddingTop,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                      child: Text(
                        user.firstName.toString(),
                          style: onBoardingScreenTitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                      child: Text(
                        '\$${user.email.toString()}',
                        style: onBoardingScreenTitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
