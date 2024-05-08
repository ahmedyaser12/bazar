import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';

import '../../../../core/helper/location_helper.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  Position? position;
  bool isLoading = false;
  List<geo.Placemark>? addresses;

  @override
  void initState() {
    print(addresses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Address:',
              style: TextStyles.font18BlackBold,
            ),
            const SizedBox(height: 8.0),
            ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: AppColors.secondary),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: AppColors.primary,
                  ),
                ),
                title: addresses != null
                    ? Text(
                        addresses![0].locality ?? 'No address available',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const Text('No address available'),
                subtitle: addresses != null
                    ? Text(
                        '${addresses![0].street!.substring(0, addresses![0].street!.length - 11)},\n${addresses![0].administrativeArea}, ${addresses![0].country}',
                      )
                    : null,
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await _getLocation();
                  setState(() {
                    isLoading = false;
                  });
                }),
            isLoading ? const LinearProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Future<dynamic> _getLocation() async {
    await getMyCurrentLocation();
    final addresses = await geo.placemarkFromCoordinates(
        position!.latitude, position!.longitude);

    if (addresses.isNotEmpty) {
      this.addresses = addresses;
    } else {
      return 'No address available';
    }
  }
}
