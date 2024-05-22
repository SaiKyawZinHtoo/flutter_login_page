import 'package:exercise_login_page/page/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //ပြောင်းလဲသွားတဲ့ stage ကိုမှတ်ထားပြီးတော့ လိုက်ပြီးပြောင်းလဲပေးဖို့အတွက်ကို သုံးဖို့အတွက်ကို လိုအပ်တဲ့အတွက်မလို့ကို ထည့်ပေးထားတာ
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthPage(),
    );
  }
}

//အစမ်းကိုcommendကိုစမ်းထားကြည့်တာ