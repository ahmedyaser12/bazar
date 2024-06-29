import 'package:book_shop/screens/cart_screen/logic/card_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/styles.dart';
import '../../../../generated/l10n.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardScreenCubit, CardScreenState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: !context.read<CardScreenCubit>().isLocated
                      ? AppColors.redColor
                      : AppColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).address,
                      style: TextStyles.font18BlackBold(context),
                    ),
                    const SizedBox(height: 8.0),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                              color: AppColors.secondary),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: AppColors.primary,
                          ),
                        ),
                        title: context.read<CardScreenCubit>().addresses != null
                            ? Text(
                                context
                                        .read<CardScreenCubit>()
                                        .addresses![0]
                                        .locality ??
                                    S.of(context).no_address_available,
                                style: TextStyles.font15BlackMedium(context),
                              )
                            : Text(S.of(context).no_address_available,
                                style: TextStyles.font15BlackMedium(context)),
                        subtitle: context.read<CardScreenCubit>().addresses !=
                                null
                            ? Text(
                                '${context.read<CardScreenCubit>().addresses![0].street!.substring(0, context.read<CardScreenCubit>().addresses![0].street!.length - 11)},\n${context.read<CardScreenCubit>().addresses![0].administrativeArea}, ${context.read<CardScreenCubit>().addresses![0].country}',
                                style: TextStyles.font15BlackMedium(context))
                            : null,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          await context.read<CardScreenCubit>().getLocation();
                          //context.navigateTo(RouteName.MAP);
                        }),
                    state is LocationLoading
                        ? const LinearProgressIndicator()
                        : Container(),
                  ],
                ),
              ),
            ),
            context.read<CardScreenCubit>().isLocated == false
                ? Text(
                    S.of(context).please_choose_location,
                    style: TextStyles.font13grey500weight
                        .copyWith(color: AppColors.redColor, fontSize: 11),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
