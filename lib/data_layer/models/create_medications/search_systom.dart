class SearchResult {
  final List<String> symptoms;
  final List<String> diagnoses;

  SearchResult({required this.symptoms, required this.diagnoses});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      symptoms: List<String>.from(json['search_output']['Symptoms']),
      diagnoses: List<String>.from(json['search_output']['Diagnoses']),
    );
  }
}
