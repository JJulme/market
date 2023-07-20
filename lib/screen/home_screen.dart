import 'package:flutter/material.dart';
import 'package:market/screen/mypage/mypage_screen.dart';
import 'package:market/screen/sell/sell_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // BottomNavigationBar 화면 전환을 위한 인덱스 설정
  int currentindex = 0;
  // BottomNavigationBar 누른 버튼에 따라 바뀌는 body 화면 설정
  List bodyScreen = [
    const SellScreen(),
    const MypageScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyScreen.elementAt(currentindex),
      bottomNavigationBar: BottomNavigationBar(
        //버튼 누를시 효과 고정으로 설정 - 안하면 버튼이 안보이는 버그
        type: BottomNavigationBarType.fixed,
        // 초기 화면 인덱스 설정
        currentIndex: currentindex,
        // 누르면 인덱스 번호 바뀜
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        // 버튼 순서와 디자인 설정
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "게시판"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "사용자정보"),
        ],
      ),
    );
  }
}
