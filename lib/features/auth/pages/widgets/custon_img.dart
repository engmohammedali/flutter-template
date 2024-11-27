import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:template/core/themes/app_colors.dart';
import 'package:template/features/auth/providers/register_provider.dart';

class CustonImg extends ConsumerStatefulWidget {
  final String img;

  const CustonImg({super.key, required this.img});

  @override
  ConsumerState<CustonImg> createState() => _CustonImgState();
}

class _CustonImgState extends ConsumerState<CustonImg> {
  String? imgName;
  Uint8List? imgPath;
  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        ref.watch(registerProvider.notifier).uploadimgPath(imgPath);
        imgName = basename(pickedImg.path);
        int random = Random().nextInt(9999999);
        imgName = "$random${imgName}";
        print(imgName);
      } else {
        print('NO img selected');
      }
    } catch (e) {
      print('Error => $e');
    }
  }

  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(15),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
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
                  uploadImage2Screen(ImageSource.gallery);
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
    final registerState = ref.watch(registerProvider);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 30),
      child: Stack(
        children: [
          !registerState.isUploadImg
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
                    backgroundImage: MemoryImage(registerState.imgPath!),
                  ),
                ),
          Positioned(
            right: -8,
            top: -2,
            child: IconButton(
              onPressed: () {
                showmodel();
              },
              icon: const Icon(
                Icons.add_a_photo,
                size: 20,
              ),
              color: AppColors.ligtGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}
