// import 'package:flutter/material.dart';
// import 'package:temp_house/presentation/chats_screen/auth_services.dart';
// import 'package:temp_house/presentation/common/widget/main_button.dart';
// import 'package:temp_house/presentation/resources/routes_manager.dart';
//
// class RegiesterScreenTest extends StatelessWidget {
//   RegiesterScreenTest({super.key});
//   TextEditingController passWordcontroller = TextEditingController();
//   TextEditingController emailWordcontroller = TextEditingController();
//
//   void register(){
//     final _auth = AuthServices();
//     _auth.signUpWithEmailPassword(emailWordcontroller.text, passWordcontroller.text);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextField(
//               controller: emailWordcontroller,
//               decoration: InputDecoration(hintText: 'email'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextField(
//               controller: passWordcontroller,
//               decoration: InputDecoration(hintText: 'password'),
//             ),
//           ),
//           MainButton(
//             text: 'Regiester',
//             textStyle: TextStyle(),
//             onTap: register,
//           ),
//           Container(
//             height: 120,
//             color: Colors.greenAccent,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: TextButton(onPressed: () {
//                 Navigator.pushNamed(context, Routes.LoginRoute);
//               }, child: Text('go to login')),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
