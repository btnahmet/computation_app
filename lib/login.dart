import 'package:computation_app/ana_sayfa.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
  //   // Kullanıcı adı ve şifre kontrolü burada yapılabilir
  //   if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) 
  //   {
  //     // Giriş başarılı
  //     // Navigator.pushReplacementNamed(context, AnaSayfa(title:"")); // Ana sayfaya yönlendirme
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AnaSayfa(title: "")),);
  //   } else {
  //     // Hata mesajı göster
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Lütfen tüm alanları doldurun!"),
  //       ),
  //     );
  //   }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 247, 245),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: SafeArea(
          child: SingleChildScrollView(



            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo veya başlık
                    // const Icon(
                    //   Icons.lock_outline,
                    //   size: 100,
                    //   color: Colors.teal,
                    // ),
                    const SizedBox(height: 150),
                    const Text(
                      "Sayın Halil Bütün Kişisel Hesap Uygulamanıza Hoş Geldiniz",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // const Text(
                    //   "Devam etmek için giriş yapın",
                    //   style: TextStyle(fontSize: 16, color: Colors.teal),
                    // ),
                    // const SizedBox(height: 32),
                    
                    // Kullanıcı adı alanı
                    // TextField(
                    //   controller: _usernameController,
                    //   decoration: InputDecoration(
                    //     labelText: "Kullanıcı Adı",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     prefixIcon: const Icon(Icons.person),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    
                    // // Şifre alanı
                    // TextField(
                    //   controller: _passwordController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     labelText: "Şifre",
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     prefixIcon: const Icon(Icons.lock),
                    //   ),
                    // ),
                    // const SizedBox(height: 32),
                    
                    // Giriş butonu
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 224, 203),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Giriş Yap",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Kayıt ol bağlantısı
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text("Hesabınız yok mu? "),
                    //     GestureDetector(
                    //       onTap: () {
                    //         // Kayıt ol sayfasına yönlendirme
                    //       },
                    //       child: const Text(
                    //         "Kayıt Ol",
                    //         style: TextStyle(
                    //           color: Colors.teal,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
// import 'package:flutter/material.dart';
// import 'package:computation_app/ana_sayfa.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Giriş Uygulaması',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Login(title: 'Kullanıcı Girişi'),
//     );
//   }
// }

// class Login extends StatefulWidget {
//   const Login({super.key, required this.title});
//   final String title;

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() {
//     String username = _usernameController.text;
//     String password = _passwordController.text;

//     if (username.isEmpty || password.isEmpty) {
//       _showErrorMessage('Lütfen tüm alanları doldurun!');
//     } else if (username == "Halil Bütün" && password == "btngüven63") {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const AnaSayfa(title: "Ana Sayfa")),
//       );
//     } else {
//       _showErrorMessage('Kullanıcı adı veya şifre yanlış!');
//     }
//   }

//   void _showErrorMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 232, 247, 245),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 150),
//                   const Text(
//                     "Sayın Halil Bütün Kişisel Hesap Uygulamanıza Hoş Geldiniz",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   TextField(
//                     controller: _usernameController,
//                     decoration: InputDecoration(
//                       labelText: "Kullanıcı Adı",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       prefixIcon: const Icon(Icons.person),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Şifre",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       prefixIcon: const Icon(Icons.lock),
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 8, 224, 203),
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         "Giriş Yap",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
