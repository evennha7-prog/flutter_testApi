import 'package:ecommerce_api/data/datasources/api_provider.dart';
import 'package:ecommerce_api/data/models/product_model.dart';

class ProductRepository {
  final ApiProvider _apiProvider;

  ProductRepository({ApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? ApiProvider.instance;

  Future<List<ProductModel>> getProducts() async {
    final response = await _apiProvider.get(endPoint: 'products');
    if (response is List) {
      return response
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<List<String>> getCategories() async {
    final response = await _apiProvider.get(endPoint: 'products/categories');
    if (response is List) {
      return response.map((item) => item.toString()).toList();
    }
    return [];
  }
}
