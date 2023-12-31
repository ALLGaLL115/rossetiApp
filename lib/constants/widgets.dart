import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rosseti_second/constants/constants.dart';
import 'package:rosseti_second/ui/pages/status_page.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const ContinueButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(offset: Offset(0, 0.3), blurRadius: 0.11, spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(24)),
      child: FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shadowColor: Colors.black),
        onPressed: onPressed,
        child: Text(
          text,
          style: standart,
        ),
      ),
    );
  }
}

class UsersPicture extends StatelessWidget {
  const UsersPicture({
    super.key,
    required this.image,
    required this.assetHintPicture,
    required this.heroTag,
  });
  final String assetHintPicture;
  final Image? image;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (image != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HeroPage(
                    image: image!,
                    heroTag: heroTag,
                  )));
        }
      },
      child: SizedBox(
        height: 58,
        width: 91,
        child: Hero(
            tag: heroTag,
            child: image ??
                Image.asset(
                  assetHintPicture,
                  height: 50,
                )),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  final String heroTag;
  const HeroPage({
    super.key,
    required this.image,
    required this.heroTag,
  });

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(tag: heroTag, child: image),
      ),
    );
  }
}

class MainPageWidget extends StatelessWidget {
  final String text;
  final String assetImagePath;
  final VoidCallback onPressed;
  const MainPageWidget({
    super.key,
    required this.text,
    required this.assetImagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          surfaceTintColor: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetImagePath),
              Text(
                text,
                textAlign: TextAlign.center,
                style: standart,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 2),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  spreadRadius: 0.1,
                  color: Colors.grey,
                  blurRadius: 1,
                  offset: Offset(0, 1))
            ],
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.grey),
            border: InputBorder.none,
          ),
        ));
  }
}

class RoundedCameraButton extends StatelessWidget {
  final String assetImagePath;
  final VoidCallback onPressed;
  const RoundedCameraButton({
    super.key,
    required this.onPressed,
    required this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide.none,
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Image.asset(assetImagePath),
    );
  }
}

getActions({
  required BuildContext context,
}) {
  return <Widget>[
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () async {
            var user = Globals().user;

            if (user != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatusPage(
                  user: user,
                ),
              ));
            }
          },
          child: Image.asset(
            "assets/images/image 1.png",
            height: 34,
          ),
        ))
  ];
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: standart,
      ));
}

Future pickImage({required ImageSource imageSource}) async {
  final image = await ImagePicker().pickImage(source: imageSource);
  if (image == null) return;

  final imageTemporary = File(image.path);
  return imageTemporary;
}

Future pickVideo({required ImageSource imageSource}) async {
  final video = await ImagePicker().pickVideo(source: imageSource);
  if (video == null) return;

  File videoTemporary = File(video.path);
  return videoTemporary;
}
