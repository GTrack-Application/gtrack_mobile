import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gtrack_mobile_app/controllers/share/product_information/events_screen_controller.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/global/common/utils/app_dialogs.dart';
import 'package:gtrack_mobile_app/models/share/product_information/events_screen_model.dart';
import 'package:nb_utils/nb_utils.dart';

class EventsScreen extends StatefulWidget {
  final String gtin;
  final String codeType;
  const EventsScreen({Key? key, required this.gtin, required this.codeType})
      : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<bool> isMarked = [];
  List<EventsScreenModel> table = [];

  List<double> longitude = [];
  List<double> latitude = [];

  double currentLat = 0;
  double currentLong = 0;

  // markers
  Set<Marker> markers = {};

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        AppDialogs.loadingDialog(context);
        final gtin = (widget.codeType == "1D")
            ? widget.gtin
            : widget.gtin.substring(1, 14);
        EventsScreenController.getEventsData(gtin).then((value) {
          setState(() {
            isMarked = List.filled(value.length, true);
            table = value;
            latitude = value
                .map((e) => double.parse(e.itemGPSOnGoLat.toString()))
                .toList();
            longitude = value
                .map((e) => double.parse(e.itemGPSOnGoLon.toString()))
                .toList();

            currentLat = 24.7136;
            currentLong = 46.6753;

            // setting up markers
            markers = table.map((data) {
              return Marker(
                markerId: MarkerId(data.memberID.toString()),
                position: LatLng(
                  double.parse(data.itemGPSOnGoLat.toString()),
                  double.parse(data.itemGPSOnGoLon.toString()),
                ),
                // infoWindow: InfoWindow(
                //   snippet: data.locationNameAr.toString(),
                // ),
              );
            }).toSet();

            isLoaded = true;
          });
          AppDialogs.closeDialog();
        }).onError((error, stackTrace) {
          setState(() {
            isMarked = List.filled(0, false);
            table = [];
          });
          AppDialogs.closeDialog();
          toast(error.toString().replaceAll("Exception:", ""));
        });
      },
    );
  }

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    mapController.dispose();

    markers.clear();
    latitude.clear();
    longitude.clear();
    table.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded == false
          ? const SizedBox.shrink()
          : GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                // with current position using geolocator
                target: latitude.isEmpty
                    ? LatLng(currentLat, currentLong)
                    : LatLng(
                        latitude[0],
                        longitude[0],
                      ),
                zoom: 14,
              ),
              // each marker will connect to each other and will show the route to the next marker
              rotateGesturesEnabled: true,
              // lines on routes

              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: AppColors.green,
                  width: 5,
                  points: latitude.isEmpty
                      ? [
                          LatLng(currentLat, currentLong),
                          LatLng(currentLat, currentLong),
                        ]
                      : latitude
                          .asMap()
                          .map((index, value) => MapEntry(
                              index,
                              LatLng(
                                latitude[index],
                                longitude[index],
                              )))
                          .values
                          .toList(),
                ),
              },

              markers: markers,
              buildingsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
            ),
    );
  }
}