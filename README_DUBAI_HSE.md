SafeNexus HSE - Dubai HSE Topic Options v6 FIXED

Fixes the v6 analyze errors:
- Adds the missing const _TopicDetail model.
- Adds DubaiHseTopicRouter.pageFor used by guidelines.dart.
- Keeps 37 topic-specific section lists and clickable detail pages.

Replace only:
lib/dubai_hse_detail_page.dart

No change is required to dubai_guidelines.dart. If your current guidelines.dart already uses DubaiHseTopicRouter.pageFor(topic), it will now resolve correctly.
