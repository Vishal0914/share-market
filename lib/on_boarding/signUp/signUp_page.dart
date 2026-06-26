
import 'package:flutter/material.dart';

import '../../home_page.dart';
import '../login/login_page.dart';

class SignUp extends StatelessWidget {

  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  var adharNoController=TextEditingController();

  GlobalKey<FormState> formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Center(
                    child: Image.asset("assets/icons/stock.png",height: 50,width: 50)
                ),
                SizedBox(height: 10),
                Text("Create Account",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: nameController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
            
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Phone";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: adharNoController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Adhar";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Adhar",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter password";
                    } else if (!RegExp(
                      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
                    ).hasMatch(value)) {
                      return "must have 1 upper case,1 symbol, 1number ,\nlength 8 ";
                    }
                    return null;
                  },
            
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (passwordController.text != confirmPasswordController.text) {
                      return "password not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    hintText: "Confirm Password",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide(width: 2, color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
            
                      if(formkey.currentState!.validate()){
            
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
            
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account Created Successfully !!"),backgroundColor: Colors.green,));
                      }
            
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: .circular(10)),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Text("Create Account",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 10),
            
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Text("Already have account?",style: TextStyle(color: Colors.blue),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
