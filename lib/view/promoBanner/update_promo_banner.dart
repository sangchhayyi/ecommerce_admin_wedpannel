import 'package:flutter/material.dart';
class UpdatePromoBanner extends StatefulWidget {
  const UpdatePromoBanner({super.key});

  @override
  State<UpdatePromoBanner> createState() => _UpdatePromoBannerState();
}

class _UpdatePromoBannerState extends State<UpdatePromoBanner> {
  bool initialized = false;
  bool promoPage = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((c){
      if(!initialized){
        final args = ModalRoute.of(context)?.settings.arguments;
        if(args!=null&&args is Map<String,dynamic>){
          promoPage = args['promo']?? true;
        }
        initialized = true;
        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          promoPage?"Update Promo":"Update Banner"
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.deepPurple.shade200,
        titleSpacing: 20,
        centerTitle: true,
      ),
    );
  }
}
