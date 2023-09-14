import 'package:flutter/material.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/screens/home/share/product-information/gtin_information_screen.dart';

class ProductInformationScreen extends StatefulWidget {
  const ProductInformationScreen({super.key});

  @override
  State<ProductInformationScreen> createState() =>
      _ProductInformationScreenState();
}

class _ProductInformationScreenState extends State<ProductInformationScreen> {
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'GTIN Information'),
    Tab(text: 'Tab 2'),
    Tab(text: 'Tab 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Information'),
          bottom: TabBar(
            tabs: myTabs,
            automaticIndicatorColorAdjustment: true,
            indicatorColor: AppColors.green,
            unselectedLabelColor: AppColors.white,
            labelColor: AppColors.white,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            // Widget for Tab 1
            GtinInformationScreen(),

            // Widget for Tab 2
            Center(
              child: Text('This is Tab 2'),
            ),

            // Widget for Tab 3
            Center(
              child: Text('This is Tab 3'),
            ),
          ],
        ),
      ),
    );
  }
}
