import 'package:flutter/material.dart';
import 'package:list_product/data/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Product Detail',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Brand: ${product.brand}'),
                Text('Category: ${product.category}'),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Colors.yellow[700],
                        ),
                        const Text('Rating'),
                        Text(product.rating.toString()),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const Icon(
                          Icons.smartphone_rounded,
                          color: Colors.blue,
                        ),
                        const Text('Stock'),
                        Text(product.stock.toString()),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const Icon(
                          Icons.attach_money_rounded,
                          color: Colors.green,
                        ),
                        const Text('Price'),
                        Text('\$${product.stock}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(product.description),
                const SizedBox(height: 16),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.images.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.images[index],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
