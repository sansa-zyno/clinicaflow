import 'package:healtether_clinic_app/data_layer/models/staff_model/staff_model.dart';

class ProductResponse {
  List<StaffModel> products = [];
  ProductResponse({required this.products});

  factory ProductResponse.fromJson(List<dynamic> json) {
    List<StaffModel> productList = [];
    for (var productJson in json) {
      productList.add(StaffModel.fromJson(productJson));
    }
    return ProductResponse(products: productList);
  }
}
