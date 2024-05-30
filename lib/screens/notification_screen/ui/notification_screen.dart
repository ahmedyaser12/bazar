import 'package:book_shop/core/widget/custom_appBar.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/cache_helper.dart';
import '../../../services/api_services/end_points.dart';
import '../../../services/services_locator.dart';

class NotificationItemWidget extends StatefulWidget {
  const NotificationItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  final FirebaseService firebaseService = locator<FirebaseService>();
  List items = [];

  @override
  void initState() {
    getCartItems();
    super.initState();
  }

  getCartItems() async {
    final response = await firebaseService
        .getCartItems(CacheHelper().getData(key: ApiKey.id));
    setState(() {
      items = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        context: context,
        title: 'Notifications',
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: Card(child: Text("Header card"))),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              print("building item #$index");
              return ListTile(
                leading: Image.network(items[index]['cover']!,
                    width: 50, height: 50),
                title: Text(items[index]['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${items[index]['price']} EGP',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                trailing: Text('${items[index]['num']} items'),
              );
            },
          ),
          const SliverToBoxAdapter(child: Card(child: Text("Footer card"))),
        ],
      ),
    );
  }
}
