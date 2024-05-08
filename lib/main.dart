import 'package:exercise_login_page/page/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //ပြောင်းလဲသွားတဲ့ stage ကိုမှတ်ထားပြီးတော့ လိုက်ပြီးပြောင်းလဲပေးဖို့အတွက်ကို သုံးဖို့အတွက်ကို လိုအပ်တဲ့အတွက်မလို့ကို ထည့်ပေးထားတာ
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

//အစမ်းကိုcommendကိုစမ်းထားကြည့်တာ