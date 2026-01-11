import 'package:flutter/material.dart';
class PromoBannerPage extends StatefulWidget {
  const PromoBannerPage({super.key});

  @override
  State<PromoBannerPage> createState() => _PromoBannerPageState();
}

class _PromoBannerPageState extends State<PromoBannerPage> {
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
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.deepPurple.shade200,
        title: Text(promoPage?"Promo":"Banner"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/update_promo_banner',arguments: {'promo':promoPage});
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
