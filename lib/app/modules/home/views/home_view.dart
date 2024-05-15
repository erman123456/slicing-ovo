import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:ovo/app/constants/Assets.dart';
import 'package:ovo/app/constants/text_theme.dart';
import 'package:styled_widget/styled_widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  static Color purple = Colors.purple.shade900;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(Assets.bg1),
            SvgPicture.asset(Assets.notif).positioned(top: 50, right: 16),
            balance().padding(top: 50, left: 16),
            transaction().padding(top: 200, horizontal: 16),
            body().padding().padding(top: 300),
            AnimatedPositioned(
              key: controller.keyDraggable,
              top: controller.top.value,
              left: controller.left.value,
              duration:
              Duration(milliseconds: controller.animationSpeed.value),
              child: Draggable(
                child: animationIcon(),
                feedback: animationIcon(),
                childWhenDragging: Container(),
                onDragUpdate: (drag) {
                  controller.onDragUpdate(drag);
                },
                onDragEnd: (drag) {
                  controller.onDragEnd();
                },
              ),
            ),
            bottomNav()
          ],
        ),
      );
    });
  }

  Widget balance() {
    return [
      Text('OVO', style: OvoTextStyle.h4),
      Text('OVO Cash', style: OvoTextStyle.normalWhiteBold)
          .padding(vertical: 10),
      [
        Text(
          'Rp  ',
          style: OvoTextStyle.normalWhiteBold,
        ),
        Text('6.590.000', style: OvoTextStyle.h4),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start).padding(bottom: 10),
      [
        Text(
          'OVO Points ',
          style: OvoTextStyle.normalWhiteBold
              .copyWith(color: Colors.white.withOpacity(0.5)),
        ),
        Text('50.400',
            style: OvoTextStyle.normalWhiteBold
                .copyWith(color: Colors.orange.shade800)),
      ].toRow(),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          menu(),
          Divider(color: Colors.grey.shade200, thickness: 10)
              .padding(vertical: 30),
          promo('Promo Terbaru'),
          Divider(color: Colors.grey.shade200, thickness: 10)
              .padding(vertical: 30),
          promo('Info dan Promo Spesial').padding(bottom: 80),
        ],
      ).padding(top: 20),
    );
  }

  Widget animationIcon() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: !controller.visible.value ? 1 : 0,
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(3), // Border width
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4), shape: BoxShape.circle),
              child: Image.asset(
                Assets.gift,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ).clipOval(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(4), // Border width
            decoration: BoxDecoration(
                color: Colors.blue.shade900, shape: BoxShape.circle),
            child: SvgPicture.asset(
              controller.isHide.value
                  ? controller.left.value > 0
                  ? Assets.lIconlyArrowLeft2
                  : Assets.lIconlyArrowRight2
                  : controller.left.value > 0
                  ? Assets.lIconlyArrowRight2
                  : Assets.lIconlyArrowLeft2,
              width: 10,
              height: 10,
              color: Colors.white,
            ).clipOval(),
          ).gestures(onTap: () => controller.swapHide()).positioned(
              right: controller.left.value > 0 ? 85 : 20, bottom: 20),
        ],
      ).width(125),
    );
  }

  Widget promo(title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: OvoTextStyle.h5.copyWith(color: Colors.black)),
            Text(
              'Lihat Semua',
              style: OvoTextStyle.normal.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          ],
        ).padding(bottom: 10),
        PageView(
          scrollDirection: Axis.horizontal,
          children: [
            Image.asset(Assets.banner1, fit: BoxFit.cover),
            Image.asset(Assets.banner2, fit: BoxFit.cover),
          ],
        ).height(120).clipRRect(all: 10),
      ],
    ).padding(horizontal: 16);
  }

  Widget transaction() {
    return Card(
      elevation: 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon(Assets.topUp, "Top Up"),
          icon(Assets.transfer, "Transfer"),
          icon(Assets.history, "History"),
        ],
      ).padding(vertical: 10, horizontal: 30),
    );
  }

  Widget menu() {
    return Column(
      children: [
        [
          iconMenu(Assets.pln, "PLN"),
          iconMenu(Assets.phone, "Pulsa"),
          iconMenu(Assets.quota, "Paket Data"),
          iconMenu(Assets.postpaid, "Pasca Bayar"),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        SizedBox(height: 40),
        [
          iconMenu(Assets.bpjs, "BPJS"),
          iconMenu(Assets.internet, "Internet & TV Kabel"),
          iconMenu(Assets.iuran, "Iuran Keuangan"),
          iconMenu(Assets.another, "Lainnya"),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      ],
    ).padding(horizontal: 16);
  }

  Widget iconMenu(icon, text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          height: 60,
          width: 60,
        ).padding(bottom: 10),
        Text(
          text,
          style: OvoTextStyle.normal.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ).width(80),
      ],
    );
  }

  Widget icon(icon, text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          height: 40,
          width: 40,
        ).padding(bottom: 10),
        Text(
          text,
          style: OvoTextStyle.normal
              .copyWith(color: purple, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget iconNav(icon, text, index) {
    final indexCtr = controller.index.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 25,
          width: 25,
          color: indexCtr == index ? purple : Colors.grey.shade400,
        ).padding(bottom: 2),
        Text(
          text,
          style: OvoTextStyle.normal.copyWith(
            fontWeight: FontWeight.bold,
            color: indexCtr == index ? purple : Colors.grey.shade400,
          ),
        ),
      ],
    ).gestures(onTap: () => controller.changeIndex(index));
  }

  Widget qrisIcon(icon, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: 50,
          width: 50,
        ).padding(bottom: 2),
        Text(
          text,
          style: OvoTextStyle.normal.copyWith(
            fontWeight: FontWeight.bold,
            color: purple,
          ),
        ),
      ],
    );
  }

  Widget bottomNav() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        fit: StackFit.expand,
        children: [
          [
            iconNav(Assets.home, 'home', 0),
            iconNav(Assets.rp, 'Finance', 1),
            SizedBox(width: 50),
            iconNav(Assets.inbox, 'Inbox', 2),
            iconNav(Assets.profile, 'Profile', 3),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(top: 10, horizontal: 20)
              .height(80)
              .backgroundColor(Colors.white)
              .positioned(bottom: 0, right: 0, left: 0),
          qrisIcon(Assets.qris, 'Pay').center(),
        ],
      ).height(100),
    );
  }
}
