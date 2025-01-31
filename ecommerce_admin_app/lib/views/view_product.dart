import 'package:ecommerce_admin_app/constants/discount.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:flutter/material.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ProductsModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User's View"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              arguments.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    arguments.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                   
                      Text(
                        "₹ ${arguments.old_price}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                            decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        "₹ ${arguments.new_price}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(width: 10,),
                      const Icon(Icons.arrow_downward, color: Colors.green,
                          size: 20,),
                      Text("${discountPercent(arguments.old_price, arguments.new_price)} %",
                       style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),)
                    ],
                  ),
        
                  const SizedBox(
                    height: 10,
                  ),
                  arguments.maxQuantity == 0
                        ? const Text(
                            "Out of Stock",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          )
                        : Text(
                            "Only ${arguments.maxQuantity} left in stock",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(arguments.description,
                   style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700),)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:  Row(children: [
        
SizedBox(
  height: 60,width: MediaQuery.of(context).size.width*.5,
  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder()),
                    child: Text("Add to Cart"),
                  ),
),
SizedBox(
  height: 60,width: MediaQuery.of(context).size.width*.5,
  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:  Theme.of(context).primaryColor,
                        shape: const RoundedRectangleBorder()),
                    child: Text("Buy Now"),
                  ),
),
      ],),
    );
  }
}
