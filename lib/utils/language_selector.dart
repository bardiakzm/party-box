class Language {
  String currentLang = 'en';
  void setLang(String lang) {
    switch (lang) {
      case 'en':
        currentLang = 'en';
        break;
      case 'fa':
        currentLang = 'fa';
        break;
      default:
        currentLang = 'en';
    }
  }
}
