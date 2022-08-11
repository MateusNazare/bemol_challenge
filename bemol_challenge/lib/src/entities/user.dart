import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;
  final String password;
  final int cep;
  final String address;
  final int number;
  final String complement;
  final String city;
  final String state;

  const User({
    required this.name,
    required this.email,
    required this.password,
    required this.cep,
    required this.address,
    required this.complement,
    required this.city,
    required this.state,
    required this.number,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      cep: json["cep"] ?? 0,
      address: json["address"] ?? "",
      number: json["number"] ?? 0,
      complement: json["complement"] ?? "",
      city: json["city"] ?? "",
      state: json["state"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'cep': cep,
        'address': address,
        'number': number,
        'complement': complement,
        'city': city,
        'state': state,
      };

  @override
  List<Object?> get props =>
      [name, email, password, cep, address, complement, number, city, state];
}
