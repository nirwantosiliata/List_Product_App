import 'package:flutter/material.dart';
import 'package:list_product/data/api/api_service.dart';
import 'package:list_product/data/product.dart';
import 'package:list_product/helpers/result_state.dart';

class GetProductProvider extends ChangeNotifier {
  final ApiService apiService;
  late BaseProductResponse _productsResult;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  BaseProductResponse get result => _productsResult;
  ResultState get state => _state;

  GetProductProvider({required this.apiService}) {
    _fetchAllProducts();
  }

  Future<void> _fetchAllProducts() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getProduct();

      if (result.products != null && result.products!.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        _productsResult = result;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'No result found';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error loading data: $e';
    }
  }
}
