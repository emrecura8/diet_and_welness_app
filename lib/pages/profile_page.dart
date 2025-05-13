import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/user_profile_service.dart';
import 'package:the_diet_and_welness_app/provider/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TODO: Load actual user data later (Firebase/Local)
  String _userEmail = "user@example.com";
  final _nameController = TextEditingController();
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
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    if (user == null) return;
    setState(() {
      _userEmail = user.email;
    });
    final profileService = Provider.of<UserProfileService>(
      context,
      listen: false,
    );
    await profileService.fetchUserProfile(user.id);
    final profile = profileService.userProfile;
    setState(() {
      _nameController.text = profile['name']?.toString() ?? '';
      _ageController.text = profile['age']?.toString() ?? '25';
      _weightController.text = profile['weight']?.toString() ?? '70';
      _heightController.text = profile['height']?.toString() ?? '175';
      _selectedGoal = profile['goal']?.toString() ?? 'Weight Loss';
      final bmi = profile['bmi'];
      if (bmi != null) {
        _bmiResult = "BMI: ${bmi.toStringAsFixed(1)}";
      } else {
        _bmiResult = null;
      }
    });
  }

  void _calculateAndShowBmi() {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightCm = double.tryParse(_heightController.text);

    if (weight != null && heightCm != null && heightCm > 0) {
      final double heightM = heightCm / 100.0;
      final double bmi = weight / (heightM * heightM);
      String bmiCategory;

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
        _bmiResult = null;
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = authService.currentUser;
      if (user == null) return;
      double? weight = double.tryParse(_weightController.text);
      double? heightCm = double.tryParse(_heightController.text);
      double? bmi;
      if (weight != null && heightCm != null && heightCm > 0) {
        double heightM = heightCm / 100.0;
        bmi = weight / (heightM * heightM);
        String bmiCategory;
        if (bmi < 18.5) {
          bmiCategory = "Underweight";
        } else if (bmi < 24.9) {
          bmiCategory = "Normal weight";
        } else if (bmi < 29.9) {
          bmiCategory = "Overweight";
        } else {
          bmiCategory = "Obesity";
        }
        if (bmi != null) {
          setState(() {
            _bmiResult =
                "BMI: " + (bmi?.toStringAsFixed(1) ?? "") + " ($bmiCategory)";
          });
        } else {
          setState(() {
            _bmiResult = null;
          });
        }
      } else {
        setState(() {
          _bmiResult = null;
        });
      }
      Map<String, dynamic> updatedData = {
        'name': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text) ?? 0,
        'weight': weight ?? 0.0,
        'height': heightCm ?? 0.0,
        'bmi': bmi,
        'goal': _selectedGoal,
      };
      final profileService = Provider.of<UserProfileService>(
        context,
        listen: false,
      );
      await profileService.updateUserProfile(user.id, updatedData);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved!')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? 'Enter your name'
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined),
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              _userEmail,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
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
