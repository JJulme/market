import 'package:dio/dio.dart';

void main(List<String> args) {
  ApiService().getPosts();
}

class ApiService {
  //기본 주소 설정
  BaseOptions options =
      BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com");

  //post 목록 가져오기
  Future<List<dynamic>> getPosts() async {
    //옵션 적용해서 dio 생성
    Dio dio = Dio(options);
    //api 접속 시도
    Response response = await dio.get("/posts");
    //성공할 경우
    if (response.statusCode == 200) {
      //데이터 저장 및 반환
      return response.data;
    }
    //틀릴경우
    throw Error();
  }

  //post의 comment 가져오기
  Future<List<dynamic>> getComments(int postId) async {
    //옵션 적용해서 dio 생성
    Dio dio = Dio(options);
    //api 접속 시도
    Response response = await dio.get("/comments?postId=$postId");
    //성공할 경우
    if (response.statusCode == 200) {
      //데이터 저장 및 반환
      return response.data;
    }
    //틀릴경우
    throw Error();
  }

  //post의 comment 가져오기
  Future<Map<String, dynamic>> getUser(int userId) async {
    //옵션 적용해서 dio 생성
    Dio dio = Dio(options);
    //api 접속 시도
    Response response = await dio.get("/users/$userId");
    //성공할 경우
    if (response.statusCode == 200) {
      //데이터 저장 및 반환
      return response.data;
    }
    //틀릴경우
    throw Error();
  }
}
