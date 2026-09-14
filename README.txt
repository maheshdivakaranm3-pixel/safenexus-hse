SafeNexus HSE — Dubai HSE 37 Topics ACTUAL-ID FIXED

ROOT CAUSE FIX:
The previous detail file used different topic IDs from the existing
lib/data/dubai_guidelines.dart. DubaiHseDetailPage therefore fell back to
the short ReferenceTopic description, so the detailed sections were not shown.

This version aligns all 37 _TopicData keys with the existing Dubai guideline IDs.

REPLACE ONLY:
lib/dubai_hse_detail_page.dart

DO NOT replace, append to, or modify:
lib/data/dubai_guidelines.dart

The detailed topic sections, tappable types/items, and single router are retained.
