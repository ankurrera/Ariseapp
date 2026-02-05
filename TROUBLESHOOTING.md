# Troubleshooting Guide for Arise App

## 400 Bad Request Errors

### Overview
The application includes comprehensive error handling and logging to help identify and fix 400 Bad Request errors quickly.

### Common Causes

#### 1. Invalid Supabase Configuration (Most Common)
**Symptoms:**
- Console shows: `Failed to load resource: the server responded with a status of 400 ()`
- App displays error messages when trying to sign in/up
- Debug console shows: `⚠️ 400 Bad Request Error: Check Supabase configuration`

**Solution:**
The app now automatically detects this issue at startup. Look for this message in the console:
```
⚠️ WARNING: Supabase Configuration Error ⚠️
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Supabase URL is not configured. Please set SUPABASE_URL environment variable
or update lib/config/supabase_config.dart
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Fix Options:**

**Option A: Environment Variables (Recommended)**
```bash
flutter run \
  --dart-define=SUPABASE_URL=https://yourproject.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-actual-anon-key-here
```

**Option B: Direct Configuration**
Edit `lib/config/supabase_config.dart`:
```dart
class SupabaseConfig {
  static const String url = 'https://yourproject.supabase.co';
  static const String anonKey = 'your-actual-anon-key-here';
}
```

⚠️ **Important**: Never commit actual credentials to version control!

#### 2. Missing Database Tables
**Symptoms:**
- Console shows: `⚠️ 400 Bad Request Error: Check Supabase configuration and database setup`
- Specific operation fails (e.g., fetching habits, creating skills)

**Solution:**
Ensure all required tables exist in your Supabase project:
- `profiles` table
- `habits` table
- `skills` table
- `characteristics` table

Refer to `SETUP.md` for the complete database schema.

#### 3. Invalid Request Payload
**Symptoms:**
- Console shows: `⚠️ 400 Bad Request Error: Check request payload format`
- Debug log includes the data being sent

**Solution:**
1. Check the debug console for the logged payload
2. Verify the data matches the expected schema
3. Ensure required fields are present
4. Check data types match (string, int, etc.)

### Understanding Debug Logs

The app now includes comprehensive logging with emojis for easy identification:

#### Operation Symbols
- 🔐 Authentication operations (sign in/up/out)
- 📋 Fetching data (profiles, habits, skills)
- 📝 Creating/updating data
- 🗑️ Deleting data
- ⭐ Progress/XP operations
- 💪 Stat allocation
- 🎭 Class changes
- ✅ Completing habits
- ❌ Uncompleting habits

#### Status Symbols
- ✓ Operation successful
- ✗ Operation failed
- ⚠️ Warning message
- ℹ️ Information message
- 🎉 Level up or achievement

#### Example Debug Output
```
🔐 Attempting sign in for: user@example.com
✓ Sign in successful for: user@example.com
📋 Fetching user profile for: user-id-123
✓ Profile fetched successfully
⭐ Adding 50 XP to user: user-id-123
🎉 Level up! New level: 5
✓ XP added successfully. New level: 5, XP: 25/150
```

#### Error Example
```
🔐 Attempting sign in for: user@example.com
✗ Sign in failed: AuthException(statusCode: 400, message: Invalid request)
⚠️ 400 Bad Request Error: Check Supabase configuration
   Make sure SUPABASE_URL and SUPABASE_ANON_KEY are set correctly
```

### Step-by-Step Debugging Process

1. **Check Console at Startup**
   - Look for the configuration validation message
   - If you see a warning, fix the Supabase configuration first

2. **Monitor Debug Logs**
   - Watch for operation start messages (🔐, 📋, etc.)
   - Check if operations complete successfully (✓) or fail (✗)

3. **Identify the Failing Operation**
   - Note which specific API call is failing
   - Check the error message for specific guidance

4. **Review Request Details**
   - Failed operations log the data being sent
   - Verify the format matches database expectations

5. **Fix and Retry**
   - Apply the suggested fix from the error message
   - Hot reload or restart the app
   - Monitor logs to confirm the fix

### Best Practices

1. **Always Enable Debug Mode During Development**
   ```bash
   flutter run --debug
   ```

2. **Check Logs Regularly**
   - Debug logs are your friend
   - They provide detailed information about what's happening

3. **Keep Supabase Dashboard Open**
   - Monitor your Supabase project dashboard
   - Check for API usage and errors
   - Review database structure

4. **Use Environment Variables**
   - Never hardcode credentials in source files
   - Use environment variables for sensitive data
   - Keep `.env` files out of version control

5. **Test Incrementally**
   - Test each feature after implementation
   - Verify API calls work before moving on
   - Check logs after each operation

### Additional Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Flutter Error Handling](https://docs.flutter.dev/testing/errors)
- [Debugging Flutter Apps](https://docs.flutter.dev/testing/debugging)

### Getting Help

If you're still experiencing issues:

1. **Gather Information**
   - Copy the error messages from the console
   - Note which operation is failing
   - Include your Flutter and Dart versions

2. **Check Existing Issues**
   - Search GitHub issues for similar problems
   - Check if there's already a solution

3. **Create a New Issue**
   - Include all debug output
   - Describe what you were trying to do
   - Mention any configuration changes you made

4. **Contact Support**
   - Create a detailed GitHub issue
   - Include screenshots if relevant
   - Be specific about when the error occurs
