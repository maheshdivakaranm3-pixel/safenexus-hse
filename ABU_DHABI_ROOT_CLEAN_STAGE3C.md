# Abu Dhabi Gold Root — Stage 3C Cleanup

## Runtime root change

The legacy `AbuDhabiGenericGoldStandardPage` path has been removed from
`lib/abu_dhabi_hse_topic_page.dart`.

Runtime is now:

Abu Dhabi topic -> Gold router -> dedicated Gold module
                         -> new `AbuDhabiGoldRootPage` for topics without a dedicated module

CoP 29.0 remains on the dedicated Excavation Gold page.

## Removed legacy source

- `lib/data/abu_dhabi_hse_topic_content.dart`
- `AbuDhabiGenericGoldStandardPage`
- `AbuDhabiGenericGoldSectionPage`
- `_GenericSection`

The registry file `lib/data/abu_dhabi_hse_topics.dart` is retained. Existing Gold
data modules are retained; this cleanup does not delete their content.
