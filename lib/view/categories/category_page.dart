import 'package:ecommerce_admin_wedpannel/view/categories/add_update_categories.dart';
import 'package:flutter/material.dart';
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories'
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.deepPurple.shade200,
        titleSpacing: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context)=>Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: AddUpdateCategories(
                      isUpdateCategories: false,
                      priorityOfCategories: 0,
                      categoriesID: ""
                  ),
                ),
              ),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
