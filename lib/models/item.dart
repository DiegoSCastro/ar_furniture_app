import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String? itemID;
  final String? itemName;
  final String? itemDescription;
  final String? itemImage;
  final String? sellerName;
  final String? sellerPhone;
  final String? itemPrice;
  final Timestamp? publishDate;
  final String? status;

  Item({
    this.itemID,
    this.itemName,
    this.itemDescription,
    this.itemImage,
    this.sellerName,
    this.sellerPhone,
    this.itemPrice,
    this.publishDate,
    this.status,
  });

  Item copyWith({
    String? itemID,
    String? itemName,
    String? itemDescription,
    String? itemImage,
    String? sellerName,
    String? sellerPhone,
    String? itemPrice,
    Timestamp? publishDate,
    String? status,
  }) {
    return Item(
      itemID: itemID ?? this.itemID,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      itemImage: itemImage ?? this.itemImage,
      sellerName: sellerName ?? this.sellerName,
      sellerPhone: sellerPhone ?? this.sellerPhone,
      itemPrice: itemPrice ?? this.itemPrice,
      publishDate: publishDate ?? this.publishDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'itemID': itemID,
      'itemName': itemName,
      'itemDescription': itemDescription,
      'itemImage': itemImage,
      'sellerName': sellerName,
      'sellerPhone': sellerPhone,
      'itemPrice': itemPrice,
      'publishDate': publishDate,
      'status': status,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemID: map['itemID'] != null ? map['itemID'] as String : null,
      itemName: map['itemName'] != null ? map['itemName'] as String : null,
      itemDescription: map['itemDescription'] != null
          ? map['itemDescription'] as String
          : null,
      itemImage: map['itemImage'] != null ? map['itemImage'] as String : null,
      sellerName:
          map['sellerName'] != null ? map['sellerName'] as String : null,
      sellerPhone:
          map['sellerPhone'] != null ? map['sellerPhone'] as String : null,
      itemPrice: map['itemPrice'] != null
          ? (map['itemPrice'] as String).replaceAll(',', '.')
          : null,
      publishDate:
          map['publishDate'] != null ? map['publishDate'] as Timestamp : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item('
        '\nitemID: $itemID, '
        '\nitemName: $itemName, '
        '\nitemDescription: $itemDescription, '
        '\nitemImage: $itemImage, '
        '\nsellerName: $sellerName, '
        '\nsellerPhone: $sellerPhone, '
        '\nitemPrice: $itemPrice, '
        '\npublishDate: $publishDate, '
        '\nstatus: $status'
        '\n)';
  }
}
