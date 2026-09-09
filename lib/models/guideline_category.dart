/// ============================================================
/// SafeNexus HSE
/// Guideline Category Model
///
/// Central category definition for all HSE references.
///
/// Categories:
/// - All
/// - UAE General
/// - Abu Dhabi
/// - Dubai
/// - HSE Reference
///
/// This enum is shared by:
/// - guidelines.dart
/// - reference_topic.dart
/// - guideline_detail_page.dart
/// - UAE guideline data files
/// - Abu Dhabi guideline data files
/// - Dubai guideline data files
/// - HSE reference data files
/// ============================================================

enum GuidelineCategory {
// ============================================================
// ALL
// ============================================================

/// Shows all available HSE guideline topics.
all,

// ============================================================
// UAE GENERAL
// ============================================================

/// UAE-wide general HSE guidance.
///
/// Use this category for guidance applicable across
/// the United Arab Emirates.
uaeGeneral,

// ============================================================
// ABU DHABI
// ============================================================

/// Abu Dhabi-specific HSE requirements and guidance.
///
/// Examples may include ADOSH-related references.
abuDhabi,

// ============================================================
// DUBAI
// ============================================================

/// Dubai-specific HSE requirements and guidance.
dubai,

// ============================================================
// HSE REFERENCE
// ============================================================

/// Professional HSE reference topics.
///
/// This category is intended for general professional
/// HSE knowledge and reference material.
hseReference,
}
