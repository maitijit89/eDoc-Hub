import 'package:flutter/material.dart';
import 'package:edoc_hub/core/constants.dart';

class BmiCalculatorScreen extends StatefulWidget {
  @override
  _BmiCalculatorScreenState createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0;
  String _category = '';

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;
    
    if (height > 0 && weight > 0) {
      final double heightInMeters = height / 100;
      setState(() {
        _bmi = weight / (heightInMeters * heightInMeters);
        _updateCategory();
      });
    }
  }

  void _updateCategory() {
    if (_bmi < 18.5) {
      _category = 'Underweight';
    } else if (_bmi < 25) {
      _category = 'Normal weight';
    } else if (_bmi < 30) {
      _category = 'Overweight';
    } else {
      _category = 'Obesity';
    }
  }

  Color _getBMIColor() {
    if (_bmi < 18.5) return Colors.blue;
    if (_bmi < 25) return Colors.green;
    if (_bmi < 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(),
                        suffixText: 'cm',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        suffixText: 'kg',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Calculate BMI'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            if (_bmi > 0)
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Your BMI',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _bmi.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _getBMIColor(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _category,
                        style: TextStyle(
                          fontSize: 18,
                          color: _getBMIColor(),
                        ),
                      ),
                      SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: _bmi / 40, // Assuming max BMI of 40 for visualization
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(_getBMIColor()),
                        minHeight: 10,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Underweight\n<18.5', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                          Text('Normal\n18.5-24.9', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                          Text('Overweight\n25-29.9', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                          Text('Obesity\n30+', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI Categories:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    _buildCategoryInfo('Underweight', '< 18.5', Colors.blue),
                    _buildCategoryInfo('Normal weight', '18.5 - 24.9', Colors.green),
                    _buildCategoryInfo('Overweight', '25 - 29.9', Colors.orange),
                    _buildCategoryInfo('Obesity', '30 or greater', Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryInfo(String category, String range, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text('$category: $range'),
          ),
        ],
      ),
    );
  }
}
