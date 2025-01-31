import 'package:ecommerce_admin_app/containers/additional_confirm.dart';
import 'package:ecommerce_admin_app/controllers/db_service.dart';
import 'package:ecommerce_admin_app/models/products_model.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: const Text("Products"),),
      body:  Consumer<AdminProvider>(builder: (context, value, child) {
         List<ProductsModel> products = ProductsModel.fromJsonList(value.products);

         if(products.isEmpty){
          return const Center(child: Text("No Products Found"),);
         }

         return ListView.builder(itemCount: products.length,
          itemBuilder:  (context, index) {
            return ListTile(
              onLongPress:  (){
                showDialog(context: context, builder: (context)=> 
                AlertDialog(
                  title: const Text("Choose want you want"),
                  content: const Text("Delete cannot be undone"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      showDialog(context: context, builder:(context)=>
                    AdditionalConfirm(contentText: "Are you sure you want to delete this product",
                     onYes: (){
                      DbService().deleteProduct(docId: products[index].id);
                      Navigator.pop(context);
                     }, onNo: (){
                      Navigator.pop(context);
                    })
                      );
                    }, child: const Text("Delete Product")),
                    TextButton(onPressed: (){}, child: const Text("Edit Product")),
                  ],
                ));
              },
              onTap: ()=> Navigator.pushNamed(context, "/view_product",arguments: products[index]),
              leading:  SizedBox(height: 50,width: 50,
              child:  Image.network(products[index].image),),
              title:  Text(products[index].name, maxLines: 2, overflow: TextOverflow.ellipsis,),
              subtitle: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Text("₹ ${products[index].new_price.toString()}"),
                  Container(padding: const EdgeInsets.all(4), color: Theme.of(context).primaryColor,child: Text(products[index].category.toUpperCase(),style: const TextStyle(color: Colors.white),))
                ],
              ),
              trailing:  IconButton(icon: const Icon(Icons.edit_outlined), onPressed: (){
               Navigator.pushNamed(context,"/add_product", arguments: products[index]);
              },),
            );
          },);
      },),

      floatingActionButton:  FloatingActionButton(child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context,"/add_product");
        
      },),
    );
  }
}