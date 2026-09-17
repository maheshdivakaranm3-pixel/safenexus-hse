SafeNexus HSE — Abu Dhabi CoP 1.0 Advanced Interactive Pilot v1

Files included:
1. lib/abu_dhabi_hse_topic_page.dart
2. lib/data/abu_dhabi_hse_topics.dart
3. lib/data/abu_dhabi_hse_topic_content.dart

What changed:
- Existing 62-CoP master topic registry is preserved.
- Existing Abu Dhabi CoP content is preserved.
- CoP 1.0 now opens an advanced Study & Reference page.
- Each section is tappable and opens a second page.
- Each individual point is tappable and opens a micro-detail page.
- Other CoPs retain the existing page behavior.
- No new Dart file is required; the 3-file architecture is preserved.

Important:
- This is an interactive learning/navigation enhancement.
- It does not replace, delete, or silently rewrite Abu Dhabi regulatory requirements.
- Exact regulatory numbers/limits must be verified against the current official ADPHC CoP before compliance use.

Integration:
Replace the three corresponding files in the project. Do not delete the existing
abu_dhabi_guidelines.dart unless the complete migration has separately been verified.
