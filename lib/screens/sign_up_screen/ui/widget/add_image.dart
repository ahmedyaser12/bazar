import 'dart:io';

import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: 130,
          height: 130,
          child: context.read<SignUpCubit>().pickImage == null
              ? CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: const AssetImage("assets/images/img_2.png"),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                ImagePicker()
                                    .pickImage(source: ImageSource.gallery)
                                    .then((value) => context
                                        .read<SignUpCubit>()
                                        .uploadProfilePic(value!));
                              },
                              child: const Icon(
                                Icons.camera_alt_sharp,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundImage: FileImage(
                      File(context.read<SignUpCubit>().pickImage!.path)),
                ),
        );
      },
    );
  }
}
