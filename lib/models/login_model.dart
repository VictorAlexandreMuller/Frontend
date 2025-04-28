class LoginModel {
final String email;
final String senha;


  LoginModel({
    required this.email,
    required this.senha
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': senha
    };
  } 

}
