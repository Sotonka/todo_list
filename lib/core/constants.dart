class Api {
  static const _token = 'chlorophyllase';
  static const baseUrl = 'https://beta.mrdekk.ru/todobackend';
  static const host = 'beta.mrdekk.ru';
  static const headerAuth = "Authorization";
  static const headerAuthValue = "Bearer $_token";
  static const headerRevision = 'X-Last-Known-Revision';
  static const importanceLow = 'low';
  static const importanceBasic = 'basic';
  static const importanceImportant = 'important';

  const Api._();
}
