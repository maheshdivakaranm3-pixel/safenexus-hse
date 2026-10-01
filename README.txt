Replace only:
lib/data/hse_reference/hse_topic_browser.dart

This removes the two range header blocks and the gap between ranges. Topics 01–50 render as one continuous numbered list, so topic 25 is followed immediately by topic 26.

Keep both existing topic data files unchanged. Then run Flutter Analyze and build/install a fresh APK to verify on device.
