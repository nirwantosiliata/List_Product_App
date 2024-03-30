import 'package:flutter/material.dart';
import 'package:list_product/data/api/api_service.dart';
import 'package:list_product/data/product.dart';
import 'package:list_product/helpers/result_state.dart';

class GetDetailProductProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  late Product _product;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  Product get product => _product;
  ResultState get state => _state;

  GetDetailProductProvider(this.id, {required this.apiService}) {
    _fetchDetailProducts(id);
  }

  Future<void> _fetchDetailProducts(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.getDetailProduct(id);

      if ((result.title != '' &&
          result.description != '' &&
          result.brand != '' &&
          result.category != '' &&
          result.discountPercentage != 0.0 &&
          result.price != 0)) {
        _state = ResultState.hasData;
        notifyListeners();
        _product = result;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'No results found by id:$id';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error loading data: $e';
    }
  }
}
