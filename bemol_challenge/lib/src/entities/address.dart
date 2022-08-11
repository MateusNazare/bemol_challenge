import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int cep;
  final String address;
  final String complement;
  final String city;
  final String state;
  final bool error;

  const Address(
      {required this.cep,
      required this.address,
      required this.complement,
      required this.city,
      required this.state,
      required this.error});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      cep: json["cep"].isEmpty == false ? int.parse(json["cep"].replaceAll("-", "")) : 0,
      address: json["logradouro"] ?? "",
      complement: json["complemento"] ?? "",
      city: json["localidade"] ?? "",
      state: json["uf"] ?? "",
      error: json["error"] ?? false,
    );
  }

  @override
  List<Object?> get props => [cep, address, complement, city, state];
}
