class LoginModel{
   bool? status;
   String? message ;
  UserData? data;
 LoginModel.fromJson(Map<String,dynamic>json){
   status = json['status'];
   message = json['message'];
   if (json['data'] != null) {
     data = UserData.fromJson(json['data'] );
   } else {
     // ignore: null_check_always_fails
     data ;
   }
 }
}
class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String?image;
  int?  points;
  int?  credit;
  String?  token;

 UserData.fromJson(Map<String,dynamic>json){
   id = json['id'];
   name = json['name'];
   email = json['email'];
   phone = json['phone'];
   image = json['image'];
   points = json['points'];
   credit = json['credit'];
   token = json['token'];
 }
}