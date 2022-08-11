import 'package:bemolChallenge/modules/settings/colors.dart';
import 'package:bemolChallenge/src/bloc/ViaCep/ViaCepBloc.dart';
import 'package:bemolChallenge/src/views/user/widgets/inputWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/UserBloc.dart';
import '../../entities/Address.dart';
import '../../entities/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  bool _isValidCep = false;

  @override
  void initState() {
    super.initState();

    _nameController.text = "";
    _emailController.text = "";
    _passwordController.text = "";
    _cepController.text = "";
    _addressController.text = "";
    _complementController.text = "";
    _cityController.text = "";
    _stateController.text = "";
    _numberController.text = "";
  }

  void _fillAddressFields(Address address) {
    _stateController.text = address.state;
    _cityController.text = address.city;
    _addressController.text = address.address;
    _complementController.text = address.complement;

    _isValidCep = true;
  }

  Future<void> _showAlert(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: const Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.secondary,
        ),
        title: const Text("Cadastro de usuário"),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.dark,
          child: Center(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              hintText: "Digite seu nome completo",
                              labelText: 'Nome',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu nome';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              hintText: "Digite seu email",
                              labelText: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu email';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 50,
                            ),
                            child: InputWidget(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              hintText: "Digite uma senha",
                              labelText: 'Senha',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua senha';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                              isObscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _cepController,
                              keyboardType: TextInputType.number,
                              hintText: "Digite seu CEP",
                              labelText: 'CEP',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu CEP';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                _isValidCep = false;
                                if (value.isEmpty == false &&
                                    value.length == 8) {
                                  context.read<ViaCepBloc>().add(FetchAddress(
                                      cep: int.tryParse(_cepController.text) ??
                                          0));
                                }
                              },
                              maxLength: 8,
                            ),
                          ),
                          BlocConsumer<ViaCepBloc, ViaCepState>(
                            listener: (context, state) {
                              if (state is ViaCepSuccess) {
                                _fillAddressFields(state.address);
                              } else if (state is ViaCepError) {
                                _isValidCep = false;
                              }
                            },
                            builder: (context, state) {
                              if (state is ViaCepLoading) {
                                return const Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text("Carregando...",
                                      style: TextStyle(color: AppColors.clear)),
                                );
                              } else if (state is ViaCepError) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Text(state.message,
                                      style: const TextStyle(
                                          color: AppColors.error)),
                                );
                              }

                              return Container();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _cityController,
                              keyboardType: TextInputType.text,
                              hintText: "Digite a cidade",
                              labelText: 'Cidade',
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                              enabled: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _stateController,
                              keyboardType: TextInputType.text,
                              hintText: "Digite a UF",
                              labelText: 'UF',
                              validator: (value) {
                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 2,
                              enabled: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _addressController,
                              keyboardType: TextInputType.text,
                              hintText: "Digite seu endereço (Rua, avenida...)",
                              labelText: 'Endereço',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu endereço';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _numberController,
                              keyboardType: TextInputType.number,
                              hintText: "Digite o número",
                              labelText: 'Número',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite o número';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: InputWidget(
                              controller: _complementController,
                              keyboardType: TextInputType.text,
                              hintText: "Digite o complemento",
                              labelText: 'Complemento',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite o complemento';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              maxLength: 255,
                            ),
                          ),
                          BlocConsumer<UserBloc, UserState>(
                            listener: (context, state) {
                              if (state is UserError) {
                                _showAlert("Erro", state.message);
                              } else if (state is UserSuccess) {
                                _showAlert("Sucesso",
                                    "O Usuário ${state.user.name} foi cadastrado com sucesso.");
                              }
                            },
                            builder: (context, state) {
                              if (state is UserLoading) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AppColors.dark),
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (Set<MaterialState> states) {
                                              return AppColors.secondary;
                                            },
                                          ),
                                        ),
                                        onPressed: null,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child:
                                              const CircularProgressIndicator(
                                            color: AppColors.dark,
                                          ),
                                        )));
                              }

                              return Container(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: TextButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                AppColors.dark),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            return AppColors.secondary;
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (_isValidCep &&
                                              _cepController.text.length == 8) {
                                            context.read<UserBloc>().add(PostUser(
                                                user: User(
                                                    name: _nameController.text,
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    cep: int.tryParse(
                                                            _cepController
                                                                .text) ??
                                                        0,
                                                    address:
                                                        _addressController.text,
                                                    city: _cityController.text,
                                                    state:
                                                        _stateController.text,
                                                    complement:
                                                        _complementController
                                                            .text,
                                                    number: int.tryParse(
                                                            _numberController
                                                                .text) ??
                                                        0)));
                                          } else {
                                            _showAlert("Erro",
                                                "CEP inválido, por favor, informe seu CEP novamente.");
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: const Text("Cadastrar",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      )));
                            },
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Você já possui uma conta? ",
                                      style: TextStyle(
                                          color: AppColors.clear
                                              .withOpacity(0.5))),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Text("Entrar",
                                          style: TextStyle(
                                              color: AppColors.secondary,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ))
                        ],
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
