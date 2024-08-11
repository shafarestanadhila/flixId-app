import 'package:flix_id_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_id_app/presentation/misc/methods.dart';
import 'package:flix_id_app/presentation/providers/router/router_provider.dart';
import 'package:flix_id_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id_app/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next){
      if(next is AsyncData){
        if(next.value != null){
          ref.read(routerProvider).goNamed('main');
        }
      } else if(next is AsyncError){
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpaces(100),
          Center(
            child: Image.asset(
              'lib/assets/flix_logo.png', 
              width: 150,
            ),
          ),
          verticalSpaces(100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('forgot password?',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                verticalSpaces(24),
                switch(ref.watch(userDataProvider)){
                  AsyncData(:final value) => value == null ? 
                  SizedBox(width: double.infinity,
                  child:                 
                  ElevatedButton(
                    onPressed: () {
                      ref.read(userDataProvider.notifier).login(
                        email: emailController.text, 
                        password: passwordController.text);
                    }, child: const Text('Login',
                    style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ) :
                  const Center(child: CircularProgressIndicator(),),
                  _ => const Center(child: CircularProgressIndicator(),)
                },
                verticalSpaces(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: (){
                        ref.read(routerProvider).goNamed('register');
                      }, 
                      child: const Text(
                      "Register here",
                      style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                )
              ] 
            ),
          ),
        ],
      )
    );
  }
}