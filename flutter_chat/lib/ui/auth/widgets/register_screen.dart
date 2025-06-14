import 'package:flutter/material.dart';

import '../../../domain/models/user_model.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.viewModel});

  final RegisterViewModel viewModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 56),
                  Text(
                    'Crie sua conta',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Por favor, insira uma senha.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  ListenableBuilder(
                    listenable: widget.viewModel.createCommand,
                    builder: (context, child) {
                      if (widget.viewModel.createCommand.running) {
                        return const CircularProgressIndicator();
                      }
                      if (widget.viewModel.createCommand.error) {
                        var error = widget.viewModel.createCommand.result;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                              content: Text(error.toString()),
                            ),
                          );
                        });
                      }
                      return ElevatedButton(
                        child: Text('Criar Conta'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await widget.viewModel.createCommand.execute(
                              UserModel(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                            print(
                              'Craido com sucesso ${widget.viewModel.credential?.user?.email}',
                            );
                          }

                          // Call the register method from the view model
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
