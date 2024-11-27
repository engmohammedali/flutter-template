import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:template/core/themes/app_colors.dart';
class PhoneNumberInput extends StatelessWidget {
  final TextEditingController controllerPhone;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  const PhoneNumberInput({
    super.key,
    required this.controllerPhone,
    this.focusNode,
    this.onFieldSubmitted,
  });
  @override
  Widget build(BuildContext context) {
    final String initialCountry = 'SY';
    PhoneNumber number = PhoneNumber(isoCode: initialCountry);
    return InternationalPhoneNumberInput(
      onFieldSubmitted: onFieldSubmitted,
      // countries: arabCountries,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      searchBoxDecoration: InputDecoration(),
      inputDecoration: InputDecoration(
        contentPadding: EdgeInsets.all(18),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.ligtGrayColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.blueColor)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(width: 2, color: AppColors.ligtGrayColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
      ),
      hintText: 'phone',
      initialValue: number,
      onInputChanged: (number) {
        print(number);
      },
      textFieldController: controllerPhone,
      selectorConfig: SelectorConfig(
        useEmoji: true,
        leadingPadding: 16,
        setSelectorButtonAsPrefixIcon: true,
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        countryComparator: (a, b) {
          final isArabicA = arabCountries.contains(
            a.alpha2Code,
          );
          final isArabicB = arabCountries.contains(
            b.alpha2Code,
          );
          if (isArabicA && !isArabicB) {
            return -1; // a comes first
          } else if (!isArabicA && isArabicB) {
            return 1; // b comes first
          } else {
            // Sort alphabetically by the country name if both are Arabic or both are non-Arabic
            return a.name!.compareTo(b.name!);
          }
        },
      ),
    );
  }
}
const List<String> arabCountries = [
  'SA', // السعودية
  'EG', // مصر
  'AE', // الإمارات
  'QA', // قطر
  'KW', // الكويت
  'OM', // عمان
  'BH', // البحرين
  'JO', // الأردن
  'LY', // ليبيا
  'SD', // السودان
  'SY', // سوريا
  'DZ', // الجزائر
  'MA', // المغرب
  'TN', // تونس
  'IQ', // العراق
  'YE', // اليمن
  'LB', // لبنان
  'PS', // فلسطين
];













































// class PhoneNumberInput extends StatefulWidget {
//   final TextEditingController controllerPhone;
//   final FocusNode? focusNode;
//   const PhoneNumberInput(
//       {super.key, required this.controllerPhone, this.focusNode});

//   @override
//   State<PhoneNumberInput> createState() => _PhoneNumberInputState();
// }

// class _PhoneNumberInputState extends State<PhoneNumberInput> {
//   List<String> arabCountries = [
//     'SA', // السعودية
//     'EG', // مصر
//     'AE', // الإمارات
//     'QA', // قطر
//     'KW', // الكويت
//     'OM', // عمان
//     'BH', // البحرين
//     'JO', // الأردن
//     'LY', // ليبيا
//     'SD', // السودان
//     'SY', // سوريا
//     'DZ', // الجزائر
//     'MA', // المغرب
//     'TN', // تونس
//     'IQ', // العراق
//     'YE', // اليمن
//     'LB', // لبنان
//     'PS', // فلسطين
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final String initialCountry = 'SY';
//     PhoneNumber number = PhoneNumber(isoCode: initialCountry);
//     return InternationalPhoneNumberInput(
//       countries: arabCountries,
//       focusNode: widget.focusNode,
//       keyboardType: TextInputType.number,
//       searchBoxDecoration: InputDecoration(),
//       inputDecoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//           color: AppColors.ligtGrayColor,
//         )),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide(color: AppColors.blueColor)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(width: 2, color: AppColors.ligtGrayColor),
//         ),
//       ),
//       hintText: 'phone',
//       initialValue: number,
//       onInputChanged: (number) {
//         print(number);
//       },
//       selectorConfig:
//           SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
//       textFieldController: widget.controllerPhone,
//     );
//   }
// }

// // class PhoneNumberInput extends StatelessWidget {
// //   final TextEditingController controllerPhone;
// //   final FocusNode? focusNode;
// //   final void Function(String)? onFieldSubmitted;
// //   const PhoneNumberInput({
// //     super.key,
// //     required this.controllerPhone,
// //     this.focusNode,
// //     this.onFieldSubmitted,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     final String initialCountry = 'SY';
// //     PhoneNumber number = PhoneNumber(isoCode: initialCountry);
// //     return InternationalPhoneNumberInput(
// //       onFieldSubmitted: onFieldSubmitted,
// //       // countries: arabCountries,
// //       focusNode: focusNode,
// //       keyboardType: TextInputType.number,
// //       searchBoxDecoration: InputDecoration(),
// //       inputDecoration: InputDecoration(
// //         contentPadding: EdgeInsets.all(18),
// //         enabledBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(16),
// //             borderSide: BorderSide(
// //               color: AppColors.ligtGrayColor,
// //             )),
// //         focusedBorder: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(16),
// //             borderSide: BorderSide(color: AppColors.blueColor)),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(16),
// //           borderSide: BorderSide(width: 2, color: AppColors.ligtGrayColor),
// //         ),
// //         errorBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(16),
// //           borderSide: BorderSide(
// //             width: 1,
// //             color: Theme.of(context).colorScheme.onError,
// //           ),
// //         ),
// //       ),
// //       hintText: 'phone',
// //       initialValue: number,
// //       onInputChanged: (number) {
// //         print(number);
// //       },
// //       textFieldController: controllerPhone,
// //       selectorConfig: SelectorConfig(
// //         useEmoji: true,
// //         leadingPadding: 16,
// //         setSelectorButtonAsPrefixIcon: true,
// //         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
// //         countryComparator: (a, b) {
// //           final isArabicA = arabCountries.contains(
// //             a.alpha2Code,
// //           );
// //           final isArabicB = arabCountries.contains(
// //             b.alpha2Code,
// //           );

// //           if (isArabicA && !isArabicB) {
// //             return -1; // a comes first
// //           } else if (!isArabicA && isArabicB) {
// //             return 1; // b comes first
// //           } else {
// //             // Sort alphabetically by the country name if both are Arabic or both are non-Arabic
// //             return a.name!.compareTo(b.name!);
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

