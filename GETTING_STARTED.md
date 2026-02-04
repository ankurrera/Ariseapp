# Getting Started Checklist

This checklist helps you get the Arise app running on your machine.

## Prerequisites Checklist

### Required Software
- [ ] Flutter SDK 3.0.0+ installed
- [ ] Dart SDK installed (comes with Flutter)
- [ ] Android Studio or Xcode installed
- [ ] Git installed

### Verify Installation
```bash
# Check Flutter version
flutter --version

# Check if Flutter is properly set up
flutter doctor

# All required components should have green checkmarks
```

## Setup Checklist

### 1. Clone and Setup
- [ ] Clone the repository
  ```bash
  git clone https://github.com/ankurrera/Ariseapp.git
  cd Ariseapp
  ```

- [ ] Install dependencies
  ```bash
  flutter pub get
  ```

### 2. Configure Supabase

#### Option A: Create Your Own Supabase Project (Recommended)
- [ ] Go to https://supabase.com and create an account
- [ ] Create a new project
- [ ] Note down your project URL and anon key
- [ ] Run the SQL scripts from SETUP.md to create tables
- [ ] Configure Row Level Security policies
- [ ] Update `lib/config/supabase_config.dart` with your credentials

#### Option B: Use Environment Variables
- [ ] Copy `.env.example` to `.env`
- [ ] Fill in your Supabase credentials
- [ ] Run with:
  ```bash
  flutter run --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
  ```

### 3. Database Setup

- [ ] Log into your Supabase dashboard
- [ ] Go to SQL Editor
- [ ] Run the following SQL scripts (from SETUP.md):
  - [ ] Create `profiles` table
  - [ ] Create `habits` table
  - [ ] Create `skills` table
  - [ ] Create `characteristics` table
  - [ ] Enable Row Level Security on all tables
  - [ ] Create RLS policies

### 4. Test the Setup

- [ ] Connect a physical device or start an emulator
  ```bash
  # List available devices
  flutter devices
  ```

- [ ] Run the app
  ```bash
  flutter run
  ```

- [ ] App should launch and show the Auth screen

### 5. Test Authentication

- [ ] Try signing up with a test email
- [ ] Check Supabase Auth dashboard for the new user
- [ ] Try logging in with the credentials
- [ ] Verify you're redirected to the Dashboard

### 6. Verify Features

- [ ] Dashboard displays correctly
- [ ] Navigation drawer opens
- [ ] Navigate to Profile screen
- [ ] Navigate to Habits screen
- [ ] Navigate to Skills screen
- [ ] Navigate to Routines screen
- [ ] Logout works correctly

## Troubleshooting Checklist

### If Flutter is not found
- [ ] Add Flutter to your PATH
- [ ] Restart your terminal/IDE
- [ ] Run `flutter doctor` to diagnose issues

### If dependencies fail to install
- [ ] Check your internet connection
- [ ] Clear Flutter cache: `flutter clean`
- [ ] Try again: `flutter pub get`

### If Android build fails
- [ ] Accept Android licenses: `flutter doctor --android-licenses`
- [ ] Update Android SDK
- [ ] Check `android/app/build.gradle` for errors

### If Supabase connection fails
- [ ] Verify your credentials are correct
- [ ] Check if your Supabase project is active
- [ ] Ensure you have internet connection
- [ ] Check Supabase dashboard for any issues

### If app crashes on launch
- [ ] Check console logs for errors
- [ ] Verify all required dependencies are installed
- [ ] Try: `flutter clean && flutter pub get && flutter run`

## Development Checklist

### Before Making Changes
- [ ] Create a new branch: `git checkout -b feature/your-feature`
- [ ] Understand the existing code structure
- [ ] Read FEATURES.md for requirements

### While Developing
- [ ] Follow Dart style guide
- [ ] Write meaningful commit messages
- [ ] Test your changes on both Android and iOS (if possible)
- [ ] Add comments for complex logic

### Before Committing
- [ ] Format code: `dart format .`
- [ ] Analyze code: `flutter analyze`
- [ ] Run tests: `flutter test`
- [ ] Fix any linting errors

### Before Creating PR
- [ ] Update documentation if needed
- [ ] Add screenshots if UI changed
- [ ] Write a clear PR description
- [ ] Test on multiple devices/screen sizes

## Common Issues and Solutions

### Issue: "Package not found"
**Solution**: Run `flutter pub get` in the project root

### Issue: "SDK version conflict"
**Solution**: Update Flutter SDK or adjust `pubspec.yaml` constraints

### Issue: "Build failed - Gradle error"
**Solution**: 
1. Delete `android/.gradle` folder
2. Run `flutter clean`
3. Run `flutter pub get`
4. Try building again

### Issue: "Supabase auth not working"
**Solution**:
1. Check your Supabase credentials
2. Verify authentication is enabled in Supabase dashboard
3. Check RLS policies are set correctly

### Issue: "Hot reload not working"
**Solution**:
1. Try hot restart (press 'R' instead of 'r')
2. Stop and restart the app
3. Check for syntax errors

## Quick Commands Reference

```bash
# Install dependencies
flutter pub get

# Run app on connected device
flutter run

# Run with specific device
flutter run -d <device-id>

# Build APK
flutter build apk

# Run tests
flutter test

# Format code
dart format .

# Analyze code
flutter analyze

# Clean build files
flutter clean

# Check Flutter setup
flutter doctor

# List devices
flutter devices

# Update dependencies
flutter pub upgrade

# View logs
flutter logs
```

## Next Steps After Setup

Once the app is running:

1. **Explore the UI**
   - Navigate through all screens
   - Test the theme and styling
   - Check responsive layout

2. **Test Authentication**
   - Create an account
   - Log in and out
   - Check session persistence

3. **Explore the Code**
   - Read through the models
   - Understand the services
   - Review the widgets

4. **Read Documentation**
   - FEATURES.md for feature details
   - SCREENSHOTS.md for UI mockups
   - PROJECT_SUMMARY.md for architecture

5. **Start Contributing**
   - Pick a feature to implement
   - Create a branch
   - Make your changes
   - Submit a PR

## Need Help?

- Check the documentation files in the repository
- Search existing GitHub issues
- Create a new issue with detailed description
- Include error messages and screenshots

## Useful Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Supabase Documentation](https://supabase.com/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design Guidelines](https://material.io/design)

---

**Happy Coding!** 🚀

Once you've completed this checklist, you should have a working Arise app ready for development.
