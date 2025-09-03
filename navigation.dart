import 'package:flutter/material.dart';
import 'package:edoc_hub/screens/auth/login_screen.dart';
import 'package:edoc_hub/screens/auth/otp_screen.dart';
import 'package:edoc_hub/screens/home_screen.dart';
import 'package:edoc_hub/screens/ai_doctor_screen.dart';
import 'package:edoc_hub/screens/ai_lab_screen.dart';
import 'package:edoc_hub/screens/psychiatrist_screen.dart';
import 'package:edoc_hub/screens/womens_health_screen.dart';
import 'package:edoc_hub/screens/health_tracker_screen.dart';
import 'package:edoc_hub/screens/video_consultation_screen.dart';
import 'package:edoc_hub/screens/emergency_ambulance_screen.dart';
import 'package:edoc_hub/screens/lab_test_screen.dart';
import 'package:edoc_hub/screens/bmi_calculator_screen.dart';
import 'package:edoc_hub/screens/paramedical_services_screen.dart';
import 'package:edoc_hub/screens/medicine_delivery_screen.dart';
import 'package:edoc_hub/screens/doctor_booking_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/otp':
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/ai_doctor':
        return MaterialPageRoute(builder: (_) => AiDoctorScreen());
      case '/ai_lab':
        return MaterialPageRoute(builder: (_) => AiLabScreen());
      case '/psychiatrist':
        return MaterialPageRoute(builder: (_) => PsychiatristScreen());
      case '/womens_health':
        return MaterialPageRoute(builder: (_) => WomensHealthScreen());
      case '/health_tracker':
        return MaterialPageRoute(builder: (_) => HealthTrackerScreen());
      case '/video_consultation':
        return MaterialPageRoute(builder: (_) => VideoConsultationScreen());
      case '/emergency':
        return MaterialPageRoute(builder: (_) => EmergencyAmbulanceScreen());
      case '/lab_test':
        return MaterialPageRoute(builder: (_) => LabTestScreen());
      case '/bmi_calculator':
        return MaterialPageRoute(builder: (_) => BmiCalculatorScreen());
      case '/paramedical':
        return MaterialPageRoute(builder: (_) => ParamedicalServicesScreen());
      case '/medicine_delivery':
        return MaterialPageRoute(builder: (_) => MedicineDeliveryScreen());
      case '/doctor_booking':
        return MaterialPageRoute(builder: (_) => DoctorBookingScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
