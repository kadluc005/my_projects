import 'package:flutter/material.dart';
import 'package:myprojects/models/user_model.dart';
import 'package:myprojects/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    var log;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 35),
            child: Column(children: [
              const Text("Login", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
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

                    const SizedBox(height: 60,),
                    ElevatedButton(
                      onPressed: ()async{
                        if (_formKey.currentState?.validate() == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data...')),
                          );
                          log = await login(_emailController.text, _passwordController.text);
                          if(log){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged successfull')),
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage()));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          fixedSize: const Size.fromWidth(600)
                      ),
                      child: const Text("Login", style: TextStyle(fontSize: 18),),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Row(children: [const Text("You do not have an account?",
                  style: TextStyle(fontSize: 15),), TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("Register"))],),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
