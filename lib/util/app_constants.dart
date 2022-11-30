
import 'package:aoil/util/images.dart';
import 'package:aoil/util/repo/language_model.dart';

class AppConstants {
  static const String APP_NAME = 'جهرم کالا';
  static const String BASE_URL = 'https://jahromkala.com';

  static List<LanguageModel> languages = [
    // LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    // LanguageModel(imageUrl: Images.arabic, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'فارسی', countryCode: 'IR', languageCode: 'fa'),
  ];
}
