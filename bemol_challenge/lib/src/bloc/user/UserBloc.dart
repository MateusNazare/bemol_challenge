import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

import '../../entities/user.dart';

part 'UserEvent.dart';
part 'UserState.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<PostUser>((event, emit) async {
      emit(UserLoading());

      String url = 'http://localhost:3000/users';

      try {
        Response response = await post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode(event.user.toJson()));

        Map<String, dynamic> responseJson =
            json.decode(response.body) as Map<String, dynamic>;

        if (responseJson["error"] != true) {
          User user = User.fromJson(responseJson);

          emit(
            UserSuccess(user: user),
          );
        } else {
          emit(
            UserError(message: responseJson["message"] ?? "Algo deu errado"),
          );
        }
      } catch (e) {
        emit(
          const UserError(
              message: "Não foi possível enviar os dados, tente novamente"),
        );
      }
    });
  }
}
