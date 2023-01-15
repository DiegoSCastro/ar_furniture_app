import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../repositories/background_remove_repository.dart';
import '../../widgets/upload_text_field.dart';
import 'default_upload_screen.dart';

class ItemsUploadScreen extends StatefulWidget {
  const ItemsUploadScreen({Key? key}) : super(key: key);

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  Uint8List? imageFileUint8List;
  bool isUploadingForm = false;
  bool isUploadingPhoto = false;
  String downloadUrlOfUploadedImage = '';

  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerPhoneController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  Future<void> captureImageWithCamera() async {
    Navigator.of(context).pop();
    setState(() {
      isUploadingPhoto = true;
    });
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove background
        // make image transparent
        imageFileUint8List =
            await BackgroundRemoveRepository.removeImageBackgroundApi(
                imagePath);

        setState(() {
          imageFileUint8List;
        });
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error uploading image', backgroundColor: Colors.red);
      debugPrint(e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    } finally {
      setState(() {
        isUploadingPhoto = false;
      });
    }
  }

  Future<void> chooseImageFromGallery() async {
    Navigator.of(context).pop();
    try {
      setState(() {
        isUploadingPhoto = true;
      });
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // remove background
        // make image transparent
        imageFileUint8List =
            await BackgroundRemoveRepository.removeImageBackgroundApi(
                imagePath);

        setState(() {
          imageFileUint8List;
        });
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error uploading image', backgroundColor: Colors.red);

      debugPrint(e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    } finally {
      setState(() {
        isUploadingPhoto = false;
      });
    }
  }

  Future<void> validateFormAndUpload() async {
    if (imageFileUint8List != null) {
      if (sellerNameController.text.isNotEmpty &&
          sellerPhoneController.text.isNotEmpty &&
          itemNameController.text.isNotEmpty &&
          itemDescriptionController.text.isNotEmpty &&
          itemPriceController.text.isNotEmpty) {
        setState(() {
          isUploadingForm = true;
        });
        //upload image to cloud fireStorage
        String imageUniqueName =
            DateTime.now().millisecondsSinceEpoch.toString();
        fire_storage.Reference firebaseStorageRef = fire_storage
            .FirebaseStorage.instance
            .ref()
            .child('Items Images')
            .child(imageUniqueName);

        fire_storage.UploadTask uploadTaskImageFile =
            firebaseStorageRef.putData(imageFileUint8List!);
        fire_storage.TaskSnapshot taskSnapshot =
            await uploadTaskImageFile.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((imageDownloadUrl) {
          downloadUrlOfUploadedImage = imageDownloadUrl;
        });
        //save item info to fireStore
        saveItemInfoToFireStore();
      } else {
        Fluttertoast.showToast(
          msg: 'Please complete upload form. Every field is mandatory',
        );
      }
    } else {
      Fluttertoast.showToast(msg: 'Please select image file.');
    }
  }

  saveItemInfoToFireStore() {
    String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance.collection('items').doc(itemUniqueId).set({
      'itemID': itemUniqueId,
      'itemName': itemNameController.text,
      'itemDescription': itemDescriptionController.text,
      'itemImage': downloadUrlOfUploadedImage,
      'sellerName': sellerNameController.text,
      'sellerPhone': sellerPhoneController.text,
      'itemPrice': itemPriceController.text,
      'publishDate': DateTime.now(),
      'status': 'available',
    });
    Fluttertoast.showToast(msg: 'Item Upload Successfully');
    setState(() {
      isUploadingForm = false;
      imageFileUint8List = null;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (imageFileUint8List == null) {
      return DefaultUploadScreen(
        captureImageWithCamera: captureImageWithCamera,
        chooseImageFromGallery: chooseImageFromGallery,
        isUploadingPhoto: isUploadingPhoto,
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text('Upload New Item'),
          actions: [
            IconButton(
              onPressed: () {
                if (!isUploadingForm) {
                  validateFormAndUpload();
                }
              },
              icon: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            isUploadingForm == true
                ? const LinearProgressIndicator(
                    color: Colors.purpleAccent,
                  )
                : Container(),
            SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: imageFileUint8List != null
                    ? Image.memory(
                        imageFileUint8List ?? Uint8List(0),
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 40,
                      ),
              ),
            ),
            const Divider(
              color: Colors.white70,
              thickness: 2,
            ),
            UploadTextField(
              icon: Icons.person_pin_rounded,
              controller: sellerNameController,
              hintText: 'seller name',
            ),
            const Divider(
              color: Colors.white70,
              thickness: 1,
            ),
            UploadTextField(
              icon: Icons.phone_iphone_rounded,
              controller: sellerPhoneController,
              hintText: 'seller phone',
            ),
            const Divider(
              color: Colors.white70,
              thickness: 1,
            ),
            UploadTextField(
              icon: Icons.title,
              controller: itemNameController,
              hintText: 'item name',
            ),
            const Divider(
              color: Colors.white70,
              thickness: 1,
            ),
            UploadTextField(
              icon: Icons.description,
              controller: itemDescriptionController,
              hintText: 'item description',
            ),
            const Divider(
              color: Colors.white70,
              thickness: 1,
            ),
            UploadTextField(
              icon: Icons.price_change,
              controller: itemPriceController,
              hintText: 'item price',
            ),
            const Divider(
              color: Colors.white70,
              thickness: 1,
            ),
          ],
        ),
      );
    }
  }
}
