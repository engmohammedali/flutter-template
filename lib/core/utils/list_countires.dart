import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/providers/language/language_provider.dart';

class ListCountires extends ConsumerStatefulWidget {
  const ListCountires({super.key});
  @override
  ConsumerState<ListCountires> createState() => _ListCountiresState();
}

class _ListCountiresState extends ConsumerState<ListCountires> {
  String? curintCountry;
  final Map<String, String> _languages = {
    'ar': 'العربية 🇸🇦',
    'en': 'English 🇺🇸',
  };
  @override
  void initState() {
    curintCountry = ref.read(languageProvider).languageCode;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<String>(
        underline: SizedBox.shrink(),
        hint: Text('language'),
        icon: Icon(Icons.language_rounded),
        // value: curintCountry,
        items: [
          DropdownMenuItem<String>(value: 'ar', child: Text('العربية 🇸🇦')),
          DropdownMenuItem<String>(value: 'en', child: Text('English 🇺🇸')),
        ],
        onChanged: (value) async {
          curintCountry = value!;
          ref.read(languageProvider).changeLocale(value);
        },
      ),
    );
  }
}
