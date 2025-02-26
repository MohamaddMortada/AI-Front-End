import 'package:front_end/controllers/auth_middleware.dart';
import 'package:front_end/pages/electric_time.dart';
import 'package:front_end/pages/mode.dart';
import 'package:front_end/pages/results.dart';
import 'package:front_end/pages/start_line.dart';
import 'package:front_end/pages/sync_page.dart';
import 'package:front_end/pages/validate_page.dart';
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

        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/login', page: () => Login()),

        GetPage(name: '/main', page: () => MainPage(),middlewares: [AuthMiddleware()],),  
        GetPage(name: '/detect', page: () => Detect(),middlewares: [AuthMiddleware()],), 
        GetPage(name: '/analyze', page: () => FinishLine(),middlewares: [AuthMiddleware()],), 
        GetPage(name: '/predict', page: () => Predict(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/calculate', page: () => Calculate(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/detecting', page: () => Detecting(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/analyzing', page: () => Analyzing(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/predicting', page: () => Predicting(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/profile', page: () => Profile(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/contact', page: () => Contact(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/chatbot', page: () => Chatbot(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/results', page: () => Results(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/electric_time', page: () => ElectricTime(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/start_line', page: () => StartLine(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/mode', page: () => ModePage(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/validate', page: () => ValidatePage(),middlewares: [AuthMiddleware()],),
        GetPage(name: '/sync', page: () => SyncPage(),middlewares: [AuthMiddleware()],),
];