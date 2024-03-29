import 'package:flutter/material.dart';
import 'package:gtrack_mobile_app/constants/app_icons.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/global/common/utils/app_navigator.dart';
import 'package:gtrack_mobile_app/global/widgets/buttons/card_icon_button.dart';
import 'package:gtrack_mobile_app/screens/home/share/Scanning/scanning_screen.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final List<Map> data = [
    {
      "text": "PRODUCT INFORMATION",
      "icon": AppIcons.aggAssembling,
      "onPressed": () {},
    },
    {
      "text": "DIGITAL LINKS",
      "icon": AppIcons.digital,
      "onPressed": () {},
    },
    {
      "text": "PRODUCT CATALOGUE",
      "icon": AppIcons.productCatalogue,
      "onPressed": () {},
    },
    {
      "text": "PRODUCT CERTIFATES",
      "icon": AppIcons.productCertificate,
      "onPressed": () {},
    },
    {
      "text": "EPCIS",
      "icon": AppIcons.epcis,
      "onPressed": () {},
    },
    {
      "text": "CVB",
      "icon": AppIcons.cvb,
      "onPressed": () {},
    },
    {
      "text": "PRODUCT ORIGIN",
      "icon": AppIcons.productOrigin,
      "onPressed": () {},
    },
    {
      "text": "TRACEABILITY",
      "icon": AppIcons.traceability,
      "onPressed": () {},
    },
  ];

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.6,
    crossAxisSpacing: 20,
    mainAxisSpacing: 50,
  );

  @override
  void initState() {
    data[0]["onPressed"] = () {
      AppNavigator.goToPage(context: context, screen: const ScanningScreen());
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
        backgroundColor: AppColors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: gridDelegate,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              itemBuilder: (context, index) {
                return CardIconButton(
                  icon: data[index]["icon"],
                  onPressed: data[index]["onPressed"],
                  text: data[index]['text'],
                  fontSize: 10,
                );
              },
              itemCount: data.length,
            ),
          ],
        ),
      ),
    );
  }
}
