import 'package:flutter/material.dart';

import '../models/item.dart';
import 'virtual_ar_screen.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item itemInfo;
  const ItemDetailsScreen({
    Key? key,
    required this.itemInfo,
  }) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.itemInfo.itemName ?? ''),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  VirtualArScreen(image: widget.itemInfo.itemImage ?? '')));
        },
        backgroundColor: Colors.pinkAccent,
        label: const Text('Try Virtualy'),
        icon: const Icon(
          Icons.mobile_screen_share_rounded,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.itemInfo.itemImage ?? ''),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  widget.itemInfo.itemName ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 6, right: 8),
                child: Text(
                  widget.itemInfo.itemDescription ?? '',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'U\$ ${widget.itemInfo.itemPrice}',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white70,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 250),
                child: Divider(
                  thickness: 2,
                  height: 1,
                  color: Colors.white70,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
