import 'package:flutter/material.dart';

import 'chemical_environment.dart';
import 'daily_hse_work.dart';
import 'equipment_machinery.dart';
import 'emergency_management.dart';
import 'hira_risk_assessment.dart';
import 'high_risk_activities.dart';
import 'hse_management_plan.dart';
import 'hse_reporting.dart';
import 'incident_management.dart';
import 'inspection_audit.dart';
import 'legal_authority.dart';
import 'occupational_health.dart';
import 'ptw_master_register.dart';
import 'site_mobilization_master_register.dart';
import 'workforce_master_register.dart';
import 'data/hse_work_categories.dart';
import 'models/hse_work_categories.dart';
import 'project_pre_start.dart';
import 'workhub_company_daylog.dart';
import 'safenexus_integration_center.dart';
import 'safenexus_unified_data_center.dart';
import 'hse_document_evidence_center.dart';
import 'hse_risk_control_center.dart';
import 'hse_contractor_supplier.dart';
import 'safenexus_steps51_60_advanced_hse.dart';
import 'safenexus_steps61_70_advanced_operations_intelligence.dart';
import 'safenexus_steps71_80_digital_ecosystem_enterprise_intelligence.dart';
import 'safenexus_steps81_90_ai_automation_decision_intelligence.dart';
import 'safenexus_steps91_100_ultimate_hse_enterprise.dart';
import 'safenexus_step112_record_linkage.dart';
import 'safenexus_step113_evidence_hub.dart';
import 'safenexus_step101_master_integration.dart';
import 'safenexus_step102_master_navigation_integration_hub.dart';
import 'safenexus_step103_unified_workflow_orchestration.dart';
import 'safenexus_step104_unified_evidence_intelligence.dart';
import 'safenexus_step105_unified_risk_control_evidence.dart';
import 'safenexus_step106_workhub_navigation_integration.dart';
import 'safenexus_step107_unified_data_record_linking.dart';
import 'safenexus_step108_cross_module_workflow_integration.dart';
import 'safenexus_step109_global_hse_dashboard_intelligence.dart';
import 'safenexus_step110_final_system_integration_release_readiness.dart';
import 'safenexus_step115_record_search_filter.dart';
import 'safenexus_step116_record_detail_review.dart';
import 'safenexus_step117_125_record_intelligence.dart';

/// SafeNexus WorkHub
///
/// Step 112 integration:
/// - Existing WorkHub lifecycle navigation remains unchanged.
/// - Company & Daily Work Log remains unchanged.
/// - New Daily Work Record Linkage opens the Step 112 linkage layer.
/// - Source modules remain the system of record.
class WorkHubPage extends StatelessWidget {
  const WorkHubPage({super.key});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<_WorkHubPhase> _phases = <_WorkHubPhase>[
    _WorkHubPhase(
      1,
      Icons.folder_copy_outlined,
      'Project Pre-Start',
      'Project information & setup',
    ),
    _WorkHubPhase(
      2,
      Icons.assignment_outlined,
      'HSE Management System',
      'Policy, plan, KPI & procedures',
    ),
    _WorkHubPhase(
      3,
      Icons.warning_amber_outlined,
      'Risk & Planning',
      'HIRA, JSA, JHA, RAMS & risks',
    ),
    _WorkHubPhase(
      4,
      Icons.fact_check_outlined,
      'Permit to Work',
      'PTW & work permits',
    ),
    _WorkHubPhase(
      5,
      Icons.home_work_outlined,
      'Site Mobilization',
      'Site setup, welfare & access',
    ),
    _WorkHubPhase(
      6,
      Icons.groups_outlined,
      'Workforce & Competency',
      'Induction, training & competency',
    ),
    _WorkHubPhase(
      7,
      Icons.construction_outlined,
      'Equipment & Machinery',
      'Equipment, certificates & inspections',
    ),
    _WorkHubPhase(
      8,
      Icons.local_fire_department_outlined,
      'High-Risk Activities',
      'Critical work activity controls',
    ),
    _WorkHubPhase(
      9,
      Icons.record_voice_over_outlined,
      'Daily HSE Work',
      'TBT, inspections & observations',
    ),
    _WorkHubPhase(
      10,
      Icons.emergency_outlined,
      'Emergency',
      'ERP, drills, rescue & evacuation',
    ),
    _WorkHubPhase(
      11,
      Icons.health_and_safety_outlined,
      'Occupational Health',
      'Medical, heat stress & welfare',
    ),
    _WorkHubPhase(
      12,
      Icons.science_outlined,
      'Chemical & Environment',
      'Chemical, waste & environmental records',
    ),
    _WorkHubPhase(
      13,
      Icons.search_outlined,
      'Inspection & Audit',
      'Inspections, audits & actions',
    ),
    _WorkHubPhase(
      14,
      Icons.car_crash_outlined,
      'Incident Management',
      'Incident, investigation & lessons learned',
    ),
    _WorkHubPhase(
      15,
      Icons.bar_chart_outlined,
      'HSE Reporting',
      'Daily, weekly, monthly & KPI',
    ),
    _WorkHubPhase(
      16,
      Icons.account_balance_outlined,
      'Legal / Authority',
      'UAE & jurisdiction-specific requirements',
    ),
  ];

  void _openPhase(BuildContext context, _WorkHubPhase phase) {
    final Widget page;

    switch (phase.number) {
      case 1:
        page = const ProjectPreStartPage();
        break;
      case 2:
        page = const HsePlanPage();
        break;
      case 3:
        page = const HiraRiskAssessmentPage();
        break;
      case 4:
        page = const PtwMasterRegisterPage();
        break;
      case 5:
        page = const SiteMobilizationPage();
        break;
      case 6:
        page = const WorkforceMasterRegisterPage();
        break;
      case 7:
        page = const EquipmentMachineryPage();
        break;
      case 8:
        page = const HighRiskActivitiesPage();
        break;
      case 9:
        page = const DailyHseWorkPage();
        break;
      case 10:
        page = const EmergencyManagementPage();
        break;
      case 11:
        page = const OccupationalHealthPage();
        break;
      case 12:
        page = const ChemicalEnvironmentPage();
        break;
      case 13:
        page = const InspectionAuditPage();
        break;
      case 14:
        page = const IncidentManagementPage();
        break;
      case 15:
        page = const HseReportingPage();
        break;
      case 16:
        page = const LegalAuthorityPage();
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => page,
      ),
    );
  }

  void _openActivityPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _ActivityPickerSheet(
          activities: hseWorkActivities,
          onSelected: (activity) {
            Navigator.of(sheetContext).pop();
            _openActivity(context, activity);
          },
        );
      },
    );
  }

  void _openActivity(
    BuildContext context,
    HseWorkActivity activity,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ActivityDetailsPage(activity: activity),
      ),
    );
  }

  void _openCompanyDayLog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WorkHubCompanyDayLogPage(),
      ),
    );
  }

  void _openEvidenceHub(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const SafeNexusEvidenceHubPage(),
      ),
    );
  }

  void _openRecordLinkage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const WorkHubRecordLinkagePage(),
      ),
    );
  }

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        titleSpacing: 16,
        title: const Text(
          'SafeNexus WorkHub',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _HeroCard(
                onStartNewWork: () => _openActivityPicker(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _FeatureCard(
                icon: Icons.business_center_outlined,
                title: 'Company & Daily Work Log',
                subtitle:
                    'Company logo, daily records, copy & PDF / Word / Excel / Image export',
                onTap: () => _openCompanyDayLog(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.link_outlined,
                title: 'Daily Work Record Linkage',
                subtitle:
                    'Link existing PTW, RAMS, Risk, Workforce & Equipment records by ID',
                onTap: () => _openRecordLinkage(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.photo_library_outlined,
                title: 'Daily Work Evidence Hub',
                subtitle:
                    'Attach site photos and HSE evidence notes to each Daily Work Record',
                onTap: () => _openEvidenceHub(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.shield_outlined,
                title: 'Risk Control Center',
                subtitle: 'Central risk register, controls, hierarchy and closure tracking',
                onTap: () => _openCanonical(context, const HseRiskControlCenterPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.business_outlined,
                title: 'Contractor & Supplier HSE',
                subtitle: 'Contractor readiness, compliance, performance and records',
                onTap: () => _openCanonical(context, const HseContractorSupplierPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.folder_shared_outlined,
                title: 'Document & Evidence Center',
                subtitle: 'Controlled HSE documents, evidence, status and review records',
                onTap: () => _openCanonical(context, const HseDocumentEvidenceCenterPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.account_tree_outlined,
                title: 'Integration & Data Center',
                subtitle: 'Unified module connection and cross-module record management',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusIntegrationShell(
                    modules: <SafeNexusModule>[
                      SafeNexusModule(
                        id: 'risk_control',
                        phase: 'WorkHub',
                        title: 'Risk Control Center',
                        subtitle: 'Risk register and controls',
                        icon: Icons.shield_outlined,
                        group: 'WorkHub',
                      ),
                      SafeNexusModule(
                        id: 'contractor_supplier',
                        phase: 'WorkHub',
                        title: 'Contractor & Supplier HSE',
                        subtitle: 'Contractor compliance and readiness',
                        icon: Icons.business_outlined,
                        group: 'WorkHub',
                      ),
                      SafeNexusModule(
                        id: 'document_evidence',
                        phase: 'WorkHub',
                        title: 'Document & Evidence Center',
                        subtitle: 'Controlled documents and evidence',
                        icon: Icons.folder_shared_outlined,
                        group: 'WorkHub',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Advanced HSE & Enterprise Intelligence',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: _FeatureCard(
                icon: Icons.auto_graph_outlined,
                title: 'Advanced HSE (Steps 51–60)',
                subtitle: 'Leadership, risk intelligence, performance, assurance and management intelligence',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusSteps51To60AdvancedHSEPage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.insights_outlined,
                title: 'Operations Intelligence (Steps 61–70)',
                subtitle: 'Operational performance, evidence, emergency and workforce intelligence',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusSteps61To70AdvancedOperationsIntelligencePage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.hub_outlined,
                title: 'Digital Enterprise Intelligence (Steps 71–80)',
                subtitle: 'Workflow orchestration, knowledge, analytics, resilience and enterprise HSE',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusSteps71To80DigitalEcosystemPage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: _FeatureCard(
                icon: Icons.psychology_outlined,
                title: 'AI & Decision Intelligence (Steps 81–90)',
                subtitle: 'AI-assisted risk, incident intelligence, predictive analytics and workflow automation',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusSteps81To90AiIntelligencePage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: _FeatureCard(
                icon: Icons.domain_outlined,
                title: 'Ultimate Enterprise HSE (Steps 91–100)',
                subtitle: 'Critical risk, crisis, human performance, supply-chain and enterprise governance',
                onTap: () => _openCanonical(
                  context,
                  const SafeNexusSteps91To100UltimateHsePage(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Integration, Evidence & Record Intelligence (Steps 101–125)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.integration_instructions,
                title: 'Master Integration (Step 101)',
                subtitle: 'Architecture, navigation, storage and workflow integration guidance',
                onTap: () => _openStep101To125(context, const SafenexusStep101MasterIntegrationPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.account_tree_outlined,
                title: 'Master Navigation Hub (Step 102)',
                subtitle: 'Enterprise HSE module navigation and Abu Dhabi Gold entry points',
                onTap: () => _openStep101To125(context, const SafenexusStep102MasterNavigationIntegrationHub()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.sync_alt_outlined,
                title: 'Unified Workflow (Step 103)',
                subtitle: 'Cross-module workflow orchestration and status flow',
                onTap: () => _openStep101To125(context, const SafeNexusStep103UnifiedWorkflowPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.photo_library_outlined,
                title: 'Unified Evidence Intelligence (Step 104)',
                subtitle: 'Evidence review, status and cross-module intelligence',
                onTap: () => _openStep101To125(context, const SafeNexusStep104UnifiedEvidencePage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.shield_outlined,
                title: 'Unified Risk Control Evidence (Step 105)',
                subtitle: 'Risk controls, evidence and closure intelligence',
                onTap: () => _openStep101To125(context, const SafeNexusStep105UnifiedRiskControlPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.hub_outlined,
                title: 'WorkHub Navigation Integration (Step 106)',
                subtitle: 'WorkHub setup and module integration guidance',
                onTap: () => _openStep101To125(context, const SafeNexusStep106WorkHubIntegrationPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.link_outlined,
                title: 'Unified Data & Record Linking (Step 107)',
                subtitle: 'Cross-module record linkage architecture',
                onTap: () => _openStep101To125(context, const SafeNexusStep107UnifiedRecordLinkingPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.workflow_outlined,
                title: 'Cross-Module Workflow (Step 108)',
                subtitle: 'Workflow stages across HSE modules',
                onTap: () => _openStep101To125(context, const SafeNexusStep108CrossModuleWorkflowPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.dashboard_outlined,
                title: 'Global HSE Dashboard (Step 109)',
                subtitle: 'Enterprise HSE dashboard and domain intelligence',
                onTap: () => _openStep101To125(context, const SafeNexusStep109GlobalHseDashboardPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.verified_outlined,
                title: 'Release Readiness (Step 110)',
                subtitle: 'System integration and release-readiness guidance',
                onTap: () => _openStep101To125(context, const SafeNexusStep110FinalIntegrationPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.search_outlined,
                title: 'Record Search & Filter (Step 115)',
                subtitle: 'Search and filter linked daily-work records',
                onTap: () => _openStep101To125(context, const SafeNexusRecordSearchFilterPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 0),
              child: _FeatureCard(
                icon: Icons.description_outlined,
                title: 'Record Detail Review (Step 116)',
                subtitle: 'Review linked record details and evidence',
                onTap: () => _openStep101To125(context, const SafeNexusRecordDetailReviewPage()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0 , 16, 18),
              child: _FeatureCard(
                icon: Icons.insights_outlined,
                title: 'Record Intelligence (Steps 117–125)',
                subtitle: 'Record-level intelligence, filtering and cross-module insights',
                onTap: () => _openStep101To125(context, const SafeNexusSteps117125Page()),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'HSE Work Lifecycle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${hseWorkActivities.length} activities',
                      style: const TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.builder(
              itemCount: _phases.length,
              itemBuilder: (BuildContext context, int index) {
                final phase = _phases[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _PhaseCard(
                    phase: phase,
                    onTap: () => _openPhase(context, phase),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkHubPhase {
  final int number;
  final IconData icon;
  final String title;
  final String subtitle;

  const _WorkHubPhase(
    this.number,
    this.icon,
    this.title,
    this.subtitle,
  );
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onStartNewWork;

  const _HeroCard({
    required this.onStartNewWork,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            darkGreen,
            primaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: darkGreen.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'SafeNexus WorkHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Plan • Prepare • Control • Monitor • Close',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onStartNewWork,
              icon: const Icon(Icons.add_task_rounded),
              label: const Text(
                'START NEW WORK',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryGreen,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final _WorkHubPhase phase;
  final VoidCallback onTap;

  const _PhaseCard({
    required this.phase,
    required this.onTap,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  phase.icon,
                  color: darkGreen,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  '${phase.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      phase.title,
                      style: const TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      phase.subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityPickerSheet extends StatefulWidget {
  final List<HseWorkActivity> activities;
  final ValueChanged<HseWorkActivity> onSelected;

  const _ActivityPickerSheet({
    required this.activities,
    required this.onSelected,
  });

  @override
  State<_ActivityPickerSheet> createState() =>
      _ActivityPickerSheetState();
}

class _ActivityPickerSheetState extends State<_ActivityPickerSheet> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HseWorkActivity> get _filtered {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return widget.activities;

    return widget.activities.where((activity) {
      final haystack = <String>[
        activity.id,
        activity.title,
        activity.category,
        activity.description,
      ].join(' ').toLowerCase();

      return haystack.contains(query);
    }).toList();
  }

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activities = _filtered;

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.86,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select HSE Work Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0B5D4B),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search activity',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: activities.isEmpty
                  ? const Center(
                      child: Text('No matching activities.'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        0,
                        20,
                        20,
                      ),
                      itemCount: activities.length,
                      itemBuilder: (_, index) {
                        final activity = activities[index];

                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE8F5EE),
                              child: Icon(
                                Icons.work_outline,
                                color: Color(0xFF0B5D4B),
                              ),
                            ),
                            title: Text(
                              activity.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              '${activity.category}\n'
                              '${activity.description}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            isThreeLine: true,
                            trailing: const Icon(
                              Icons.chevron_right,
                            ),
                            onTap: () => widget.onSelected(activity),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityDetailsPage extends StatelessWidget {
  final HseWorkActivity activity;

  const _ActivityDetailsPage({
    required this.activity,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);

  void _openStep101To125(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openCanonical(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text('Work Activity'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(activity.category),
                    avatar: const Icon(
                      Icons.category_outlined,
                      size: 18,
                    ),
                    backgroundColor:
                        primaryGreen.withValues(alpha: 0.10),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    activity.description,
                    style: const TextStyle(height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'WorkHub Control Entry',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Use the dedicated Risk, RAMS, PTW, Workforce, Equipment, '
                    'Daily HSE and other source modules for controlled records. '
                    'WorkHub does not duplicate those records.',
                    style: TextStyle(height: 1.45),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
