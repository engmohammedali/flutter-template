import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/providers/language/language_notifier.dart';

final languageProvider = ChangeNotifierProvider((ref) => LocalController());
