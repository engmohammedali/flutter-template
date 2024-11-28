import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:template/core/themes/app_colors.dart';

class CustonImg extends StatefulWidget {
  final String img;
  final void Function(Uint8List? imgData, String? imgName) getImgData;
  const CustonImg({super.key, required this.img, required this.getImgData});

  @override
  State<CustonImg> createState() => _CustonImgState();
}

class _CustonImgState extends State<CustonImg> {
  bool isUploadImg = false;

  String? imgName;

  Uint8List? imgData;

  uploadImage2Screen({
    required ImageSource source,
    required BuildContext context,
  }) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);

    try {
      if (pickedImg != null) {
        imgData = await pickedImg.readAsBytes();
        imgName = basename(pickedImg.path);
        int random = Random().nextInt(9999999);
        imgName = "$random$imgName";
        setState(() {
          isUploadImg = true;
          widget.getImgData(imgData, imgName);
        });
      } else {
        print('NO img selected');
      }
    } catch (e) {
      print('Error => $e');
    }
  }

  showmodel({
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(
                      source: ImageSource.camera, context: context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt, size: 30, color: Colors.black),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(
                    source: ImageSource.gallery,
                    context: context,
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.photo, size: 30, color: Colors.black),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 30),
      child: Stack(
        children: [
          !isUploadImg
              ? CircleAvatar(
                  radius: 73,
                  backgroundColor: AppColors.blueColor,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 225, 225, 225),
                    radius: 71,
                    backgroundImage: AssetImage(widget.img),
                  ),
                )
              : CircleAvatar(
                  radius: 73,
                  backgroundColor: AppColors.blueColor,
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 225, 225, 225),
                    radius: 71,
                    backgroundImage: MemoryImage(imgData!),
                  ),
                ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {
                showmodel(context: context);
              },
              icon: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.add_a_photo,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
