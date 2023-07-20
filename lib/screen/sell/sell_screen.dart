import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/model/api_service.dart';
import 'package:market/screen/sell/sell_detail_screen.dart';
import 'package:market/screen/sell/sell_place_screen.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  //appbar
  //선택하는 값 초기값
  var selectKategorie = "";
  var selectPlace = "";
  //카테고리, 지역설정에서 데이터 받는 함수
  selectValue(dynamic value, String text) {
    //받아온게 없을경우
    if (value == "") {
      return text;
    }
    //받아올 경우
    return value;
  }
  //appbar

  //body
  //api 정보 가져오기
  final Future<List<dynamic>> posts = ApiService().getPosts();
  //body

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("게시판"),
        actions: [
          ElevatedButton(
            //카테고리 버튼 누르면 화면 전환
            onPressed: () async {
              //선택할 경우
              try {
                selectKategorie = await Get.to(() => const SellPlaceScreen());
                //선택안하고 돌아올경우
              } catch (e) {
                selectKategorie = selectKategorie;
              }
              //상태 최신화
              setState(() {});
            },
            //버튼 입체감 없애기
            style: ElevatedButton.styleFrom(elevation: 0),
            //텍스트 설정
            child: Text(
              selectValue(selectKategorie, "카테고리"),
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
      //FutureBuilder 는 api를 받아올 경우와 못받아올 경우를 대비해줌
      body: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          //api 정보 받아올경우
          if (snapshot.hasData) {
            return ListView.separated(
              //리스트 길이 알려주기
              itemCount: snapshot.data!.length,
              //리스트 사이마다 구분선 그어주기
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              itemBuilder: (context, index) {
                //게시물 제목, 내용
                var postId = snapshot.data![index]["id"];
                var title = snapshot.data![index]["title"];
                var body = snapshot.data![index]["body"];
                var userId = snapshot.data![index]["userId"];
                return ListTile(
                  onTap: () {
                    Get.to(() => const SellDetailScreen(),
                        arguments: [postId, title, body, userId]);
                  },
                  title: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          body,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            //api 못받아올경우
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
