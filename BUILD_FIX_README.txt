SafeNexus HSE - BUILD FIX

Root cause found in GitHub Actions #1067:
flutter analyze = No issues found.
APK build fails in transitive objective_c 9.6.1 native-assets hook:
  Error: Member not found: 'arm64e'.

Fix:
Add dependency_overrides:
  path_provider_foundation: 2.5.1

Replace ONLY the repository root pubspec.yaml.
Do not change Steps 153/154 or other Dart files.
Do not change Gradle/AGP/Kotlin for this fix; their messages are warnings only.

Then run GitHub Actions again and verify Analyze + Build APK.
