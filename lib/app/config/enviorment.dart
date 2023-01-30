class Enviorment {
  static const maxboxToken = String.fromEnvironment('MAPBOX_ACCESSTOKEN');
  static const geocodingToken = String.fromEnvironment('GEOCODING_ACCESSTOKEN');
  static const apiUrl = String.fromEnvironment('APIURL');

  // Firebase
  static const fireBaseApiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const fireBaseAppID = String.fromEnvironment('FIREBASE_APP_ID');
  static const fireBaseMessagingSenderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const fireBaseProjectID = String.fromEnvironment('FIREBAE_PROJECT_ID');
  static const fireBaseStorageBucket =
      String.fromEnvironment('FIREBASE_STORAGE_BUCKET');
}
