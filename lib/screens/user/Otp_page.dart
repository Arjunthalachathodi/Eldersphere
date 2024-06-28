import 'package:eldersphere/constants/constants1.dart';
import 'package:eldersphere/constants/textstyle.dart';
import 'package:eldersphere/screens/user/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Otpform extends StatelessWidget {
  const Otpform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       child: Form(
         child: Container(
           height: double.infinity,
           width: double.infinity,
           padding: EdgeInsets.all(20),
           child: Column(
             children: [
               Image.asset(
                 logoPath,
                 scale: 3,
               ),
               Text(
                 appTitle,
                 style: TextStyle(
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                   color: Colors.blue,
                 ),
               ),
               Text("Verification code",style: TextStyle(
                 fontWeight: FontWeight.bold
               ),),
               Text("We have sent the varification code"),
               SizedBox(height: 20,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   SizedBox(
                     height: 68,
                     width: 64,
                     child: TextFormField(
                       onChanged: (value){
                         if (value.length==1)
                         {
                           FocusScope.of(context).nextFocus();
                         }
                       },
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.green),
                         ),
                       ),
                       style: Theme.of(context).textTheme.headline6,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(1),
                         FilteringTextInputFormatter.digitsOnly
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 68,
                     width: 64,
                     child: TextFormField(
                       onChanged: (value){
                         if (value.length==1)
                         {
                           FocusScope.of(context).nextFocus();
                         }
                       },

                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.green),
                         ),
                       ),
                       style: Theme.of(context).textTheme.headline6,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(1),
                         FilteringTextInputFormatter.digitsOnly
                       ],
                     ),
                   ),

                   SizedBox(
                     height: 68,
                     width: 64,
                     child: TextFormField(
                       onChanged: (value){
                         if (value.length==1)
                         {
                           FocusScope.of(context).nextFocus();
                         }
                       },
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.green),
                         ),
                       ),
                       style: Theme.of(context).textTheme.headline6,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(1),
                         FilteringTextInputFormatter.digitsOnly
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 68,
                     width: 64,
                     child: TextFormField(
                       onChanged: (value){
                         if (value.length==1)
                         {
                           FocusScope.of(context).nextFocus();
                         }
                       },
                       decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.green),
                         ),
                       ),
                       style: Theme.of(context).textTheme.headline6,
                       keyboardType: TextInputType.number,
                       textAlign: TextAlign.center,
                       inputFormatters: [
                         LengthLimitingTextInputFormatter(1),
                         FilteringTextInputFormatter.digitsOnly
                       ],
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 40,),
               GestureDetector( onTap: (){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);

              },

                 child: Container(
                   decoration: BoxDecoration(
                       color: Colors.blue
                   ),
                   height:45,

                   child: Center(
                     child: Text(
                       "SUBMIT",style:btntextStyle,
                     ),
                   ),
                 ),
               ),
             ],

           ),
         ),
       ),
     ),
    );
  }
}
