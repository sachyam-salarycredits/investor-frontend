import 'dart:io';

import 'package:Monexo/modules/onboardingSteps/models/steps_data.dart';
import 'package:Monexo/modules/profile/widgets/logoWidget.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/routes_management/routes_list.dart';
import 'package:Monexo/modules/profile/screens/profile_detail_screen.dart';
import 'package:Monexo/modules/marketplace/screens/redemption_screen.dart';
import 'package:Monexo/modules/onboardingSteps/screens/whats_next_screen.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/constants.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:Monexo/modules/onboardingSteps/widgets/whats_next_widget.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:Monexo/widgets/custom_button.dart';
import 'package:Monexo/widgets/profile_end_nav_bar.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyy_flutter_plugin/flyy_flutter_plugin.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'nav_bar_widget.dart';

class Header extends StatelessWidget {
  bool isBackBtnVisible;
  bool isLogoVisible;
  bool isDownloadBarVisible;
  bool isMenuVisible;
  bool isReload;
  bool isLogout;
  VoidCallback? backOnPressed;
  VoidCallback? backOnPressedMarket;
  VoidCallback? menuOnPressed;

  Header({
    Key? key,
    this.isBackBtnVisible = true,
    this.isLogoVisible = true,
    this.isMenuVisible = false,
    this.isDownloadBarVisible = false,
    this.isReload = false,
    this.isLogout = false,
    this.backOnPressed,
    this.backOnPressedMarket,
    this.menuOnPressed,
  }) : super(key: key);

  Widget getLeading() {
    if (isBackBtnVisible) {
      return IconButton(
        icon: Icon(Icons.keyboard_backspace),
        onPressed: backOnPressed,
      );
    } else if (isReload) {
      return Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: backOnPressedMarket,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: backOnPressed,
          ),
        ],
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: ColorsUtil.headerGray,
          leading: getLeading(),
          leadingWidth: isReload ? 88 : null,
          centerTitle: true,
          // bottom: PreferredSize(
          //   child: Container(
          //     height: 80,
          //   ),
          //   preferredSize: Size.fromHeight(80),
          // ),
          actions: [
            (isMenuVisible)
                ? IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      context.pushNamed(RoutesName.SettingsScreen);
                      // context.pushNamed(RoutesName.ProfileScreen);
                    },
                    icon: Icon(Icons.menu))
                // NavBarWidget()
                : IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Utils.launchSupportCall();
                    },
                    icon: Icon(Icons.support_agent)),
            (isLogout)
                ? IconButton(
                    padding: EdgeInsets.only(right: 10),
                    onPressed: () {
                      Utils.showDoubleBtnAlert(
                          context: context,
                          title: "Logout",
                          msg: 'Are you sure want to Logout?',
                          onTap: () {
                            context.read<AppStateProvider>().clearUserState();
                            context.goNamed(RoutesName.LandingScreen);
                          });
                    },
                    icon: Icon(Icons.logout))
                : SizedBox(),
          ],
          title: Visibility(
            visible: isLogoVisible,
            child: Image(
              image: AssetImage(LocalImages.monexo_logo),
              height: 90,
              width: 160,
            ),
          ),
        ),
        Visibility(
            visible: Utils.isWeb && isDownloadBarVisible,
            child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          insetPadding: EdgeInsets.all(2),
                          contentPadding: EdgeInsets.all(2),
                          titlePadding: EdgeInsets.all(2),
                          title: ListTile(
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 32,
                                ),
                              ),
                              title: Text(
                                "Download Monexo Investor Application. ",
                                style: Theme.of(context).textTheme.headline6,
                              )),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              CustomButton(
                                bgColor: Colors.green,
                                titleStr: "IOS",
                                onPress: () {
                                  launch(Constants.appStoreUrl);
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              CustomButton(
                                bgColor: Colors.green,
                                titleStr: "ANDROID",
                                onPress: () {
                                  launch(Constants.playStoreUrl);
                                },
                              ),
                            ],
                          ),
                          actions: [],
                        ));
              },
              tileColor: Colors.green,
              textColor: Colors.white,
              title: Text("Download Monexo Investor Mobile App"),
              trailing: Icon(
                Icons.download,
                color: Colors.white,
              ),
            ))
      ],
    );

    var screenSize = MediaQuery.of(context).size;
  }
}
