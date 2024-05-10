// import 'package:flutter/material.dart';
// import 'package:temp_house/presentation/common/widget/main_button.dart';
// import 'package:temp_house/presentation/resources/routes_manager.dart';
// import 'auth_services.dart';
//
// class LoginScreenTest extends StatelessWidget {
//   LoginScreenTest({Key? key}) : super(key: key);
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   void login(BuildContext context) async {
//     final authServices = AuthServices();
//     try {
//       await authServices.signInWithEmailPassword(
//           emailController.text, passwordController.text);
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
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
//               controller: emailController,
//               decoration: InputDecoration(hintText: 'Email'),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: TextField(
//               controller: passwordController,
//               decoration: InputDecoration(hintText: 'Password'),
//               obscureText: true,
//             ),
//           ),
//           MainButton(
//             text: 'Login',
//             textStyle: TextStyle(),
//             onTap: () => login(context),
//           ),
//           Container(
//             height: 120,
//             color: Colors.greenAccent,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, Routes.RegisterRoute);
//                 },
//                 child: Text('Go to Register'),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
