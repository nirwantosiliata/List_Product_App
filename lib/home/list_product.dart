import 'package:flutter/material.dart';
import 'package:list_product/data/api/api_service.dart';
import 'package:list_product/data/product.dart';
import 'package:list_product/helpers/result_state.dart';
import 'package:list_product/providers/get_products_provider.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<GetProductProvider>(
        create: (_) {
          return GetProductProvider(apiService: ApiService());
        },
        child: Scaffold(
          body: Consumer<GetProductProvider>(
            builder: (contextProvider, state, _) {
              return Column(
                children: [
                  _buildTitle(),
                  _buildSearchField(contextProvider),
                  _listProduct(contextProvider, state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'List Product',
        style: TextStyle(
          fontSize: 32,
          fontFamily: 'serif',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _listProduct(BuildContext context, GetProductProvider state) {
    if (state.state == ResultState.loading) {
      return _buildItemIcon(Icons.search, 'Searching ...');
    } else if (state.state == ResultState.hasData) {
      return _buildProductList(state.result.products);
    } else if (state.state == ResultState.noData) {
      return _buildItemIcon(Icons.hourglass_empty, 'No Data Available');
    } else if (state.state == ResultState.error) {
      return _buildErrorState(context);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Center _buildItemIcon(IconData iconData, String title) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 50,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(title)
      ],
    ));
  }

  Scaffold _buildErrorState(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading data.'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Trigger retryFetchRestaurant to get data again
                Provider.of<GetProductProvider>(context, listen: false)
                    .retryFetchProduct();
              },
              child: const Text("Reload"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product>? data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: _itemProduct(context, data![index]),
            onTap: () {
              // Assuming you have a DetailProduct widget to display details
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: '${data[index].id}',
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) {
          Provider.of<GetProductProvider>(context, listen: false)
              .retryFetchProduct(title: value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          hintText: "Search for products",
          suffixIcon: const Icon(Icons.search),
          // prefix: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }

  Widget _itemProduct(BuildContext context, Product data) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    data.thumbnail ?? '',
                    fit: BoxFit.fitHeight,
                    height: 120, // Adjust the height as needed
                    width: 160, // Adjust the width as needed
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Rating: ${data.rating}'),
                    Text('Stock: ${data.stock}'),
                    Text('Brand: ${data.brand}'),
                    Text('Category: ${data.category}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
