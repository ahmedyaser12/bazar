import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/core/widget/app_buttons.dart';
import 'package:book_shop/screens/profile_screen/data/user_model.dart';
import 'package:book_shop/screens/profile_screen/logic/profile_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widget/add_image.dart';
import '../../../core/widget/text_field.dart';

class MyAccountScreen extends StatelessWidget {
  final UserModel userModel;

  const MyAccountScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Account',style: TextStyles.font18BlackBold(context),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ProfileScreenCubit, ProfileScreenState>(
          listener: (context, state) {
            if (state is UpdateLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  // Prevents the dialog from being dismissed
                  builder: (BuildContext context) {
                    return const Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text("Loading..."),
                          ],
                        ),
                      ),
                    );
                  });
            }
            if (state is UpdateSuccess) {
              showAcceptDialog(context, state.success);
            }
            if (state is UpdateFailure) {
              showAlertDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                PickImageWidget(
                  oldImage: userModel.user!.profilePic,
                  inProfile: true,
                ),
                TextButton(
                  onPressed: () {
                    ImagePicker().pickImage(source: ImageSource.gallery).then(
                        (value) => context
                            .read<ProfileScreenCubit>() 
                            .uploadProfilePic(value!));
                  },
                  child: Text('Change Picture',
                      style: TextStyle(color: AppColors.primary)),
                ),
                heightSpace(24),
                FormTextFieldItem(hint: 'entre your Name',
                  name: 'Name',
                  controller: context.read<ProfileScreenCubit>().nameController,
                ),
                heightSpace(16),
                FormTextFieldItem(hint: 'entre your number',
                  keyboardType: TextInputType.phone,
                  lines: 11,
                  name: 'phone',
                  controller:
                      context.read<ProfileScreenCubit>().phoneController,
                ),
                heightSpace(32),
                primaryButton(title: 'Save Changes', borderRadius: 50)
                    .onTap(() async {
                  await context.read<ProfileScreenCubit>().updateUser();
                  if (context.mounted) {
                    context.pop();
                  }
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
