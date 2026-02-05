# Setup Guide for Arise App

## Overview
This guide will help you set up and run the Arise Flutter app, which is converted from the Solo-Leveling web application.

## Prerequisites

### Required Software
1. **Flutter SDK** (3.0.0 or higher)
   - Download from: https://docs.flutter.dev/get-started/install
   - Add Flutter to your PATH
   - Verify installation: `flutter --version`

2. **Dart SDK** (comes with Flutter)
   - Verify: `dart --version`

3. **Android Studio** (for Android development)
   - Download from: https://developer.android.com/studio
   - Install Android SDK
   - Set up an Android emulator or connect a physical device

4. **Git**
   - Download from: https://git-scm.com/downloads

### Optional Tools
- **VS Code** with Flutter extension
- **Xcode** (for iOS development on macOS)

## Initial Setup

### 1. Clone the Repository
```bash
git clone https://github.com/ankurrera/Ariseapp.git
cd Ariseapp
```

### 2. Install Dependencies
```bash
flutter pub get
```

This will install all required packages defined in `pubspec.yaml`:
- flutter_riverpod (state management)
- supabase_flutter (backend/auth)
- go_router (navigation)
- fl_chart (charts)
- table_calendar (calendar widget)
- google_fonts (typography)
- And more...

### 3. Configure Supabase

#### Option A: Environment Variables (Recommended for Production)
```bash
# Create a .env file (not tracked by git)
echo "SUPABASE_URL=https://your-project.supabase.co" > .env
echo "SUPABASE_ANON_KEY=your-anon-key-here" >> .env

# Run with environment variables
flutter run --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
```

#### Option B: Direct Configuration (Development Only)
Edit `lib/config/supabase_config.dart`:
```dart
class SupabaseConfig {
  static const String url = 'https://your-project.supabase.co';
  static const String anonKey = 'your-anon-key';
}
```

⚠️ **Warning**: Do not commit your actual Supabase credentials to version control!

### 4. Set Up Supabase Database

You'll need to create the following tables in your Supabase project:

#### profiles table
```sql
create table profiles (
  id uuid references auth.users primary key,
  email text not null,
  display_name text,
  avatar_url text,
  player_class text default 'Warrior',
  level integer default 1,
  current_xp integer default 0,
  xp_to_next_level integer default 100,
  skill_points integer default 0,
  stats jsonb default '{"strength": 10, "agility": 10, "intelligence": 10, "vitality": 10, "sense": 10}',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Enable RLS
alter table profiles enable row level security;

-- Policies
create policy "Users can view own profile"
  on profiles for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on profiles for update
  using (auth.uid() = id);
```

#### habits table
```sql
create table habits (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id) on delete cascade not null,
  title text not null,
  description text,
  category text default 'general',
  xp_reward integer default 10,
  completion_history jsonb default '{}',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Enable RLS
alter table habits enable row level security;

-- Policies
create policy "Users can view own habits"
  on habits for select
  using (auth.uid() = user_id);

create policy "Users can create habits"
  on habits for insert
  with check (auth.uid() = user_id);

create policy "Users can update own habits"
  on habits for update
  using (auth.uid() = user_id);

create policy "Users can delete own habits"
  on habits for delete
  using (auth.uid() = user_id);
```

#### skills table
```sql
create table skills (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id) on delete cascade not null,
  name text not null,
  description text,
  category text default 'general',
  level integer default 1,
  current_progress integer default 0,
  max_progress integer default 100,
  icon_name text default 'default',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Enable RLS
alter table skills enable row level security;

-- Policies (similar to habits)
create policy "Users can view own skills"
  on skills for select
  using (auth.uid() = user_id);

create policy "Users can create skills"
  on skills for insert
  with check (auth.uid() = user_id);

create policy "Users can update own skills"
  on skills for update
  using (auth.uid() = user_id);

create policy "Users can delete own skills"
  on skills for delete
  using (auth.uid() = user_id);
```

#### characteristics table
```sql
create table characteristics (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id) on delete cascade not null,
  name text not null,
  description text,
  level integer default 1,
  max_level integer default 10,
  stat_type text not null,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- Enable RLS and policies (similar to above)
alter table characteristics enable row level security;
```

### 5. Verify Flutter Setup
```bash
flutter doctor
```

Ensure all checkmarks are green for your target platform (Android/iOS).

## Running the App

### Development Mode
```bash
# Run on connected device or emulator
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run with hot reload enabled (default)
flutter run --hot
```

### Debug Mode Features
- Hot reload: Press `r` in the terminal
- Hot restart: Press `R`
- Open DevTools: Press `w`
- Quit: Press `q`

### Release Mode
```bash
# Build APK for Android
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release

# Install on device
flutter install
```

## Common Issues and Solutions

### Issue: 400 Bad Request Error
**Symptom**: Console shows "Failed to load resource: the server responded with a status of 400 ()"

**Root Cause**: Invalid or placeholder Supabase credentials

**Solution**:
1. The app now validates Supabase configuration at startup
2. Check the console/debug output for detailed error messages:
   ```
   ⚠️ WARNING: Supabase Configuration Error ⚠️
   Supabase URL is not configured. Please set SUPABASE_URL environment variable...
   ```
3. Follow the instructions in the error message to fix the configuration
4. Make sure you've replaced placeholder values in `lib/config/supabase_config.dart`:
   - Replace `https://your-project.supabase.co` with your actual Supabase project URL
   - Replace `your-anon-key` with your actual Supabase anon key
5. Or run with environment variables:
   ```bash
   flutter run --dart-define=SUPABASE_URL=https://your-actual-url.supabase.co --dart-define=SUPABASE_ANON_KEY=your-actual-key
   ```

**Debug Information**: 
- All API operations now include detailed logging with emojis for easy identification
- Look for ✗ (error) and ⚠️ (warning) symbols in the console
- Each API call logs its start (🔐, 📋, 📝, etc.) and completion (✓) or failure (✗)

### Issue: Flutter not recognized
**Solution**: Add Flutter to your system PATH
```bash
# macOS/Linux
export PATH="$PATH:`pwd`/flutter/bin"

# Windows
# Add to System Environment Variables
```

### Issue: Android licenses not accepted
**Solution**:
```bash
flutter doctor --android-licenses
```

### Issue: Gradle build fails
**Solution**:
1. Clear Flutter cache: `flutter clean`
2. Get dependencies: `flutter pub get`
3. Try again: `flutter run`

### Issue: Supabase connection error
**Solution**:
1. Check your internet connection
2. Verify Supabase credentials are correct
3. Check if your Supabase project is active
4. Review Supabase dashboard for any issues
5. Check the debug console for detailed error messages

## Development Workflow

### 1. Make Changes
Edit files in the `lib/` directory

### 2. Hot Reload
Press `r` in the terminal to see changes instantly (for UI changes)

### 3. Hot Restart
Press `R` for full restart (for logic changes)

### 4. Test Your Changes
```bash
flutter test
```

### 5. Check Code Quality
```bash
# Analyze code
flutter analyze

# Format code
dart format .
```

## Project Structure
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Main app widget
├── config/                   # Configuration
│   ├── theme.dart           # Solo Leveling theme
│   ├── routes.dart          # Navigation routes
│   └── supabase_config.dart # Backend config
├── models/                   # Data models
├── services/                 # API/business logic
├── providers/                # State management
├── screens/                  # App screens
├── widgets/                  # Reusable widgets
└── utils/                    # Helper functions
```

## Next Steps

1. **Customize the UI**: Modify widgets in `lib/widgets/`
2. **Add Features**: Implement remaining screens
3. **Test**: Write tests in `test/`
4. **Deploy**: Build and publish to app stores

## Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Supabase Documentation](https://supabase.com/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Original Web App](https://github.com/ankurrera/Solo-Leveling)

## Support

For issues or questions:
1. Check existing GitHub issues
2. Create a new issue with detailed description
3. Include error messages and screenshots

Happy coding! 🚀
