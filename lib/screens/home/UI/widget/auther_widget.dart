import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/screens/home/UI/widget/header_of_tops.dart';
import 'package:flutter/material.dart';

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        const Header(header: 'Authors'),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img_2.png'),
                        radius: 50,
                      ),
                      heightSpace(15),
                      Text(
                        'John Freeman',
                        style: TextStyles.font18BlackBold,
                      ),
                      heightSpace(5),
                      Text(
                        'Writer',
                        style: TextStyles.font16grey,
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
