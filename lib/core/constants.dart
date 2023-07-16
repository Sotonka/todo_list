class Api {
  static const host = 'beta.mrdekk.ru';
  static const headerAuth = "Authorization";
  static const headerRevision = 'X-Last-Known-Revision';
  static const importanceLow = 'low';
  static const importanceBasic = 'basic';
  static const importanceImportant = 'important';

  const Api._();
}

class FirebaseLog {
  static const deleteLog = 'delete_todo';
  static const addLog = 'add_todo';
  static const updateLog = 'update_todo';
  static const routeLog = 'path';

  const FirebaseLog._();
}
