import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_connect/domain/listener.dart';
import 'package:lets_connect/presentation/widgets/viewUtils.dart';
import '../../../data/repository/module.dart';
import '../../anim/FadeAnimation.dart';
import '../login/login_provider.dart';


class RegisterScreen extends ConsumerWidget implements DataListener {
  RegisterScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(visibleProvider);
    final authActions = ref.read(authActionsProvider);
    final authStates = ref.watch(authStateChangesProvider);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFF356859),
                  Color(0xFF4B8D7A),
                  Color(0xFF71C9B0),
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80,),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(delay: 1, child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(delay: 1.3, child: Text("Welcome to Let's Connect!", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),
                        FadeAnimation(delay: 1.4, child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [BoxShadow(
                                  color: Color.fromRGBO(53, 104, 89, .2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                              )]
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if(value == null || value.isEmpty) return 'Please enter a valid name.';
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'FullName',
                                      hintText: 'Enter full name',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person_2_outlined),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      final reg = RegExp('[a-zA-Z0-9][a-zA-Z0-9_.]*@[a-zA-Z0-9]+([.][a-zA-Z]+)+');
                                      if(value == null || value.isEmpty || value != reg.stringMatch(value)) return 'Please enter a valid email.';
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      hintText: 'Enter email',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: TextFormField(
                                    controller: passController,
                                    obscureText: !isVisible,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if(value == null || value.isEmpty) return 'Please enter a valid password.';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Enter password',
                                      border: const OutlineInputBorder(),
                                      prefixIcon: const Icon(Icons.password_outlined),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          ref.read(visibleProvider.notifier).toggle();
                                        },
                                        icon: Icon(isVisible ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                        const SizedBox(height: 40,),
                        FadeAnimation(delay: 1.6, child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              final createDate = DateTime.now().toString();
                              await authActions.createUserWithEmailAndPassword(
                                  emailController.text,
                                  passController.text,
                                  nameController.text,
                                  createDate,
                                this
                              );
                            }
                          },
                          child: const Text('Register'),
                        ),),
                        const SizedBox(height: 50,),
                        FadeAnimation(delay: 1.7, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            TextButton(onPressed: () {
                              context.pop();
                            }, child: const Text("Login here")),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onFailure(String message) {
    _scaffoldKey.currentContext!.hideDialog();
    _scaffoldKey.currentContext!.showSnackBar('Error: $message');
  }

  @override
  void onStarted() {
    _scaffoldKey.currentContext!.showProgressDialog();
    emailController.text = '';
    passController.text = '';
    nameController.text = '';
  }

  @override
  void onSuccess() {
    _scaffoldKey.currentContext!.hideDialog();
    _scaffoldKey.currentContext!.showSnackBar('Registered successfully!');
    _scaffoldKey.currentContext!.pop();
  }
}
