import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:front_end/pages/analyze.dart';
import 'package:front_end/pages/analyzing.dart';
import 'package:front_end/pages/calculate.dart';
import 'package:front_end/pages/chatbot.dart';
import 'package:front_end/pages/contact.dart';
import 'package:front_end/pages/detect.dart';
import 'package:front_end/pages/detecting.dart';
import 'package:front_end/pages/login.dart';
import 'package:front_end/pages/main_page.dart';
import 'package:front_end/pages/predict.dart';
import 'package:front_end/pages/predicting.dart';
import 'package:front_end/pages/profile.dart';
import 'package:front_end/pages/register.dart';


List<GetPage> appRoutes = [

  GetPage(name: '/main', page: () => MainPage()),  
        GetPage(name: '/detect', page: () => Detect()), 
        GetPage(name: '/analyze', page: () => Analyze()), 
        GetPage(name: '/predict', page: () => Predict()),
        GetPage(name: '/calculate', page: () => Calculate()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/detecting', page: () => Detecting()),
        GetPage(name: '/analyzing', page: () => Analyzing()),
        GetPage(name: '/predicting', page: () => Predicting()),
        GetPage(name: '/profile', page: () => Profile()),
        GetPage(name: '/contact', page: () => Contact()),
        GetPage(name: '/chatbot', page: () => Chatbot()),
];