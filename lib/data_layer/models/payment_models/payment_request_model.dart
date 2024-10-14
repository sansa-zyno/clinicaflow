class GetPaymentRequest {
  String clientId;
  int page;
  int size;

  GetPaymentRequest(
      {required this.clientId, required this.page, required this.size});
}