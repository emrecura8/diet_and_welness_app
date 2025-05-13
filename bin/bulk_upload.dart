import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final exercises = [
    {
      'name': 'Push-Up',
      'description':
          'A bodyweight exercise that works the chest, shoulders, and triceps.',
      'category': 'Strength',
    },
    {
      'name': 'Squat',
      'description':
          'A lower body exercise targeting the thighs, hips, and buttocks.',
      'category': 'Strength',
    },
    {
      'name': 'Plank',
      'description':
          'An isometric core strength exercise that involves maintaining a position.',
      'category': 'Core',
    },
    {
      'name': 'Jumping Jacks',
      'description': 'A full-body aerobic exercise that increases heart rate.',
      'category': 'Cardio',
    },
    {
      'name': 'Pull-Up',
      'description': 'An upper body exercise that targets the back and biceps.',
      'category': 'Strength',
    },
    {
      'name': 'Mountain Climbers',
      'description':
          'A full-body exercise that increases heart rate and strengthens the core.',
      'category': 'Cardio',
    },
    {
      'name': 'Lunges',
      'description': 'A lower body exercise that targets the legs and glutes.',
      'category': 'Strength',
    },
    {
      'name': 'Burpees',
      'description':
          'A full-body exercise that combines a squat, push-up, and jump.',
      'category': 'Cardio',
    },
    {
      'name': 'Bicycle Crunches',
      'description': 'A core exercise that targets the abs and obliques.',
      'category': 'Core',
    },
    {
      'name': 'Bench Press',
      'description':
          'A strength exercise for the chest, shoulders, and triceps using a barbell or dumbbells.',
      'category': 'Strength',
    },
    {
      'name': 'Deadlift',
      'description':
          'A compound movement that works the back, glutes, and hamstrings.',
      'category': 'Strength',
    },
    {
      'name': 'Shoulder Press',
      'description': 'A strength exercise for the shoulders and triceps.',
      'category': 'Strength',
    },
    {
      'name': 'Russian Twists',
      'description': 'A core exercise that targets the obliques.',
      'category': 'Core',
    },
    {
      'name': 'High Knees',
      'description':
          'A cardio exercise that increases heart rate and warms up the body.',
      'category': 'Cardio',
    },
    {
      'name': 'Tricep Dips',
      'description': 'A bodyweight exercise that targets the triceps.',
      'category': 'Strength',
    },
  ];

  final dietPlans = [
    {
      'name': 'High Protein Plan',
      'description':
          'Focuses on lean meats, eggs, and legumes to support muscle growth and repair.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Egg white omelette with spinach',
          'calories': 300,
        },
        {
          'type': 'Lunch',
          'name': 'Grilled chicken breast with quinoa',
          'calories': 450,
        },
        {
          'type': 'Dinner',
          'name': 'Salmon with steamed broccoli',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Mediterranean Diet',
      'description':
          'Emphasizes fruits, vegetables, whole grains, olive oil, and fish for heart health.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Greek yogurt with honey and walnuts',
          'calories': 350,
        },
        {
          'type': 'Lunch',
          'name': 'Grilled chicken salad with olive oil',
          'calories': 450,
        },
        {
          'type': 'Dinner',
          'name': 'Baked salmon with roasted vegetables',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Low Carb Diet',
      'description':
          'Reduces carbohydrate intake to promote fat loss and stabilize blood sugar.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Scrambled eggs with avocado',
          'calories': 320,
        },
        {'type': 'Lunch', 'name': 'Turkey lettuce wraps', 'calories': 400},
        {
          'type': 'Dinner',
          'name': 'Grilled steak with asparagus',
          'calories': 550,
        },
      ],
    },
    {
      'name': 'Vegetarian Plan',
      'description':
          'Excludes meat and fish, focusing on plant-based proteins and whole foods.',
      'meals': [
        {'type': 'Breakfast', 'name': 'Oatmeal with berries', 'calories': 280},
        {'type': 'Lunch', 'name': 'Chickpea salad sandwich', 'calories': 420},
        {
          'type': 'Dinner',
          'name': 'Vegetable stir-fry with tofu',
          'calories': 480,
        },
      ],
    },
    {
      'name': 'Balanced Diet',
      'description':
          'Includes a variety of foods from all food groups for overall health and wellness.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Whole grain toast with peanut butter',
          'calories': 300,
        },
        {
          'type': 'Lunch',
          'name': 'Turkey and cheese sandwich',
          'calories': 400,
        },
        {
          'type': 'Dinner',
          'name': 'Grilled chicken with brown rice and veggies',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Intermittent Fasting',
      'description':
          'Alternates periods of eating and fasting to promote weight loss and metabolic health.',
      'meals': [
        {'type': 'Lunch', 'name': 'Grilled fish with salad', 'calories': 450},
        {
          'type': 'Dinner',
          'name': 'Chicken stir-fry with vegetables',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Vegan Diet',
      'description':
          'Excludes all animal products, focusing on plant-based foods.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Smoothie bowl with almond milk',
          'calories': 320,
        },
        {
          'type': 'Lunch',
          'name': 'Lentil soup with whole grain bread',
          'calories': 400,
        },
        {
          'type': 'Dinner',
          'name': 'Quinoa and black bean salad',
          'calories': 480,
        },
      ],
    },
    {
      'name': 'Paleo Diet',
      'description':
          'Focuses on foods presumed to be available to Paleolithic humans.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Scrambled eggs with veggies',
          'calories': 300,
        },
        {
          'type': 'Lunch',
          'name': 'Grilled chicken with sweet potato',
          'calories': 450,
        },
        {
          'type': 'Dinner',
          'name': 'Beef stir-fry with vegetables',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Keto Diet',
      'description':
          'A very low-carb, high-fat diet that puts the body into ketosis.',
      'meals': [
        {'type': 'Breakfast', 'name': 'Cheese omelette', 'calories': 350},
        {'type': 'Lunch', 'name': 'Avocado chicken salad', 'calories': 450},
        {
          'type': 'Dinner',
          'name': 'Grilled salmon with spinach',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'DASH Diet',
      'description':
          'Dietary Approaches to Stop Hypertension, rich in fruits, vegetables, and low-fat dairy.',
      'meals': [
        {'type': 'Breakfast', 'name': 'Oatmeal with banana', 'calories': 280},
        {'type': 'Lunch', 'name': 'Turkey wrap with veggies', 'calories': 400},
        {
          'type': 'Dinner',
          'name': 'Grilled fish with steamed broccoli',
          'calories': 480,
        },
      ],
    },
    {
      'name': 'Gluten-Free Diet',
      'description':
          'Excludes gluten, suitable for people with celiac disease or gluten sensitivity.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Rice cakes with almond butter',
          'calories': 250,
        },
        {'type': 'Lunch', 'name': 'Quinoa salad with veggies', 'calories': 400},
        {
          'type': 'Dinner',
          'name': 'Grilled chicken with roasted potatoes',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Flexitarian Diet',
      'description': 'Primarily vegetarian with occasional meat or fish.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Greek yogurt with fruit',
          'calories': 300,
        },
        {
          'type': 'Lunch',
          'name': 'Vegetable soup with whole grain bread',
          'calories': 400,
        },
        {'type': 'Dinner', 'name': 'Grilled fish with salad', 'calories': 480},
      ],
    },
    {
      'name': 'Zone Diet',
      'description': 'Balances protein, carbs, and fat in a 30-40-30 ratio.',
      'meals': [
        {'type': 'Breakfast', 'name': 'Eggs and fruit', 'calories': 300},
        {'type': 'Lunch', 'name': 'Chicken salad with nuts', 'calories': 400},
        {
          'type': 'Dinner',
          'name': 'Grilled steak with veggies',
          'calories': 500,
        },
      ],
    },
    {
      'name': 'Raw Food Diet',
      'description': 'Focuses on uncooked and unprocessed foods.',
      'meals': [
        {'type': 'Breakfast', 'name': 'Fruit salad', 'calories': 250},
        {'type': 'Lunch', 'name': 'Raw veggie wrap', 'calories': 350},
        {
          'type': 'Dinner',
          'name': 'Zucchini noodles with tomato sauce',
          'calories': 400,
        },
      ],
    },
    {
      'name': 'Whole30',
      'description':
          'A 30-day diet that eliminates sugar, alcohol, grains, legumes, soy, and dairy.',
      'meals': [
        {
          'type': 'Breakfast',
          'name': 'Egg muffins with veggies',
          'calories': 300,
        },
        {
          'type': 'Lunch',
          'name': 'Chicken salad lettuce wraps',
          'calories': 400,
        },
        {
          'type': 'Dinner',
          'name': 'Grilled shrimp with roasted vegetables',
          'calories': 500,
        },
      ],
    },
  ];

  final firestore = FirebaseFirestore.instance;

  // Upload exercises
  for (final ex in exercises) {
    await firestore.collection('exercises').add(ex);
  }

  // Upload diet plans
  for (final plan in dietPlans) {
    await firestore.collection('dietPlans').add(plan);
  }

  print('Bulk upload complete!');
}
