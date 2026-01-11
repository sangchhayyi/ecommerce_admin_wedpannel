import 'package:flutter/material.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget buildTile({required IconData icon,required String label,required String value, required Color color}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withAlpha(38),
            child: Icon(icon,color: color,),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:color,
            ),
          )
        ],
      ),
    );
  }
  Widget buildDashboardButton({required IconData icon, required String label,required VoidCallback onTap, required Color color}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 120,
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(77),
              blurRadius: 6,
              offset: Offset(0, 4)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,size: 38,color: color,),
            SizedBox(height: 10,),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: color,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.deepPurple.shade200,
        titleSpacing: 20,
        title: Row(
          children: [
            Icon(Icons.dashboard,size: 28,color: Colors.white ,),
            SizedBox(width: 12,),
            Text(
              'Admin Management Panel',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  buildDashboardButton(
                    icon: Icons.shopping_cart,
                    label: 'Order',
                    onTap: ()=> Navigator.pushNamed(context, '/order'),
                    color: Colors.teal,
                  ),
                  buildDashboardButton(
                    icon: Icons.store,
                    label: 'Product',
                    onTap: ()=> Navigator.pushNamed(context, '/product'),
                    color: Colors.deepPurple
                  ),
                  buildDashboardButton(
                    icon: Icons.local_offer,
                    label: 'Promo',
                    onTap: ()=> Navigator.pushNamed(context, '/promo_banner',arguments: {'promo':true}),
                    color: Colors.orange,
                  ),
                  buildDashboardButton(
                    icon: Icons.photo_library,
                    label: 'Banner',
                    onTap: ()=> Navigator.pushNamed(context, '/promo_banner',arguments: {'promo':false}),
                    color: Colors.pinkAccent,
                  ),
                  buildDashboardButton(
                      icon: Icons.category,
                      label: 'Categories',
                      onTap: ()=> Navigator.pushNamed(context, '/category'),
                      color: Colors.blueAccent
                  ),
                  buildDashboardButton(
                      icon: Icons.card_giftcard,
                      label: 'Coupon',
                      onTap: ()=> Navigator.pushNamed(context, '/coupon'),
                      color: Colors.green
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.deepPurple.shade100,
                      offset: Offset(0, 4)
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTile(
                      icon: Icons.category,
                      label: 'Total Categories',
                      value: '0',
                      color: Colors.blueAccent,
                    ),
                    buildTile(
                      icon: Icons.shopping_bag,
                      label: 'Total Product',
                      value: '0',
                      color: Colors.deepPurple,
                    ),
                    buildTile(
                      icon: Icons.receipt_long,
                      label: 'Total Orders',
                      value: '0',
                      color: Colors.teal,
                    ),
                    buildTile(
                      icon: Icons.hourglass_bottom,
                      label: 'Order Not Shipped Yet',
                      value: '0',
                      color: Colors.orange,
                    ),
                    buildTile(
                      icon: Icons.local_shipping,
                      label: 'Order Shipped',
                      value: '0',
                      color: Colors.indigo,
                    ),
                    buildTile(
                      icon: Icons.check_circle,
                      label: 'Order Delivered',
                      value: '0',
                      color: Colors.green,
                    ),
                    buildTile(
                      icon: Icons.cancel,
                      label: 'Order Cancelled',
                      value: '0',
                      color: Colors.redAccent,
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
