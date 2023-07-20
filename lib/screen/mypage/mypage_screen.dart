import 'package:flutter/material.dart';
import 'package:market/model/api_service.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  //appbar
  //dropdownButton을 위한 변수 생성
  List<int> dropdownList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int selectedDropdown = 1;
  //appbar

  @override
  Widget build(BuildContext context) {
    //body
    //api 정보 가져오기
    final Future<Map<String, dynamic>> userInfo =
        ApiService().getUser(selectedDropdown);
    //body
    return Scaffold(
      appBar: AppBar(
        title: const Text("사용자정보"),
        actions: [
          //드롭다운 버튼
          DropdownButton(
            value: selectedDropdown,
            items: dropdownList.map((int item) {
              return DropdownMenuItem(
                value: item,
                child: Text("User$item"),
              );
            }).toList(),
            onChanged: (int? value) {
              setState(() {
                selectedDropdown = value!;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        //api 받아오는 것 기다림
        future: userInfo,
        builder: (context, snapshot) {
          //api 받아오기 완료 시
          if (snapshot.hasData) {
            //이름, 닉네임, 이메일, 전화번호, 웹사이트, 회사이름
            String name = snapshot.data!["name"];
            String userName = snapshot.data!["username"];
            String email = snapshot.data!["email"];
            String phone = snapshot.data!["phone"];
            String website = snapshot.data!["website"];
            String company = snapshot.data!["company"]["name"];
            return Container(
                margin: const EdgeInsets.all(15),
                child: DataTable(
                  columns: [
                    const DataColumn(label: Text("User Number")),
                    DataColumn(label: Text(selectedDropdown.toString()))
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text("name")),
                      DataCell(Text(name))
                    ]),
                    DataRow(cells: [
                      const DataCell(Text("User Name")),
                      DataCell(Text(userName))
                    ]),
                    DataRow(cells: [
                      const DataCell(Text("email")),
                      DataCell(Text(email))
                    ]),
                    DataRow(cells: [
                      const DataCell(Text("phone")),
                      DataCell(Text(phone))
                    ]),
                    DataRow(cells: [
                      const DataCell(Text("website")),
                      DataCell(Text(website))
                    ]),
                    DataRow(cells: [
                      const DataCell(Text("company")),
                      DataCell(Text(company))
                    ]),
                  ],
                ));
            //받아오는 중 일 때
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
