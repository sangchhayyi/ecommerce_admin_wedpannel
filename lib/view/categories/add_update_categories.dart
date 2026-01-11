import 'dart:convert';
import 'dart:typed_data';
import 'package:ecommerce_admin_wedpannel/viewModel/category_view_model.dart';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
class AddUpdateCategories extends StatefulWidget {
  final bool isUpdateCategories;
  final int priorityOfCategories;
  final String? nameCategories;
  final String categoriesID;
  final String? imageCategories;
  const AddUpdateCategories({
    super.key,
    required this.isUpdateCategories,
    required this.priorityOfCategories,
    this.nameCategories,
    required this.categoriesID,
    this.imageCategories
  });

  @override
  State<AddUpdateCategories> createState() => _AddUpdateCategoriesState();
}

class _AddUpdateCategoriesState extends State<AddUpdateCategories> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  Uint8List? webImage;
  PlatformFile? pickedFile;
  bool isLoading = false;
  CategoryViewModel categoryViewModel = CategoryViewModel();
  pickImageAndConvertToBase64()async{
    setState(() {
      isLoading = true;
    });
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image,withData: true);
    if(result!=null&&result.files.isNotEmpty&&result.files.first.bytes!=null){
      pickedFile = result.files.first;
      final extension = pickedFile!.extension?.toLowerCase();
      final supportedFormats = ['jpg','jpeg','png','webp'];
      if(extension==null|| !supportedFormats.contains(extension)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unsupported image format: .$extension'),
          )
        );
        return;
      }
      final originalBytes = pickedFile!.bytes!;
      final decodeImage = img.decodeImage(originalBytes);
      if(decodeImage==null){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to decode image'),
            )
        );
        return;
      }
      final compressBytes = Uint8List.fromList(
        img.encodeJpg(decodeImage, quality: 70)
      );
      setState(() {
        webImage= compressBytes;
        imageController.text= base64Encode(compressBytes);
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      title: Text(
        widget.isUpdateCategories?"Update Category":"Add Category",
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: formGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('All will be convert to lowercase',style: TextStyle(color: Colors.grey[700]),),
              SizedBox(height: 10,),
              TextFormField(
                controller: categoryController,
                validator: (v)=>v!.isEmpty?"This can't be empty":null,
                decoration: InputDecoration(
                  hintText: "Category name",
                  labelText: "Category name",
                  filled: true,
                  fillColor: Colors.deepPurple.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
              SizedBox(height: 20,),
              Text('This will be use in ordering categories',style: TextStyle(color: Colors.grey[700]),),
              SizedBox(height: 10,),
              TextFormField(
                controller: priorityController,
                validator: (v)=>v!.isEmpty?"This can't be empty":null,
                decoration: InputDecoration(
                    hintText: "Priority",
                    labelText: "Priority",
                    filled: true,
                    fillColor: Colors.deepPurple.shade50,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
              SizedBox(height: 20,),
              if(imageController.text.isNotEmpty)...[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple.shade100)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(
                      base64Decode(imageController.text),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              ],
              Center(
                child: ElevatedButton.icon(
                  onPressed: pickImageAndConvertToBase64,
                  icon: Icon(Icons.image_outlined,color: Colors.white,),
                  label: Text(isLoading?"Please wait...":'Pick image',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                enabled: false,
                controller: imageController,
                validator: (v)=>v!.isNotEmpty?"This can't be empty":null,
                decoration: InputDecoration(
                  hintText: "Base64 image string",
                  labelText: "Image data",
                  filled: true,
                  fillColor: Colors.deepPurple.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 3,
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){Navigator.pop(context);},
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: ()async{
            if(formGlobalKey.currentState!.validate()){
              Map<String, dynamic> data = {
                'name':categoryController.text.toLowerCase(),
                'image':imageController.text,
                'priority':int.parse(priorityController.text)
              };
              if(widget.isUpdateCategories){
                await categoryViewModel.updateCategory(docID: widget.categoriesID, dataMap: data);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category Updated'),));
              }else{
                await categoryViewModel.addNewCategory(dataMap: data);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category Added'),));
              }
              Navigator.pop(context);
            }

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
          child: Text(widget.isUpdateCategories?"Update":"Add",style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}
