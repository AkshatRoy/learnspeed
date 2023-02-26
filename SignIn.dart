import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:learn_speed/HomePage.dart';
import 'package:learn_speed/SignUp.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;

  
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: 
      Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 0, 0, 0),
        
        
            child: Column
          ( mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [ const SizedBox(
              height: 100,
            ),
              
              
              const Text
            ("Sign In",
            style: TextStyle(fontSize: 48, fontFamily: 'Bebas', color:Color.fromRGBO(206, 18, 18, 1.0), letterSpacing: 15)
            ),
            const SizedBox(
              height: 20,
            ), 
            buttonitem("assets/google.svg", "Continue with Google"),
            const SizedBox(
              height: 15,
            ),
            buttonitem("assets/phone.svg", "Continue with Number"),
            
            const SizedBox(
                  height: 20,
                ),
                const Text(
                  "--  Or  --",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        
            const SizedBox(
              height: 20,
            ),
            textitem("Email...", _emailController, false),
            const SizedBox(
              height: 15,
            ),
            textitem("password..", _pwdController, true ),
            
            const SizedBox(
              height: 20,
            ),
            colorButton(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text("Don't have a Acount?", 
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(206, 18, 18, 1.0), 
                  fontSize: 15,
                ),),
                // const SizedBox(
                //   height: 15,
                // ),
                InkWell(
                  onTap:(){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUp()), (route) => false);
                  }),
                const Text(" Sign Up", 
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(206, 18, 18, 1.0), 
                  fontSize: 20,),),
                
                
               
              ],
            ),
            const Text(" Forgot Password", 
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(206, 18, 18, 1.0), 
                  fontSize: 20,),)
            ]
            ,)
            
          ),
        )
        );
  }
   Widget buttonitem(String imagepath, String buttonname)
   {
    return Container(
            decoration: 
              BoxDecoration( 
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
          colors: [Color(0xffff6d63), Color(0xf8f7990c)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          
        )
      
            ),
              width: MediaQuery.of(context).size.width- 60,
              height: 60,
              child: Card(
                color: Color.fromARGB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      imagepath, height: 25, width: 25 ,),
                    const SizedBox(
                     width: 20,
                    ),
                    // ignore: prefer_const_constructors
                    Text(buttonname,
                    style: const TextStyle(fontSize: 20, fontFamily: 'Roboto', color:Color.fromRGBO(255, 255, 255, 1))
                  )
                  ],
                ),
              ),
          );
   }
   Widget textitem(
      String labeltext, TextEditingController controller, bool obscureText ) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
}

 Widget colorButton() {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 60,
        decoration: 
              BoxDecoration( 
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
          colors: [Color(0xffff6d63), Color(0xf8f7990c)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: circular
              ? CircularProgressIndicator()
              // ignore: prefer_const_constructors
              : const Text(
                  "Sign In",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                  color: Colors.white,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }

}


