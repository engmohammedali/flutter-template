import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:template/core/themes/app_colors.dart';

class PhoneNumberInput extends StatefulWidget {
  final TextEditingController controllerPhone;
  final FocusNode? focusNode;
  const PhoneNumberInput(
      {super.key, required this.controllerPhone, this.focusNode});

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  List<String> arabCountries = [
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
    'PS', // فلسطين
  ];
  @override
  Widget build(BuildContext context) {
    final String initialCountry = 'SY';
    PhoneNumber number = PhoneNumber(isoCode: initialCountry);
    return InternationalPhoneNumberInput(
      countries: arabCountries,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.number,
      searchBoxDecoration: InputDecoration(),
      inputDecoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
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
      ),
      hintText: 'phone',
      initialValue: number,
      onInputChanged: (number) {
        print(number);
      },
      selectorConfig:
          SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
      textFieldController: widget.controllerPhone,
    );
  }
}
