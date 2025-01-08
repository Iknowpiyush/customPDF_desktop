import 'package:anosh_assignment/constants/colors.dart';
import 'package:anosh_assignment/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/font_sizes.dart';
import '../viewmodels/invoice_view.dart';

class HomepageView extends ConsumerWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Dimensions.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimensions.smallPadding),
              child: const Icon(Icons.close),
            )
          ],
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              fontSize: FontSizes.medium, color: AppColors.textColor),
          title: const Text(
            'FLUTTER DESKTOP INVOICE APPLICATION',
          )),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
            elevation: WidgetStateProperty.all(5),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ))
          ),
          onPressed: () async {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => InvoiceView()));
          },
          child: Padding(
            padding: EdgeInsets.all(Dimensions.mediumPadding),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PDF PREVIEW  ',
                  style: TextStyle(
                      color: AppColors.textColorW, fontSize: FontSizes.large),
                ),
                Icon(
                  Icons.print_outlined,
                  color: AppColors.textColorW,
                  size: ShapeSizes.xxxLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
