import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryViewModel{
  addNewCategory({required Map<String,dynamic>dataMap}) async{
    await FirebaseFirestore.instance.collection('categories').add(dataMap);
  }
  updateCategory({required String docID, required Map<String, dynamic>dataMap})async{
    await FirebaseFirestore.instance.collection('categories').doc(docID).update(dataMap);
  }
  deleteCategory({required String docID}) async{
    await FirebaseFirestore.instance.collection('categories').doc(docID).delete();
  }
}