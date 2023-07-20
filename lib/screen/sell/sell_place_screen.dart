import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market/model/place.dart';

class SellPlaceScreen extends StatefulWidget {
  const SellPlaceScreen({super.key});

  @override
  State<SellPlaceScreen> createState() => _SellPlaceScreenState();
}

class _SellPlaceScreenState extends State<SellPlaceScreen> {
  //lib\model\place.dart 에서 지역 가져오기
  final place = Place().place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("카테고리를 선택해주세요."),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: ExpansionPanelList.radio(
            children: [
              for (var title in place.keys)
                ExpansionPanelRadio(
                  //패널의 위치값
                  value: Text(title),
                  //헤더 전체 클릭시 확장
                  canTapOnHeader: true,
                  //패널 제목 설정
                  headerBuilder: (context, isExpanded) => Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20),
                      )),
                  //패널 펼쳤을 때 내용 설정
                  body: GridView.builder(
                    //index의 값 범위 지정해줌
                    itemCount: place[title]?.length,
                    //높이 지정 에러 방지
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true, //
                    //GridView가 나올대 보여질 규칙 설정
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 1,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return TextButton(
                        //누른 항목이 전달됨
                        onPressed: () {
                          Get.back(result: place[title]![index]);
                        },
                        child: Text(
                          place[title]![index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      )),
    );
  }
}
