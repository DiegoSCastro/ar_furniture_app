import 'package:flutter/material.dart';

import '../models/item.dart';
import '../screens/item_details_screen.dart';

class ItemDesignWidget extends StatefulWidget {
  final Item itemInfo;
  const ItemDesignWidget({
    Key? key,
    required this.itemInfo,
  }) : super(key: key);

  @override
  State<ItemDesignWidget> createState() => _ItemDesignWidgetState();
}

class _ItemDesignWidgetState extends State<ItemDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(itemInfo: widget.itemInfo),
          ),
        );
      },
      splashColor: Colors.purple,
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 190,
        width: double.infinity,
        child: Row(
          children: [
            Image.network(
              widget.itemInfo.itemImage ?? '',
              width: 140,
              height: 140,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: Text(
                      widget.itemInfo.itemName ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      widget.itemInfo.sellerName ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //show discount badge
                  Row(
                    children: [
                      // 50% OFF badge
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.pink,
                        ),
                        alignment: Alignment.topLeft,
                        width: 40,
                        height: 44,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '50%',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'OFF',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Original Price: U\$',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                '${double.parse(widget.itemInfo.itemPrice ?? '0') * 2}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'New Price: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                widget.itemInfo.itemPrice ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    height: 4,
                    color: Colors.white70,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
