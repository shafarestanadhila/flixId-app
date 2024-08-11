import 'package:flix_id_app/presentation/extensions/build_context_extension.dart';
import 'package:flix_id_app/presentation/misc/methods.dart';
import 'package:flix_id_app/presentation/providers/router/router_provider.dart';
import 'package:flix_id_app/presentation/providers/user_data/user_data_provider.dart';
import 'package:flix_id_app/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if(next is AsyncData && next.value != null){
          ref.read(routerProvider).goNamed('main');
        }else if(next is AsyncError){
          context.showSnackBar(next.error.toString());
        }
      }
    );
    return Scaffold(
      body: ListView(
        children: [Column(
          children: [
            verticalSpaces(50),
            Center(
              child: Image.asset('lib/assets/flix_logo.png', width: 150,)
            ),
            verticalSpaces(50),
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.white,
              ),
            ),
            verticalSpaces(24),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24), 
            child: Column(
              children: [
                FlixTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Name',
                  controller: nameController,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                FlixTextField(
                  labelText: 'Retype Password',
                  controller: retypePasswordController,
                  obscureText: true,
                ),
                verticalSpaces(24),
                switch(ref.watch(userDataProvider)){
                  AsyncData(:final value) => value == null ?
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      if(passwordController.text == retypePasswordController.text){
                        ref.read(userDataProvider.notifier)
                          .register(email: emailController.text, password: passwordController.text, name: nameController.text);
                      } else{
                        context.showSnackBar('please retype your password with the same value');
                      }
                    }, child: const Text('Register',
                    style: TextStyle(fontWeight: FontWeight.bold),)),
                  ) : const Center(child: CircularProgressIndicator(),),
                  _ => const Center(child: CircularProgressIndicator(),)
                },
                verticalSpaces(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(onPressed: (){
                      ref.read(routerProvider).goNamed('login');
                    }, child: const Text('Login here',
                    style: TextStyle(fontWeight: FontWeight.bold),))
                  ],
                ),
                verticalSpaces(24),

              ],
            ),)
          ],
        )],
      ),
    );
  }
}