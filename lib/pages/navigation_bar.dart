import 'package:flutter/material.dart';
import 'package:shop_flutter/management_mobx.dart/management.dart';
import 'package:shop_flutter/pages/cart_page.dart';
import 'package:shop_flutter/pages/home_page.dart';
import 'package:shop_flutter/pages/profile_page.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int selectedItem = 0;
  final management = Management();
  Widget bodyController(int selectedpage){
    if(selectedpage == 0){
      return const HomePage();
    }else if(selectedpage == 1){
      return const CartPage();
    }else {
      return const ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: bodyController(selectedItem),
      bottomNavigationBar: BottomNavigationBar(currentIndex: selectedItem,
      backgroundColor: Colors.grey[500],
      fixedColor: Colors.indigo.shade500,
      items:const[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined,),
          label: 'Home',
        ),
          BottomNavigationBarItem(
          icon:  Icon(Icons.shopping_basket_outlined),
          label: 'Carrinho',
        ),
        BottomNavigationBarItem(
          icon:  Icon(Icons.person_2_outlined),
          label: 'Perfil',
        ),
      ],
      onTap: (value){
        setState(() {
          selectedItem = value;
        });
      },),
    );
  }
}