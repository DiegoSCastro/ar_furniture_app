import 'package:flutter/material.dart';

class DefaultUploadScreen extends StatelessWidget {
  final Function() captureImageWithCamera;
  final Function() chooseImageFromGallery;
  final bool isUploadingPhoto;
  const DefaultUploadScreen({
    Key? key,
    required this.captureImageWithCamera,
    required this.chooseImageFromGallery,
    this.isUploadingPhoto = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Upload New Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: isUploadingPhoto
            ? const CircularProgressIndicator()
            : InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        backgroundColor: Colors.grey[900],
                        title: const Text(
                          'Item Image',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              captureImageWithCamera();
                            },
                            child: const Text(
                              'Capture Image from Camera',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              chooseImageFromGallery();
                            },
                            child: const Text(
                              'Choose image from Gallery',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 200,
                      color: Colors.white,
                    ),
                    Text(
                      'Add New Item',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
