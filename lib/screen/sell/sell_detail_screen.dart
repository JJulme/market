import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/model/api_service.dart';
import 'package:share/share.dart';

class SellDetailScreen extends StatefulWidget {
  const SellDetailScreen({super.key});

  @override
  State<SellDetailScreen> createState() => _SellDetailScreenState();
}

class _SellDetailScreenState extends State<SellDetailScreen> {
  //가져온 post 정보
  int id = Get.arguments[0];
  String title = Get.arguments[1];
  String body = Get.arguments[2];
  int userId = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    //api post의 comment 정보 가져오기
    //build 내에서 생성해야 오류 없음
    final Future<List<dynamic>> comments = ApiService().getComments(id);

    return Scaffold(
        appBar: AppBar(
          title: Text("작성자: USER$userId"),
          actions: [
            //공유버튼
            IconButton(
                onPressed: () {
                  Share.share("보고있는 페이지 공유기능 구현해야 함");
                },
                icon: const Icon(Icons.share)),
            //더보기 버튼
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text("즐겨찾기")),
                const PopupMenuItem(child: Text("신고하기"))
              ],
            )
          ],
        ),
        //UI 안잘리도록 해주는 클래스
        body: SafeArea(
            child: FutureBuilder(
          //기다릴 변수
          future: comments,
          builder: (context, snapshot) {
            //변수기다리기
            if (snapshot.hasData) {
              //스크롤 생성
              return SingleChildScrollView(
                //여백생성
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "제목: $title",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        height: 30,
                      ),
                      Text(
                        body,
                        style: const TextStyle(fontSize: 23),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "댓글",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        height: 30,
                      ),
                      //댓글 가져오기
                      ListView.separated(
                        //스크롤 없애기 - 스크롤 중복으로 에러 발생
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true, //스크롤 에러 방지
                        //댓글 갯수 알려주기
                        itemCount: snapshot.data!.length,
                        //댓글 사이 나타낼 구분선
                        separatorBuilder: (context, index) =>
                            const Divider(thickness: 1, height: 25),
                        //반복문 실행
                        itemBuilder: (context, index) {
                          //comment의 정보 정리 - 이름, 이메일, 댓글내용
                          var name = snapshot.data![index]["name"];
                          var email = snapshot.data![index]["email"];
                          var body = snapshot.data![index]["body"];
                          return ListTile(
                            //리스트타일의 기본 여백 없애기
                            contentPadding: const EdgeInsets.all(0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //이름
                                Text(
                                  "이름: $name",
                                  style: const TextStyle(fontSize: 23),
                                ),
                                //이메일
                                Text(
                                  "<$email>",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                //댓글내용
                                Text(
                                  body,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
              //api comment 정보 받아올동안 기다리는 로딩화면
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )));
  }
}
