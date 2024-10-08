class User {
  String userName;
  int id;
  String email;

  User({required this.userName,required this.email,required this.id});

  factory User.fromJson(Map<String , dynamic> json){
     return User(userName: json['userName'], email: json['id'], id: json['email']);
  }

}