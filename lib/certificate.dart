import 'package:flutter/material.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  final _nameController = TextEditingController(text: 'Employee Name');
  final _idController = TextEditingController();
  final _departmentController = TextEditingController();
  final _achievementController = TextEditingController(
    text:
        'for your outstanding commitment to Health, Safety & Environment\n'
        'and for actively contributing to a safe and sustainable workplace.',
  );
  final _companyController = TextEditingController(text: 'SafeNexus HSE');
  final _titleController = TextEditingController(text: 'CERTIFICATE');
  final _subtitleController =
      TextEditingController(text: 'OF APPRECIATION');
  final _footerController =
      TextEditingController(text: 'Identify. Report. Stay Safe.');
  final _signatoryController =
      TextEditingController(text: 'Authorized Signatory');

  DateTime selectedDate = DateTime.now();

  int selectedTemplate = 0;
  int selectedColor = 0;

  double nameFontSize = 34;
  TextAlign nameAlignment = TextAlign.center;

  final List<Color> themeColors = const [
    Color(0xFF087A3D),
    Color(0xFF1261A0),
    Color(0xFFB47B00),
  ];

  final List<String> templateNames = const [
    'HSE Appreciation',
    'Safety Excellence',
    'Employee Recognition',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    _achievementController.dispose();
    _companyController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _footerController.dispose();
    _signatoryController.dispose();
    super.dispose();
  }

  Color get primaryColor => themeColors[selectedColor];

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _resetCertificate() {
    setState(() {
      _nameController.text = 'Employee Name';
      _idController.clear();
      _departmentController.clear();
      _achievementController.text =
          'for your outstanding commitment to Health, Safety & Environment\n'
          'and for actively contributing to a safe and sustainable workplace.';
      _companyController.text = 'SafeNexus HSE';
      _titleController.text = 'CERTIFICATE';
      _subtitleController.text = 'OF APPRECIATION';
      _footerController.text = 'Identify. Report. Stay Safe.';
      _signatoryController.text = 'Authorized Signatory';
      selectedTemplate = 0;
      selectedColor = 0;
      nameFontSize = 34;
      nameAlignment = TextAlign.center;
      selectedDate = DateTime.now();
    });
  }

  void _showSavedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Certificate design saved successfully.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _editText({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final tempController =
            TextEditingController(text: controller.text);

        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: tempController,
            maxLines: maxLines,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  controller.text = tempController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon),
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  Widget _templateCard(int index) {
    final isSelected = selectedTemplate == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTemplate = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withOpacity(0.08)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeColors[index].withOpacity(.18),
                      Colors.white,
                    ],
                  ),
                  border: Border.all(color: themeColors[index]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'CERTIFICATE',
                    style: TextStyle(
                      color: themeColors[index],
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                templateNames[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certificatePreview() {
    return AspectRatio(
      aspectRatio: 0.707,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFEF9),
          border: Border.all(
            color: primaryColor,
            width: 8,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor.withOpacity(.6),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 120,
                child: CustomPaint(
                  painter: _ConstructionBackgroundPainter(
                    color: primaryColor,
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      _certificateLogo(),
                      const SizedBox(height: 8),
                      Text(
                        _companyController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        'AI-Powered HSE Safety & Observation App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 7,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        _titleController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Text(
                          _subtitleController.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'This certificate is proudly presented to',
                        style: TextStyle(fontSize: 9),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _editText(
                          title: 'Edit Employee Name',
                          controller: _nameController,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor.withOpacity(.35),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _nameController.text,
                            textAlign: nameAlignment,
                            style: TextStyle(
                              fontFamily: 'cursive',
                              fontSize: nameFontSize,
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: primaryColor.withOpacity(.35),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _achievementController.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 10,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 14),
                            _safetyBadges(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _signatureBlock(
                            formattedDate,
                            'Date',
                          ),
                          _priorityBadge(),
                          _signatureBlock(
                            _signatoryController.text,
                            'Authorized Signatory',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          _footerController.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certificateLogo() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.engineering,
              color: Colors.white,
              size: 23,
            ),
            Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyBadges() {
    final badges = [
      [Icons.verified_user, 'BE SAFE'],
      [Icons.construction, 'WORK SAFE'],
      [Icons.groups, 'STAY SAFE'],
      [Icons.eco, 'GO HOME SAFE'],
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: badges.map((badge) {
        return Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor),
              ),
              child: Icon(
                badge[0] as IconData,
                color: primaryColor,
                size: 21,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              badge[1] as String,
              style: TextStyle(
                fontSize: 6,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _priorityBadge() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: const Center(
        child: Text(
          'SAFETY\nIS OUR\nPRIORITY',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _signatureBlock(String value, String label) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.black54,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 7,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.edit, 'Edit Certificate'),

        _inputField(
          label: 'Certificate Title',
          controller: _titleController,
          icon: Icons.title,
        ),

        _inputField(
          label: 'Subtitle',
          controller: _subtitleController,
          icon: Icons.label_outline,
        ),

        _inputField(
          label: 'Employee Name',
          controller: _nameController,
          icon: Icons.person,
        ),

        _inputField(
          label: 'Employee ID',
          controller: _idController,
          icon: Icons.badge_outlined,
        ),

        _inputField(
          label: 'Department',
          controller: _departmentController,
          icon: Icons.business,
        ),

        _inputField(
          label: 'Achievement / Reason',
          controller: _achievementController,
          icon: Icons.workspace_premium,
          maxLines: 4,
        ),

        _inputField(
          label: 'Company Name',
          controller: _companyController,
          icon: Icons.business_center,
        ),

        _inputField(
          label: 'Authorized Signatory',
          controller: _signatoryController,
          icon: Icons.draw,
        ),

        _inputField(
          label: 'Footer Text',
          controller: _footerController,
          icon: Icons.short_text,
        ),

        InkWell(
          onTap: _selectDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Certificate Date',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            child: Text(formattedDate),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Name Font Size',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Slider(
          min: 20,
          max: 48,
          divisions: 14,
          value: nameFontSize,
          label: nameFontSize.round().toString(),
          onChanged: (value) {
            setState(() {
              nameFontSize = value;
            });
          },
        ),

        Text(
          'Name Alignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Row(
          children: [
            _alignmentButton(
              Icons.format_align_left,
              TextAlign.left,
            ),
            _alignmentButton(
              Icons.format_align_center,
              TextAlign.center,
            ),
            _alignmentButton(
              Icons.format_align_right,
              TextAlign.right,
            ),
          ],
        ),

        const SizedBox(height: 15),

        Text(
          'Certificate Theme',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: List.generate(
            themeColors.length,
            (index) {
              final selected = selectedColor == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: themeColors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? Colors.black
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _alignmentButton(
    IconData icon,
    TextAlign alignment,
  ) {
    final selected = nameAlignment == alignment;

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            nameAlignment = alignment;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected ? primaryColor.withOpacity(.1) : null,
          side: BorderSide(
            color: selected
                ? primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          icon,
          color: selected ? primaryColor : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F5),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SAFENEXUS HSE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Certificate Designer',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Save',
            onPressed: _showSavedMessage,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium,
                    size: 36,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Certificate Designer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const Text(
                          'Create • Edit • Customize • Save',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        Icons.dashboard_customize,
                        'Choose Template',
                      ),
                      Row(
                        children: List.generate(
                          templateNames.length,
                          _templateCard,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: _editTools(),
                ),
              ),

              const SizedBox(height: 14),

              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        Icons.visibility,
                        'Live Preview',
                      ),
                      _certificatePreview(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetCertificate,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _showSavedMessage,
                      icon: const Icon(Icons.save),
                      label: const Text('Save Design'),
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConstructionBackgroundPainter extends CustomPainter {
  final Color color;

  _ConstructionBackgroundPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 10; x < size.width; x += 45) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + 30, 30),
        paint,
      );
    }

    for (double y = 20; y < size.height; y += 22) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _ConstructionBackgroundPainter oldDelegate,
  ) {
    return oldDelegate.color != color;
  }
}
