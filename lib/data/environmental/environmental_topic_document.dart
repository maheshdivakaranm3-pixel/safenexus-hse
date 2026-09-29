// Shared data model for SafeNexus HSE Environmental Reference.
class EnvironmentalTopicDocument {
  final int number;
  final String title;
  final String definition;
  final String purpose;
  final String regulatoryBasis;
  final String procedure;
  final String documents;
  final String documentOwnership;
  final String verification;
  final String commonErrors;
  final String fieldExample;
  final String checklist;
  final String interview;
  const EnvironmentalTopicDocument({required this.number, required this.title, required this.definition, required this.purpose, required this.regulatoryBasis, required this.procedure, required this.documents, required this.documentOwnership, required this.verification, required this.commonErrors, required this.fieldExample, required this.checklist, required this.interview});
  String get opening => 'What is $title?\n$definition\n\nPurpose\n$purpose';
}
