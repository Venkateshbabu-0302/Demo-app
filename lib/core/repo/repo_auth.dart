import '../base/api_base.dart';

class AuthRepo {
  final String _apiKey_ = '/api/login';
  final ApiBase _apiBase_ = ApiBase();
  final String _registerKey_ = '/api/register';

   Future<dynamic> login(String? email, String? password)async{
     final response =await _apiBase_.postLogin(
         _apiKey_,
         {
           'email':email,
           'password':password,
     });
      return response;
   }

   Future<dynamic> register(String? email, String? password)async{
     final response =await _apiBase_.registerLogin(
         _registerKey_,
         {
           'email':email,
           'password':password,

     });
      return response;
   }
}
