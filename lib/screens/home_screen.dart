import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/item_design_widget.dart';
import 'item_upload/items_upload_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Furniture App',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ItemsUploadScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('items')
            .orderBy(
              'publishDate',
              descending: true,
            )
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length ?? 0,
              itemBuilder: (context, index) {
                Item item = Item.fromMap(
                    snapshot.data.docs[index].data() as Map<String, dynamic>);

                return ItemDesignWidget(itemInfo: item);
              },
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'Data is not available',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
