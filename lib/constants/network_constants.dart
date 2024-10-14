class NetworkConstants {
  static const String baseUrl = "https://api-uhi.azurewebsites.net";
  
  static const Map<String, String> defaultHeader = {
    "Content-Type": "application/json"
  };

  static const int timeout = 2 * 60 * 1000; // 2 minutes

  static const int limit = 25;
}