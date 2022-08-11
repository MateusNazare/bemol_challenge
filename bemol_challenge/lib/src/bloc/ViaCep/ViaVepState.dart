part of 'ViaCepBloc.dart';

abstract class ViaCepState extends Equatable {
  const ViaCepState();

  @override
  List<Object> get props => [];
}

class ViaCepInitial extends ViaCepState {}

class ViaCepLoading extends ViaCepState {}

class ViaCepSuccess extends ViaCepState {
  final Address address;

  const ViaCepSuccess({required this.address});

  @override
  List<Object> get props => [address];
}

class ViaCepError extends ViaCepState {
  final String message;

  const ViaCepError({required this.message});

  @override
  List<Object> get props => [message];
}
