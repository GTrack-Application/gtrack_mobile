import 'package:flutter/material.dart';
import 'package:gtrack_mobile_app/constants/app_images.dart';
import 'package:gtrack_mobile_app/controllers/Receiving/supplier_receipt/GenerateSerialNumberforRecevingController.dart';
import 'package:gtrack_mobile_app/controllers/Receiving/supplier_receipt/InsertShipmentReceivedDataController.dart';
import 'package:gtrack_mobile_app/controllers/Receiving/supplier_receipt/UpdateStockMasterDataController.dart';
import 'package:gtrack_mobile_app/controllers/capture/Association/Transfer/RawMaterialsToWIP/GetSalesPickingListCLRMByAssignToUserAndVendorController.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/global/common/utils/app_dialogs.dart';
import 'package:gtrack_mobile_app/global/widgets/ElevatedButtonWidget.dart';
import 'package:gtrack_mobile_app/global/widgets/loading/loading_widget.dart';
import 'package:gtrack_mobile_app/global/widgets/text/text_widget.dart';
import 'package:gtrack_mobile_app/global/widgets/text_field/text_form_field_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

import 'shipment_dispatching_screen.dart';

// ignore: must_be_immutable
class SaveScreen extends StatefulWidget {
  String sHIPMENTID;
  String cONTAINERID;
  String aRRIVALWAREHOUSE;
  String iTEMNAME;
  String iTEMID;
  String pURCHID;
  String cLASSIFICATION;
  String sERIALNUM;
  String rCVDCONFIGID;
  String gTIN;
  String rZONE;
  String pALLETCODE;
  String bIN;
  String rEMARKS;
  num pOQTY;
  num rCVQTY;
  num rEMAININGQTY;
  String createdDateTime;
  double length;
  double width;
  double height;
  double weight;
  int totalRows;

  SaveScreen({
    Key? key,
    required this.sHIPMENTID,
    required this.cONTAINERID,
    required this.aRRIVALWAREHOUSE,
    required this.iTEMNAME,
    required this.iTEMID,
    required this.pURCHID,
    required this.cLASSIFICATION,
    required this.sERIALNUM,
    required this.rCVDCONFIGID,
    required this.gTIN,
    required this.rZONE,
    required this.pALLETCODE,
    required this.bIN,
    required this.rEMARKS,
    required this.pOQTY,
    required this.rCVQTY,
    required this.rEMAININGQTY,
    required this.createdDateTime,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.totalRows,
  }) : super(key: key);

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final TextEditingController _jobOrderNoController = TextEditingController();
  final TextEditingController _containerNoController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _serialNoController = TextEditingController();

  FocusNode firstFocusNode = FocusNode();
  FocusNode secondFocusNode = FocusNode();

  void method() {
    const LoadingWidget();
    FocusScope.of(context).unfocus();

    InsertShipmentReceivedDataController.insertShipmentData(
      widget.sHIPMENTID,
      widget.cONTAINERID,
      "",
      widget.iTEMNAME,
      widget.iTEMID,
      widget.pURCHID,
      widget.cLASSIFICATION,
      _serialNoController.text,
      dropdownValue,
      DateTime.now().toString(),
      widget.gTIN,
      widget.rZONE,
      DateTime.now().toString(),
      "",
      "",
      _remarksController.text,
      int.parse(widget.pOQTY.toString()),
      widget.length,
      widget.width,
      widget.height,
      widget.weight,
    ).then((value) {
      setState(() {
        serialNoList.add(_serialNoController.text);
        configList.add(dropdownValue);
        remarksList.add(_remarksController.text);

        _serialNoController.clear();
      });
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Serial Number already exists."),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _jobOrderNoController.text = widget.sHIPMENTID;
    _containerNoController.text = widget.cONTAINERID;
    _itemNameController.text = widget.iTEMNAME;
  }

  @override
  void dispose() {
    firstFocusNode.removeListener(() {});
    secondFocusNode.removeListener(() {});
    super.dispose();
  }

  String dropdownValue = 'G';
  List<String> dropdownList = [
    'G',
    'D',
    'DC',
    'MCI',
    'S',
  ];

  List<String> serialNoList = [];
  List<String> configList = [];
  List<String> remarksList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 20, top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            AppImages.delete,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      const TextWidget(
                        text: "JOB ORDER NO*",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _jobOrderNoController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        hintText: "Job Order No",
                        readOnly: true,
                      ),
                      const SizedBox(height: 10),
                      const TextWidget(
                        text: "CONTAINER NO*",
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: _containerNoController,
                        width: MediaQuery.of(context).size.width * 0.9,
                        hintText: "Container No",
                        readOnly: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: "Item Code:",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          TextWidget(
                            text: widget.iTEMID,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                TextWidget(
                                  text: "PO QTY*\n${widget.pOQTY}",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                TextWidget(
                                  text: "Received*\n$rCQTY",
                                  fontSize: 15,
                                  color: Colors.white,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                TextWidget(
                                  text: "CON",
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 10),
                                TextWidget(
                                  text: "1",
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Item Name",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _itemNameController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Item Name/Description",
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Remarks",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  controller: _remarksController,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter Remarks (User Input  )",
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "List of Item Config",
                  fontSize: 15,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.only(left: 20),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: dropdownList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const TextWidget(
                  text: "Enter Serial Number",
                  fontSize: 15,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: TextFormFieldWidget(
                  focusNode: secondFocusNode,
                  width: MediaQuery.of(context).size.width * 0.9,
                  hintText: "Enter/Scan Serial No.",
                  autofocus: false,
                  controller: _serialNoController,
                  onFieldSubmitted: (p0) {
                    if (rCQTY >= widget.pOQTY) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Sorry! The Remaining Quantity is Zero."),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    if (_serialNoController.text.isEmpty) {
                      FocusScope.of(context).unfocus();
                      return;
                    }

                    AppDialogs.loadingDialog(context);
                    FocusScope.of(context).unfocus();
                    InsertShipmentReceivedDataController.insertShipmentData(
                      widget.sHIPMENTID,
                      widget.cONTAINERID,
                      '',
                      widget.iTEMNAME,
                      widget.iTEMID,
                      widget.pURCHID,
                      widget.cLASSIFICATION,
                      _serialNoController.text,
                      dropdownValue,
                      DateTime.now().toString(),
                      widget.gTIN,
                      widget.rZONE,
                      DateTime.now().toString(),
                      "",
                      "",
                      _remarksController.text,
                      int.parse(widget.pOQTY.toString()),
                      widget.length,
                      widget.width,
                      widget.height,
                      widget.weight,
                    ).then((value) {
                      setState(() {
                        serialNoList.add(_serialNoController.text);
                        configList.add(dropdownValue);
                        remarksList.add(_remarksController.text);

                        rCQTY = rCQTY + 1;

                        _serialNoController.clear();
                        // focus back to serial no field
                      });
                      UpdateStockMasterDataController.insertShipmentData(
                          widget.iTEMID,
                          widget.length,
                          widget.width,
                          widget.height,
                          widget.weight);

                      RawMaterialsToWIPController.insertEPCISEvent(
                        "OBSERVE", // OBSERVE, ADD, DELETE
                        widget.totalRows,
                        "RECEIVING EVENT",
                        "Internal Transfer",
                        "Receiving",
                        "urn:epc:id:sgln:6285084.00002.1",
                        widget.sHIPMENTID,
                        widget.sHIPMENTID,
                      );

                      FocusScope.of(context).requestFocus(secondFocusNode);
                      AppDialogs.closeDialog();
                    }).onError((error, stackTrace) {
                      _serialNoController.clear();
                      FocusScope.of(context).requestFocus(secondFocusNode);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Serial Number already exists!"),
                        ),
                      );
                      AppDialogs.closeDialog();
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: ElevatedButtonWidget(
                  title: "Generate Serial No.",
                  fontSize: 18,
                  color: AppColors.pink.withOpacity(0.3),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  onPressed: () async {
                    GenerateSerialNumberforRecevingController.generateSerialNo(
                            widget.iTEMID)
                        .then(
                      (value) {
                        AppDialogs.loadingDialog(context);

                        FocusScope.of(context).unfocus();
                        InsertShipmentReceivedDataController.insertShipmentData(
                          widget.sHIPMENTID,
                          widget.cONTAINERID,
                          '',
                          widget.iTEMNAME,
                          widget.iTEMID,
                          widget.pURCHID,
                          widget.cLASSIFICATION,
                          value,
                          dropdownValue,
                          DateTime.now().toString(),
                          widget.gTIN,
                          widget.rZONE,
                          DateTime.now().toString(),
                          "",
                          "",
                          _remarksController.text,
                          int.parse(widget.pOQTY.toString()),
                          widget.length,
                          widget.width,
                          widget.height,
                          widget.weight,
                        ).then((val) {
                          setState(() {
                            serialNoList.add(value);
                            configList.add(dropdownValue);
                            remarksList.add(_remarksController.text);

                            rCQTY = rCQTY + 1;
                          });
                          UpdateStockMasterDataController.insertShipmentData(
                            widget.iTEMID,
                            widget.length,
                            widget.width,
                            widget.height,
                            widget.weight,
                          );

                          RawMaterialsToWIPController.insertEPCISEvent(
                            "OBSERVE", // OBSERVE, ADD, DELETE
                            widget.totalRows,
                            "RECEIVING EVENT",
                            "Internal Transfer",
                            "Receiving",
                            "urn:epc:id:sgln:6285084.00002.1",
                            widget.sHIPMENTID,
                            widget.sHIPMENTID,
                          );

                          AppDialogs.closeDialog();
                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Serial No. not generated!"),
                            ),
                          );
                          AppDialogs.closeDialog();
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.withOpacity(0.2)),
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.pink),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      columns: const [
                        DataColumn(
                            label: Expanded(
                          child: Text(
                            'SERIAL NO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                        DataColumn(
                            label: Text(
                          'CONFIG',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        DataColumn(
                          label: Text(
                            'Remarks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        serialNoList.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(
                                serialNoList[index],
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                dropdownValue,
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                remarksList[index],
                                style: TextStyle(
                                  color: Colors.blue[900]!,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Ionicons.arrow_back),
                  label: (const Text("Back")),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink,
                  ),
                ),
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
