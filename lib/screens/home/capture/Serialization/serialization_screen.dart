import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_mobile_app/constants/app_urls.dart';
import 'package:gtrack_mobile_app/cubit/capture/capture_cubit.dart';
import 'package:gtrack_mobile_app/global/common/colors/app_colors.dart';
import 'package:gtrack_mobile_app/global/common/utils/app_navigator.dart';
import 'package:gtrack_mobile_app/screens/home/capture/Serialization/serialization_gtin_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SerializationScreen extends StatefulWidget {
  const SerializationScreen({super.key});

  @override
  State<SerializationScreen> createState() => _SerializationScreenState();
}

class _SerializationScreenState extends State<SerializationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Serialization"),
        backgroundColor: AppColors.pink,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            10.height,
            _buildSerializationList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextField(
              controller: CaptureCubit.get(context).gtin,
              onSubmitted: (value) {
                CaptureCubit.get(context).getGtinProducts();
              },
              decoration: InputDecoration(
                hintText: 'Enter GTIN',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: AppColors.pink,
          foregroundColor: AppColors.white,
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              CaptureCubit.get(context).getGtinProducts();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSerializationList(BuildContext context) {
    return Expanded(
      flex: 4,
      child:
          BlocConsumer<CaptureCubit, CaptureState>(listener: (context, state) {
        if (state is CaptureGetGtinProductsSuccess) {
          CaptureCubit.get(context).gtinProducts.addAll(state.data);
        }
      }, builder: (context, state) {
        if (state is CaptureGetGtinProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CaptureGetGtinProductsError) {
          return Center(child: Text(state.message));
        } else if (state is CaptureGetGtinProductsEmpty) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
            ),
            child: Center(
              child: Text(
                "No data found with ${CaptureCubit.get(context).gtin.text} GTIN",
              ),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            CaptureCubit.get(context).getGtinProducts();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  width: double.infinity,
                  color: AppColors.pink,
                  child: const Text(
                    "List of GTIN",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        onTap: () {
                          AppNavigator.goToPage(
                            context: context,
                            screen: SerializationGtinScreen(
                              gtinModel:
                                  CaptureCubit.get(context).gtinProducts[index],
                            ),
                          );
                        },
                        title: Text(
                          CaptureCubit.get(context)
                                  .gtinProducts[index]
                                  .productnameenglish ??
                              "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          CaptureCubit.get(context)
                                  .gtinProducts[index]
                                  .barcode ??
                              "",
                          style: const TextStyle(fontSize: 13),
                        ),
                        leading: Hero(
                          tag: CaptureCubit.get(context)
                                  .gtinProducts[index]
                                  .id ??
                              "",
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppUrls.baseUrlWith3093}${CaptureCubit.get(context).gtinProducts[index].frontImage?.replaceAll(RegExp(r'^/+'), '').replaceAll("\\", "/") ?? ''}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_outlined),
                            ),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            // AppNavigator.goToPage(
                            //   context: context,
                            //   screen: GTINDetailsScreen(
                            //     employees: CaptureCubit.get(context).gtinProducts[index],
                            //   ),
                            // );
                          },
                          child: Image.asset("assets/icons/view.png"),
                        ),
                      ),
                    ),
                    itemCount: CaptureCubit.get(context).gtinProducts.length,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
