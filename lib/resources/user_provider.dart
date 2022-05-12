import 'package:dio/dio.dart';
import 'package:dropdwon_clsr/models/user_model.dart';

class UserProvider {
  final Dio _dio = Dio();
  final String url =
      "https://jsonplaceholder.typicode.com/users";
  
  // future<wilayahmodel> is empty
  Future<UserModel> fetchUserList() async {
    try {
      //setelah await selesai wilayah model terisi
      Response response = await _dio.get(url);
      return UserModel.fromJson(response.data);

      
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserModel.withError("Data not found / Connection issue");
    }   
  }
}
