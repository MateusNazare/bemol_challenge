part of 'UserBloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class PostUser extends UserEvent {
  final User user;

  const PostUser({required this.user});

  @override
  List<Object> get props => [user];
}
