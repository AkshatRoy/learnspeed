import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:learn_speed/HomePage.dart';
import 'package:learn_speed/SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;
  // AuthClass authClass = AuthClass();


  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(255, 0, 0, 0),


          child: Column
        ( mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text
          ("Sign Up",
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
          textitem("Password..", _pwdController, true ),
          
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
              const Text("Already have a Acount?", 
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromRGBO(206, 18, 18, 1.0), 
                fontSize: 20,
              ),),
              InkWell(
                onTap:(){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
                }),
                const Text("Login", 
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromRGBO(206, 18, 18, 1.0), 
                fontSize: 20,),)
            
              
            ],
          )

          ]
          ,)
          
        )
          ),
    ));
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
        // ignore: prefer_const_constructors
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          // ignore: prefer_const_constructors
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ),
    );
}

 Widget colorButton() {
  return InkWell(
    onTap: () async {
        setState(() {
          circular = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text, password: _pwdController.text);
          print(userCredential.user?.email);
          setState(() {
            circular = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
        }
      },

      child : Container(
    alignment: Alignment.center,
     width: MediaQuery.of(context).size.width - 70,
        height: 60,
        decoration: 
              BoxDecoration( 
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
          colors: [Color(0xffff6d63), Color(0xf8f7990c)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          
        )
      
            ),
            child: circular? CircularProgressIndicator()
          : const Text("Sign Up", style: TextStyle(fontSize: 20, fontFamily: 'Roboto', color:Color.fromRGBO(255, 255, 255, 1),)
 ),    
  ),
  );
  
  
}


}