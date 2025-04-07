import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: Load actual user data later (Firebase/Local)
  String _userEmail = "user@example.com";
  final _ageController = TextEditingController(text: '25');
  final _weightController = TextEditingController(text: '70');
  final _heightController = TextEditingController(text: '175');
  String _selectedGoal = 'Weight Loss';
  final List<String> _fitnessGoals = [
    'Weight Loss',
    'Muscle Gain',
    'Maintenance',
    'Fitness Improvement',
  ];

  final _formKey = GlobalKey<FormState>();
  String? _bmiResult;

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateAndShowBmi() {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);

    if (weight != null && heightCm != null && heightCm > 0) {
      final double heightM = heightCm / 100.0;
      final double bmi = weight / (heightM * heightM);
      String bmiCategory;
      // Basic BMI categories (adjust ranges as needed)
      if (bmi < 18.5) {
        bmiCategory = "Underweight";
      } else if (bmi < 24.9) {
        bmiCategory = "Normal weight";
      } else if (bmi < 29.9) {
        bmiCategory = "Overweight";
      } else {
        bmiCategory = "Obesity";
      }
      setState(() {
        _bmiResult = "BMI: ${bmi.toStringAsFixed(1)} ($bmiCategory)";
      });
    } else {
      setState(() {
        _bmiResult = null; // Clear result if inputs are invalid
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _calculateAndShowBmi();

      // TODO: Implement profile saving logic later (Firebase/Local)
      Map<String, dynamic> updatedData = {
        'age': int.tryParse(_ageController.text) ?? 0,
        'weight': double.tryParse(_weightController.text) ?? 0.0,
        'height': double.tryParse(_heightController.text) ?? 0.0,
        'goal': _selectedGoal,
      };
      print('Saving profile: $updatedData');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Update Placeholder: Saved!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Account Information',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined),
                      const SizedBox(width: 16),
                      Text(
                        _userEmail,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      // Add 'Edit' button later if needed
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Physical Details',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          suffixText: 'years',
                        ),
                        keyboardType: TextInputType.number,
                        validator:
                            (v) =>
                                (v == null ||
                                        v.isEmpty ||
                                        int.tryParse(v) == null ||
                                        int.parse(v) <= 0)
                                    ? 'Valid age?'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          labelText: 'Weight',
                          suffixText: 'kg',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator:
                            (v) =>
                                (v == null ||
                                        v.isEmpty ||
                                        double.tryParse(v) == null ||
                                        double.parse(v) <= 0)
                                    ? 'Valid weight?'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _heightController,
                        decoration: const InputDecoration(
                          labelText: 'Height',
                          suffixText: 'cm',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator:
                            (v) =>
                                (v == null ||
                                        v.isEmpty ||
                                        double.tryParse(v) == null ||
                                        double.parse(v) <= 0)
                                    ? 'Valid height?'
                                    : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Fitness Goal',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGoal,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                    ),
                    items:
                        _fitnessGoals
                            .map(
                              (String goal) => DropdownMenuItem<String>(
                                value: goal,
                                child: Text(goal),
                              ),
                            )
                            .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGoal = newValue!;
                      });
                    },
                    validator:
                        (v) => (v == null || v.isEmpty) ? 'Select goal' : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              if (_bmiResult != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _bmiResult!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save Profile & Calculate BMI'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
