part of 'ViaCepBloc.dart';

abstract class ViaCepEvent extends Equatable {
  const ViaCepEvent();

  @override
  List<Object> get props => [];
}

class FetchAddress extends ViaCepEvent {
  final int cep;

  const FetchAddress({required this.cep});

  @override
  List<Object> get props => [cep];
}
