import 'package:flutter/material.dart';
import 'package:myprojects/models/user_model.dart';
import 'package:myprojects/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();
    final _emailController = TextEditingController();
    final _phoneController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    var reg;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 35),
            child: Column(children: [
              const Text("Register", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Username'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 45,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Email'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter your email";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 45,),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Phone number'
                      ),
                      /*validator: (value){
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },*/
                    ),
                    const SizedBox(height: 45,),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye)),
                          hintText: 'Password'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter a password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 45,),
                    TextFormField(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.remove_red_eye)),
                          hintText: 'Confirm password'
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please confirm the password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 60,),
                    ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState?.validate() == true) {
                            if(_passwordController.text == _confirmPasswordController.text){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data...')),
                              );
                               reg = await register(_usernameController.text, _emailController.text, _phoneController.text, _passwordController.text, _confirmPasswordController.text);
                              if(reg){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Registered successful. Login')),
                                );
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                              }
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('No match password'),
                                backgroundColor: Colors.red,),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          fixedSize: const Size.fromWidth(600)
                        ),
                        child: const Text("Register", style: TextStyle(fontSize: 18),),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(children: [const Text("Already have an account?",
                style: TextStyle(fontSize: 15),), TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
                }, child: const Text("Login"))],),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
