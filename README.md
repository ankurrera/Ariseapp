# Arise App

Flutter-based Android app converted from Solo-Leveling web application with gamified fitness tracking.

## Features
- **Player Status System** - Level up your character as you complete workouts and habits
- **Habit Tracker** - Daily quests with heatmap visualization
- **Workout Sessions** - Live workout tracking with XP rewards
- **Skills System** - Track and level up various skills and characteristics
- **Gamified Goal Setting** - Quest cards and achievement tracking
- **Solo Leveling Theme** - Dark gaming aesthetic with glow effects

## Tech Stack
- **Flutter** - Cross-platform mobile framework
- **Supabase** - Backend and authentication
- **Riverpod** - State management
- **go_router** - Navigation
- **fl_chart** - Data visualization
- **Google Fonts** - Typography (Rajdhani, Inter)

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ankurrera/Ariseapp.git
cd Ariseapp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Supabase:
   - Create a Supabase project at https://supabase.com
   - Update `lib/config/supabase_config.dart` with your credentials
   - Or use environment variables:
```bash
flutter run --dart-define=SUPABASE_URL=your-url --dart-define=SUPABASE_ANON_KEY=your-key
```

4. Run the app:
```bash
flutter run
```

## Project Structure
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Main app widget
├── config/                   # Configuration files
│   ├── theme.dart           # Solo Leveling theme
│   ├── routes.dart          # Navigation routes
│   └── supabase_config.dart # Supabase credentials
├── models/                   # Data models
├── services/                 # API services
├── providers/                # State management
├── screens/                  # App screens
└── widgets/                  # Reusable widgets
```

## Screens
- **Auth** - Hunter login/awakening (signup)
- **Dashboard** - Main player status screen
- **Profile** - Player class selection and settings
- **Habits** - Daily quests and habit tracking
- **Skills** - Skills and characteristics management
- **Routines** - Workout routine creation and management

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License.

## Acknowledgments
- Inspired by Solo Leveling anime/manga
- Original web app: [Solo-Leveling](https://github.com/ankurrera/Solo-Leveling)
