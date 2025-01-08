import 'package:anosh_assignment/constants/colors.dart';
import 'package:anosh_assignment/constants/dimensions.dart';
import 'package:anosh_assignment/constants/font_sizes.dart';
import 'package:anosh_assignment/services/pdf_service1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import '../provideres/invoice_provider.dart';
import '../services/pdf_service.dart';
import '../services/save_pdf.dart';
import '../widgets/custom_checkbox.dart';
import '../widgets/dropdown_menu.dart';
const List<String> dropdownMenuEntries = ['A4', 'A3', 'A2', 'A1'];

class InvoiceView extends ConsumerWidget {
  InvoiceView({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Dimensions.init(context);
    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedValue = ref.watch(dropdownSelectionProvider);
    final checkboxState = ref.watch(checkboxStateProvider);
    final pdfState = ref.watch(pdfProvider);


    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Custom rounded corners
        ),
        color: AppColors.cardColorW,
        margin: EdgeInsets.all(Dimensions.xxlargePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRINT PREVIEW',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(height: 8),
                              Text('Customize and optimize your Print.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Printable templates',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.help_outline_rounded,
                            size: Dimensions.smallIcon,)
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(2, (index) {
                        return GestureDetector(
                          onTap: () {
                            ref.read(selectedIndexProvider.notifier).state = index;
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.smallPadding),
                            height: Dimensions.height * 2.1,
                            width: Dimensions.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.blueAccent
                                    : Colors.grey,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Center(
                                  child: Text(
                                    'Template ${index + 1}',
                                    style: const TextStyle(
                                      color:  Colors.black,
                                      fontSize: FontSizes.small,
                                    ),
                                  ),
                                ),
                                if (selectedIndex == index)
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: Dimensions.smallIcon,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Print Size',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.help_outline_rounded,
                              size: Dimensions.smallIcon,)
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomDropdownMenu(
                          dropdownMenuEntries: dropdownMenuEntries,
                          selectedValue: selectedValue,
                          onChanged: (String? newValue) {
                          ref.read(dropdownSelectionProvider.notifier).state = newValue;
                      },
                    ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheckbox(
                              label: 'Email address',
                              value: checkboxState.isEmailChecked,
                              onChanged: (bool? value) {
                                ref.read(checkboxStateProvider.notifier).toggleEmail(value ?? false);

                              },
                            ),
                            CustomCheckbox(
                              label: 'Show Invoice',
                              value: checkboxState.isShowValueChecked,
                              onChanged: (bool? value) {
                                ref.read(checkboxStateProvider.notifier).toggleShowValue(value ?? false);
                              },
                            ),
                            CustomCheckbox(
                              label: 'Add Watermark',
                              value: checkboxState.isWebsiteChecked,
                              onChanged: (bool? value) {
                                ref.read(checkboxStateProvider.notifier).toggleWebsite(value ?? false);
                              },
                            ),
                            CustomCheckbox(
                              label: 'Terms and Conditions',
                              value: checkboxState.isTermsChecked,
                              onChanged: (bool? value) {
                                ref.read(checkboxStateProvider.notifier).toggleTerms(value ?? false);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.width * .6),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
                            elevation: WidgetStateProperty.all(5),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )
                            )
                          ),
                            onPressed: () async {
                              final pdfState = ref.watch(pdfProvider);
                              if (pdfState is AsyncLoading) return;

                              await ref.read(pdfProvider.notifier).generateAndOpenPdf(
                                showMail: checkboxState.isEmailChecked,
                                showWeb: checkboxState.isWebsiteChecked,
                                showInvoice: checkboxState.isShowValueChecked,
                                showTerm: checkboxState.isTermsChecked,
                                selectedIndex: selectedIndex,

                              );

                              final newPdfState = ref.watch(pdfProvider);
                              newPdfState.when(
                                data: (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('PDF saved successfully!')),
                                  );
                                },
                                loading: () {},
                                error: (error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Something went wrong!')),
                                  );
                                },
                              );
                            },
                          child: pdfState is AsyncLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Padding(
                                  padding: EdgeInsets.all(Dimensions.xsmallPadding),
                                  child: const Text('PRINT PDF  ',
                                    style: TextStyle(
                                        color: AppColors.textColorW,
                                        fontSize: FontSizes.medium1
                                    ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * .85,
                          width: Dimensions.width * 5,
                          child: PdfPreview(
                            useActions: false,
                            scrollViewDecoration: const BoxDecoration(
                              color: Colors.white
                            ),

                            loadingWidget: const CircularProgressIndicator(color: Colors.blue,),
                            previewPageMargin: const EdgeInsets.all(12),
                            pdfPreviewPageDecoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 3)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7)
                            ),
                            build: (format) =>
                                selectedIndex == 1 ?
                                PdfService1.generatePdf(
                                  showMail: checkboxState.isEmailChecked,
                                  showInvoice: checkboxState.isShowValueChecked,
                                  showTerm: checkboxState.isTermsChecked,
                                  showWeb: checkboxState.isWebsiteChecked,
                                ) :
                                PdfService.generatePdf(
                                    showMail: checkboxState.isEmailChecked,
                                    showInvoice: checkboxState.isShowValueChecked,
                                    showTerm: checkboxState.isTermsChecked,
                                    showWeb: checkboxState.isWebsiteChecked,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
