import 'package:dio/dio.dart';
import 'package:recepies_app/consts.dart';

class HTTPService
{
  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService()
  {
    return _singleton;
  }
  HTTPService._internal()
  {
    setup();
  }

  Future<void> setup({String? bearerToken}) async{
    final headers ={ "Content-Type":"application/json" };
    if(bearerToken != null)
      {
        headers["Authorization"] = "bearer $bearerToken";
      }
    final options = BaseOptions(
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status)
        {
          if(status== null){
            return false;
          }
          return status <500;
        },
    );

    _dio.options =options;
  }
  Future<Response?> post(String path,Map data)async{
    try{
      final response = await _dio.post(
        path,
      data:  data,
      );

      return response;
    }
    catch(e){
      print(e);
    }
  }
  Future<Response?> get(String path)
  async {
    try{
      final response = await _dio.get(path);
      return response;
    }
    catch(e){
      print(e);
    }
    return null;
  }
}