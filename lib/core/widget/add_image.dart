import 'dart:io';

import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:book_shop/screens/sign_up_screen/logic/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  final String? oldImage;
  final bool inProfile;

  const PickImageWidget({
    super.key,
    this.oldImage,
    required this.inProfile,
  });

  @override
  Widget build(BuildContext context) {
    return !inProfile
        ? BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SizedBox(
                width: 130,
                height: 130,
                child: context.read<SignUpCubit>().pickImage == null
                    ? CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            const AssetImage('assets/images/avatar.png'),
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
                                    color: AppColors.primary,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery)
                                          .then((value) => context
                                              .read<SignUpCubit>()
                                              .uploadProfilePic(value!));
                                    },
                                    child: const Icon(
                                      Icons.camera,
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
          )
        : BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SizedBox(
                width: 130,
                height: 130,
                child: context.read<ProfileScreenCubit>().updateImage == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: NetworkImage(oldImage!),
                      )
                    : CircleAvatar(
                        radius: 90,
                        backgroundImage: FileImage(File(context
                            .read<ProfileScreenCubit>()
                            .updateImage!
                            .path)),
                      ),
              );
            },
          );
  }
}
