# NDK Version Management

## Overview
This project uses a configuration-based approach to manage the Android NDK version, avoiding hardcoded values in build files.

## Configuration
The NDK version is configured in `android/ndk-version.properties`:

```properties
# NDK Version Configuration
# Update this version when needed to match plugin requirements
# Available versions: 23.2.8568313, 26.3.11579264, 27.0.12077973
ndk.version=27.0.12077973
```

## How It Works
1. The `android/app/build.gradle.kts` file reads the NDK version from `ndk-version.properties`
2. If the file doesn't exist, it falls back to Flutter's default NDK version
3. This approach allows easy version updates without modifying build scripts

## Updating NDK Version
When you need to update the NDK version:

1. **Check available versions:**
   ```bash
   ls -la $ANDROID_HOME/ndk/
   ```

2. **Update the configuration:**
   Edit `android/ndk-version.properties` and change the `ndk.version` value

3. **Clean and rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk --debug
   ```

## Benefits
- ✅ **No hardcoded values** in build scripts
- ✅ **Easy to update** - just change one file
- ✅ **Version controlled** - changes are tracked in git
- ✅ **Fallback support** - uses Flutter default if config file is missing
- ✅ **Documentation** - comments explain available versions

## Troubleshooting
If you encounter NDK version mismatch warnings:
1. Check which plugins require which NDK versions
2. Update to the highest required version
3. Ensure the version exists in your Android SDK: `ls $ANDROID_HOME/ndk/`
4. Clean and rebuild the project
