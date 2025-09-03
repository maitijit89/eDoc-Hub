import 'package:flutter/material.dart';
import 'package:edoc_hub/core/constants.dart';
import 'package:edoc_hub/widgets/feature_card.dart';
import 'package:edoc_hub/widgets/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      'title': AppStrings.aiDoctor,
      'icon': Icons.medical_services,
      'color': AppColors.primary,
      'route': '/ai_doctor'
    },
    {
      'title': AppStrings.aiLabReport,
      'icon': Icons.analytics,
      'color': AppColors.secondary,
      'route': '/ai_lab'
    },
    {
      'title': AppStrings.aiPsychiatrist,
      'icon': Icons.psychology,
      'color': AppColors.accent,
      'route': '/psychiatrist'
    },
    {
      'title': AppStrings.womensHealth,
      'icon': Icons.female,
      'color': Colors.pink,
      'route': '/womens_health'
    },
    {
      'title': AppStrings.healthTracker,
      'icon': Icons.monitor_heart,
      'color': Colors.purple,
      'route': '/health_tracker'
    },
    {
      'title': AppStrings.videoConsultation,
      'icon': Icons.video_call,
      'color': Colors.blue,
      'route': '/video_consultation'
    },
    {
      'title': AppStrings.emergencyAmbulance,
      'icon': Icons.local_hospital,
      'color': AppColors.emergency,
      'route': '/emergency'
    },
    {
      'title': AppStrings.labTestBooking,
      'icon': Icons.science,
      'color': Colors.teal,
      'route': '/lab_test'
    },
    {
      'title': AppStrings.bmiCalculator,
      'icon': Icons.calculate,
      'color': Colors.orange,
      'route': '/bmi_calculator'
    },
    {
      'title': AppStrings.paramedicalServices,
      'icon': Icons.medical_services,
      'color': Colors.green,
      'route': '/paramedical'
    },
    {
      'title': AppStrings.medicineDelivery,
      'icon': Icons.local_pharmacy,
      'color': Colors.red,
      'route': '/medicine_delivery'
    },
    {
      'title': AppStrings.doctorBooking,
      'icon': Icons.calendar_today,
      'color': Colors.indigo,
      'route': '/doctor_booking'
    },
  ];

  final List<String> carouselImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: AppStrings.appName,
              showBackButton: false,
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Carousel Banner
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                      ),
                      items: carouselImages.map((image) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate().fadeIn(duration: 600.ms),
                    
                    SizedBox(height: 20),
                    
                    // Features Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return FeatureCard(
                          title: features[index]['title'],
                          icon: features[index]['icon'],
                          color: features[index]['color'],
                          onTap: () {
                            Navigator.pushNamed(context, features[index]['route']);
                          },
                        ).animate().scale(delay: (100 * index).ms);
                      },
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Emergency Button
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.emergency,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/emergency');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.emergency, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'EMERGENCY AMBULANCE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().shake(delay: 1000.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
