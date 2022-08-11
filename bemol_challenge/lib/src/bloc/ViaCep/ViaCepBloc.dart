import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../entities/Address.dart';

part 'ViaCepEvent.dart';
part 'ViaVepState.dart';

class ViaCepBloc extends Bloc<ViaCepEvent, ViaCepState> {
  ViaCepBloc() : super(ViaCepInitial()) {
    on<FetchAddress>((event, emit) async {
      
      emit(ViaCepLoading());

      String url = 'https://viacep.com.br/ws/${event.cep}/json/';

      try {
        Response response = await get(Uri.parse(url), headers: {
          "Content-Type": "application/json",
        });
      
        Map<String, dynamic> responseJson =
            json.decode(response.body) as Map<String, dynamic>;

        Address address = Address.fromJson(responseJson);

        if (address.error) {
          emit(
            const ViaCepError(
                message: 'CEP inválido, digite novamente o seu CEP'),
          );
        } else {
          emit(ViaCepSuccess(address: address));
        }
      } catch (err) {
        emit(
          const ViaCepError(
              message: 'CEP inválido, digite novamente o seu CEP'),
        );
      }
    });
  }
}
