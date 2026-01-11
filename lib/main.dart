import 'package:ecommerce_admin_wedpannel/view/categories/category_page.dart';
import 'package:ecommerce_admin_wedpannel/view/dashboard_page.dart';
import 'package:ecommerce_admin_wedpannel/view/promoBanner/promo_banner_page.dart';
import 'package:ecommerce_admin_wedpannel/view/promoBanner/update_promo_banner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCRBGvU_w9_JwCjsua5ZzafeGjW3zDyCew",
        authDomain: "ecommerceapp-3b12b.firebaseapp.com",
        projectId: "ecommerceapp-3b12b",
        storageBucket: "ecommerceapp-3b12b.firebasestorage.app",
        messagingSenderId: "452080250450",
        appId: "1:452080250450:web:3c7bb03dc7898b1d8eb98b",
        measurementId: "G-ZPN8EHTQ0D"
    )
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>const DashboardPage(),
      '/promo_banner':(context)=>const PromoBannerPage(),
      '/update_promo_banner':(context)=>UpdatePromoBanner(),
      '/category':(context)=>CategoryPage()
    },
  ));
}
