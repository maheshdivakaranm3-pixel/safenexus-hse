class AbuDhabiHseTopicContent {
  final String overview;
  final List<String> keyAreas;
  final List<String> fieldPractice;
  final List<String> records;
  final List<String> verificationNotes;

  const AbuDhabiHseTopicContent({
    this.overview = 'Detailed regulatory content must be populated from the current official ADPHC CoP source before regulatory lock.',
    this.keyAreas = const [],
    this.fieldPractice = const [],
    this.records = const [],
    this.verificationNotes = const [],
  });
}

final Map<String, AbuDhabiHseTopicContent> abuDhabiHseTopicContent = {
  'ad_cop_29_0': const AbuDhabiHseTopicContent(
    overview: 'Excavation Work — Abu Dhabi ADPHC CoP 29.0, V4.1.',
    keyAreas: [
      'Planning and competent-person control',
      'Ground conditions and excavation stability',
      'Underground services and safe excavation',
      'Access, egress, barricading and public protection',
      'Inspection, emergency response and records',
    ],
    fieldPractice: [
      'Verify approved information, permits/NOCs and service locations before excavation.',
      'Control unsupported excavation faces and protect workers from collapse and falling materials.',
      'Provide safe access and egress and maintain effective edge protection.',
      'Inspect and record findings in accordance with the current CoP.',
    ],
    records: [
      'Risk assessment / method statement',
      'Permit and NOC records where applicable',
      'Inspection and examination records',
      'Training / competency records',
      'Emergency arrangements',
    ],
    verificationNotes: [
      'Use the current official ADPHC CoP 29.0 PDF for exact numeric and technical requirements.',
      'Do not transfer Dubai requirements into Abu Dhabi requirements.',
    ],
  ),
};
