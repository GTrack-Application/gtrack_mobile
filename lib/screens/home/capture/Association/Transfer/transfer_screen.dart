import 'package:flutter/material.dart';
import 'package:gtrack_mobile_app/constants/app_icons.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/global/common/utils/app_navigator.dart';
import 'package:gtrack_mobile_app/global/widgets/buttons/card_icon_button.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Shipping/BinToBinAXAPTA/BinToBinAxaptaScreen.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Transfer/BinToBinTransfer/BinToBinInternalScreen.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Transfer/ItemReallocation/ItemReAllocationScreen.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Transfer/PalletTransfer/PalletTransferScreen.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Transfer/RawMaterialsToWIPS/RawMaterialsToWIPScreen1.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Association/Transfer/WIPtoFG/WIPtoFGScreen.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final List<Map> data = [
    {
      "text": "Raw Materials to WIP",
      "icon": AppIcons.transferRaw,
      "onTap": () {},
    },
    {
      "text": "Warehouse Transfer",
      "icon": AppIcons.transferWarehouse,
      "onTap": () {},
    },
    {
      "text": "Bin to Bin Transfer",
      "icon": AppIcons.transferBinToBin,
      "onTap": () {},
    },
    {
      "text": "Pallet Transfer",
      "icon": AppIcons.transferPallet,
      "onTap": () {},
    },
    {
      "text": "Pallet Re-Allocation",
      "icon": AppIcons.aggPackaging,
      "onTap": () {},
    },
    {
      "text": "FIP to FG Transfer",
      "icon": AppIcons.transferItem,
      "onTap": () {},
    },
  ];

  @override
  void initState() {
    super.initState();
    data[0]["onTap"] = () => AppNavigator.goToPage(
        context: context, screen: RawMaterialsToWIPScreen1());
    data[1]["onTap"] = () => AppNavigator.goToPage(
        context: context, screen: const BinToBinAxaptaScreen());
    data[2]["onTap"] = () => AppNavigator.goToPage(
        context: context, screen: const BinToBinInternalScreen());
    data[3]["onTap"] = () => AppNavigator.goToPage(
        context: context, screen: const PalletTransferScreen());
    data[4]["onTap"] = () => AppNavigator.goToPage(
        context: context, screen: const ItemReAllocationScreen());
    data[5]["onTap"] = () =>
        AppNavigator.goToPage(context: context, screen: const WIPtoFGScreen());
  }

  final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.6,
    crossAxisSpacing: 20,
    mainAxisSpacing: 50,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: AppColors.pink,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: gridDelegate,
              itemBuilder: (context, index) {
                return CardIconButton(
                  icon: data[index]["icon"] as String,
                  onPressed: data[index]["onTap"],
                  text: data[index]['text'] as String,
                );
              },
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            ),
          ],
        ),
      ),
    );
  }
}
