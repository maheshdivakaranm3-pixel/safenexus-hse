import 'abu_dhabi_hse_topic_content.dart';

class AbuDhabiHseTopic {
  final String id, number, title, version, effectiveDate, category;
  const AbuDhabiHseTopic({
    required this.id, required this.number, required this.title,
    required this.version, required this.effectiveDate, required this.category,
  });
  String get source => 'ADPHC Code of Practices — $number';
  AbuDhabiHseTopicContent get content =>
      abuDhabiHseTopicContent[id] ?? const AbuDhabiHseTopicContent();
}

const String abuDhabiHseOfficialSource =
    'https://www.adphc.gov.ae/en/Legislation/Code-of-Practices';

const List<AbuDhabiHseTopic> abuDhabiHseTopics = [
  AbuDhabiHseTopic(id: 'ad_cop_1_0', number: '1.0', title: 'Hazardous Materials', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Chemical & Hazardous Materials'),
  AbuDhabiHseTopic(id: 'ad_cop_1_1', number: '1.1', title: 'Management of Asbestos Containing Materials', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Chemical & Hazardous Materials'),
  AbuDhabiHseTopic(id: 'ad_cop_1_2', number: '1.2', title: 'Lead Exposure Management', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Chemical & Hazardous Materials'),
  AbuDhabiHseTopic(id: 'ad_cop_2_0', number: '2.0', title: 'Personal Protective Equipment', version: 'V4.0', effectiveDate: '15 July 2024', category: 'General Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_3_0', number: '3.0', title: 'Occupational Noise', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_3_1', number: '3.1', title: 'Vibration', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_4_0', number: '4.0', title: 'First Aid and Medical Emergency Treatment', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Emergency & Medical'),
  AbuDhabiHseTopic(id: 'ad_cop_5_0', number: '5.0', title: 'Occupational Health Screening and Medical Surveillance', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_8_0', number: '8.0', title: 'General Workplace Amenities', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Workplace Welfare'),
  AbuDhabiHseTopic(id: 'ad_cop_9_0', number: '9.0', title: 'Workplace Wellness', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_9_1', number: '9.1', title: 'New and Expectant Mothers', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_9_2', number: '9.2', title: 'Managing Work-Related Stress', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_10_0', number: '10.0', title: 'Rehabilitation and Return to Work', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_11_0', number: '11.0', title: 'Safety in the Heat', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Heat Stress'),
  AbuDhabiHseTopic(id: 'ad_cop_12_0', number: '12.0', title: 'Prevention and Control of Legionnaires Disease', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_13_0', number: '13.0', title: 'Violence in the Workplace', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Workplace Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_14_0', number: '14.0', title: 'Manual Handling and Ergonomics', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Ergonomics'),
  AbuDhabiHseTopic(id: 'ad_cop_14_1', number: '14.1', title: 'Manual Tasks Involving the Handling of People', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Ergonomics'),
  AbuDhabiHseTopic(id: 'ad_cop_15_0', number: '15.0', title: 'Electrical Safety', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Electrical Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_16_0', number: '16.0', title: 'OSH Requirements for People with Special Needs', version: 'V4.0', effectiveDate: '15 July 2024', category: 'General Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_17_0', number: '17.0', title: 'Safety Signage and Signals', version: 'V4.0', effectiveDate: '15 July 2024', category: 'General Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_18_0', number: '18.0', title: 'Employer Supplied Accommodation-General Requirements', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Worker Welfare'),
  AbuDhabiHseTopic(id: 'ad_cop_18_1', number: '18.1', title: 'Temporary Employer Supplied Accommodation', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Worker Welfare'),
  AbuDhabiHseTopic(id: 'ad_cop_19_0', number: '19.0', title: 'Occupational Food Handling and Food Preparation Areas', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Worker Welfare'),
  AbuDhabiHseTopic(id: 'ad_cop_20_0', number: '20.0', title: 'Safety in Design (Construction)', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_21_0', number: '21.0', title: 'Permit to Work Systems', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Work Control'),
  AbuDhabiHseTopic(id: 'ad_cop_22_0', number: '22.0', title: 'Barricading of Hazards', version: 'V4.0', effectiveDate: '15 July 2024', category: 'General Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_23_0', number: '23.0', title: 'Working at Heights', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_24_0', number: '24.0', title: 'Lock-out - Tag out (Isolation)', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Work Control'),
  AbuDhabiHseTopic(id: 'ad_cop_25_0', number: '25.0', title: 'Driver Fatigue Prevention', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Transport Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_26_0', number: '26.0', title: 'Scaffolding', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_27_0', number: '27.0', title: 'Confined Spaces', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_28_0', number: '28.0', title: 'Hot Work Operations (e.g Welding and Cutting)', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_29_0', number: '29.0', title: 'Excavation Work', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_30_0', number: '30.0', title: 'Lone Working and/or in Remote Locations', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Workplace Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_30_1', number: '30.1', title: 'Working in International Locations', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Workplace Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_31_0', number: '31.0', title: 'Working on, Over or Adjacent to Water', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_33_0', number: '33.0', title: 'Working On or Adjacent to a Road', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Transport & Road Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_33_1', number: '33.1', title: 'Traffic Incident Site Management', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Transport & Road Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_34_0', number: '34.0', title: 'Safe Use of Lifting Equipment and Lifting Accessories', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Lifting Operations'),
  AbuDhabiHseTopic(id: 'ad_cop_35_0', number: '35.0', title: 'Portable Power Tools', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Plant & Tools'),
  AbuDhabiHseTopic(id: 'ad_cop_36_0', number: '36.0', title: 'Plant and Equipment', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Plant & Equipment'),
  AbuDhabiHseTopic(id: 'ad_cop_37_0', number: '37.0', title: 'Ladders', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_38_0', number: '38.0', title: 'Concrete Placing Equipment', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_39_0', number: '39.0', title: 'Overhead and Underground Services', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_40_0', number: '40.0', title: 'False Work (Formwork)', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_41_0', number: '41.0', title: 'Steel Erection', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_42_0', number: '42.0', title: 'Pre Cast Construction', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_43_0', number: '43.0', title: 'Temporary Structures', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_44_0', number: '44.0', title: 'Traffic Management and Logistics', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Transport & Road Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_45_0', number: '45.0', title: 'Underwater Activities', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Specialist Work'),
  AbuDhabiHseTopic(id: 'ad_cop_46_0', number: '46.0', title: 'Underground Construction', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_46_1', number: '46.1', title: 'Construction of Water Wells', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Construction Safety'),
  AbuDhabiHseTopic(id: 'ad_cop_47_0', number: '47.0', title: 'Machine Guarding', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Plant & Equipment'),
  AbuDhabiHseTopic(id: 'ad_cop_48_0', number: '48.0', title: 'Spray Finishing', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Chemical & Hazardous Materials'),
  AbuDhabiHseTopic(id: 'ad_cop_49_0', number: '49.0', title: 'Compressed Gases and Air', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Plant & Equipment'),
  AbuDhabiHseTopic(id: 'ad_cop_50_0', number: '50.0', title: 'Abrasive Blasting and Associated Protective Coating Work', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Chemical & Hazardous Materials'),
  AbuDhabiHseTopic(id: 'ad_cop_51_0', number: '51.0', title: 'Powered Lift Trucks', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Plant & Equipment'),
  AbuDhabiHseTopic(id: 'ad_cop_52_0', number: '52.0', title: 'Local Exhaust Ventilation', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'Occupational Health'),
  AbuDhabiHseTopic(id: 'ad_cop_53_0', number: '53.0', title: 'OSH Management During Construction Work', version: 'V4.0', effectiveDate: '15 July 2024', category: 'OSH Management'),
  AbuDhabiHseTopic(id: 'ad_cop_53_1', number: '53.1', title: 'OSH Construction Management Plan', version: 'V4.1', effectiveDate: '27 Feb 2026', category: 'OSH Management'),
  AbuDhabiHseTopic(id: 'ad_cop_54_0', number: '54.0', title: 'Waste Management', version: 'V4.0', effectiveDate: '15 July 2024', category: 'Environmental HSE'),
];

final Map<String, AbuDhabiHseTopic> abuDhabiHseTopicById = {
  for (final topic in abuDhabiHseTopics) topic.id: topic,
};
