import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() => _HazardReportPageState();
}

class _HazardReportPageState extends State<HazardReportPage> {
  final _formKey = GlobalKey<FormState>();

  String _selectedSeverity = 'Medium';

  final TextEditingController _locationController =
      TextEditingController();

  final TextEditingController _descController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  // ------------------------------------------------------------
  // LANGUAGE TRANSLATIONS
  // ------------------------------------------------------------

  final Map<String, Map<String, String>> _translations = {
    'en': {
      'title': 'Report Hazard / Unsafe Act',
      'observe': 'Observe & Report Safety Hazards',
      'location': 'Location / Area in Site',
      'enterLocation': 'Please enter location',
      'severity': 'Severity Level',
      'low': 'Low',
      'medium': 'Medium',
      'high': 'High',
      'critical': 'Critical',
      'description': 'Description of Hazard',
      'describe': 'Please describe the hazard',
      'moreDetails': 'Please provide more details',
      'attach': 'Attach Photo / Evidence',
      'change': 'Change Photo',
      'takePhoto': 'Take Photo',
      'useCamera': 'Use device camera',
      'gallery': 'Choose from Gallery',
      'selectPhoto': 'Select an existing photo',
      'remove': 'Remove photo',
      'attached': 'Photo evidence attached',
      'submit': 'Submit Report',
      'submitted': 'Report Submitted',
      'successPhoto':
          'Hazard report and photo evidence submitted successfully to the HSE Team!',
      'success':
          'Hazard report submitted successfully to the HSE Team!',
      'ok': 'OK',
      'unable': 'Unable to select image',
    },

    'ml': {
      'title': 'അപകടം / സുരക്ഷിതമല്ലാത്ത പ്രവൃത്തി റിപ്പോർട്ട്',
      'observe': 'സുരക്ഷാ അപകടങ്ങൾ നിരീക്ഷിച്ച് റിപ്പോർട്ട് ചെയ്യുക',
      'location': 'സൈറ്റിലെ സ്ഥലം / ഏരിയ',
      'enterLocation': 'ദയവായി സ്ഥലം നൽകുക',
      'severity': 'അപകടത്തിന്റെ തീവ്രത',
      'low': 'കുറഞ്ഞത്',
      'medium': 'ഇടത്തരം',
      'high': 'ഉയർന്നത്',
      'critical': 'ഗുരുതരം',
      'description': 'അപകടത്തിന്റെ വിശദീകരണം',
      'describe': 'ദയവായി അപകടം വിശദീകരിക്കുക',
      'moreDetails': 'ദയവായി കൂടുതൽ വിശദാംശങ്ങൾ നൽകുക',
      'attach': 'ഫോട്ടോ / തെളിവ് ചേർക്കുക',
      'change': 'ഫോട്ടോ മാറ്റുക',
      'takePhoto': 'ഫോട്ടോ എടുക്കുക',
      'useCamera': 'ക്യാമറ ഉപയോഗിക്കുക',
      'gallery': 'ഗാലറിയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക',
      'selectPhoto': 'നിലവിലുള്ള ഫോട്ടോ തിരഞ്ഞെടുക്കുക',
      'remove': 'ഫോട്ടോ നീക്കം ചെയ്യുക',
      'attached': 'ഫോട്ടോ തെളിവ് ചേർത്തു',
      'submit': 'റിപ്പോർട്ട് സമർപ്പിക്കുക',
      'submitted': 'റിപ്പോർട്ട് സമർപ്പിച്ചു',
      'successPhoto':
          'അപകട റിപ്പോർട്ടും ഫോട്ടോ തെളിവും HSE ടീമിന് വിജയകരമായി സമർപ്പിച്ചു!',
      'success':
          'അപകട റിപ്പോർട്ട് HSE ടീമിന് വിജയകരമായി സമർപ്പിച്ചു!',
      'ok': 'ശരി',
      'unable': 'ഫോട്ടോ തിരഞ്ഞെടുക്കാൻ കഴിഞ്ഞില്ല',
    },

    'hi': {
      'title': 'खतरा / असुरक्षित कार्य रिपोर्ट करें',
      'observe': 'सुरक्षा खतरों को देखें और रिपोर्ट करें',
      'location': 'साइट का स्थान / क्षेत्र',
      'enterLocation': 'कृपया स्थान दर्ज करें',
      'severity': 'खतरे की गंभीरता',
      'low': 'कम',
      'medium': 'मध्यम',
      'high': 'उच्च',
      'critical': 'गंभीर',
      'description': 'खतरे का विवरण',
      'describe': 'कृपया खतरे का विवरण दें',
      'moreDetails': 'कृपया अधिक जानकारी दें',
      'attach': 'फोटो / सबूत जोड़ें',
      'change': 'फोटो बदलें',
      'takePhoto': 'फोटो लें',
      'useCamera': 'डिवाइस कैमरा का उपयोग करें',
      'gallery': 'गैलरी से चुनें',
      'selectPhoto': 'मौजूदा फोटो चुनें',
      'remove': 'फोटो हटाएं',
      'attached': 'फोटो सबूत जोड़ा गया',
      'submit': 'रिपोर्ट सबमिट करें',
      'submitted': 'रिपोर्ट सबमिट हो गई',
      'successPhoto':
          'खतरे की रिपोर्ट और फोटो सबूत HSE टीम को सफलतापूर्वक भेज दिए गए हैं!',
      'success':
          'खतरे की रिपोर्ट HSE टीम को सफलतापूर्वक भेज दी गई है!',
      'ok': 'ठीक है',
      'unable': 'फोटो चुनने में असमर्थ',
    },

    'ta': {
      'title': 'ஆபத்து / பாதுகாப்பற்ற செயல் அறிக்கை',
      'observe': 'பாதுகாப்பு ஆபத்துகளை கவனித்து அறிக்கை செய்யவும்',
      'location': 'தளத்தின் இடம் / பகுதி',
      'enterLocation': 'தயவுசெய்து இடத்தை உள்ளிடவும்',
      'severity': 'ஆபத்தின் தீவிரம்',
      'low': 'குறைவு',
      'medium': 'நடுத்தரம்',
      'high': 'அதிகம்',
      'critical': 'மிகவும் தீவிரம்',
      'description': 'ஆபத்தின் விளக்கம்',
      'describe': 'தயவுசெய்து ஆபத்தை விவரிக்கவும்',
      'moreDetails': 'தயவுசெய்து கூடுதல் விவரங்களை வழங்கவும்',
      'attach': 'புகைப்படம் / ஆதாரம் இணைக்கவும்',
      'change': 'புகைப்படத்தை மாற்றவும்',
      'takePhoto': 'புகைப்படம் எடுக்கவும்',
      'useCamera': 'சாதன கேமராவைப் பயன்படுத்தவும்',
      'gallery': 'கேலரியில் இருந்து தேர்வு செய்யவும்',
      'selectPhoto': 'ஏற்கனவே உள்ள புகைப்படத்தை தேர்வு செய்யவும்',
      'remove': 'புகைப்படத்தை அகற்றவும்',
      'attached': 'புகைப்பட ஆதாரம் இணைக்கப்பட்டது',
      'submit': 'அறிக்கையை சமர்ப்பிக்கவும்',
      'submitted': 'அறிக்கை சமர்ப்பிக்கப்பட்டது',
      'successPhoto':
          'ஆபத்து அறிக்கையும் புகைப்பட ஆதாரமும் HSE குழுவிற்கு வெற்றிகரமாக அனுப்பப்பட்டன!',
      'success':
          'ஆபத்து அறிக்கை HSE குழுவிற்கு வெற்றிகரமாக அனுப்பப்பட்டது!',
      'ok': 'சரி',
      'unable': 'புகைப்படத்தைத் தேர்ந்தெடுக்க முடியவில்லை',
    },
  };

  String get languageCode {
    final code = Localizations.localeOf(context).languageCode;

    if (_translations.containsKey(code)) {
      return code;
    }

    return 'en';
  }

  String text(String key) {
    return _translations[languageCode]?[key] ??
        _translations['en']![key] ??
        key;
  }

  // ------------------------------------------------------------
  // DISPOSE
  // ------------------------------------------------------------

  @override
  void dispose() {
    _locationController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // CAMERA / GALLERY
  // ------------------------------------------------------------

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text('attach'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                  title: Text(text('takePhoto')),
                  subtitle: Text(text('useCamera')),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.photo_library),
                  ),
                  title: Text(text('gallery')),
                  subtitle: Text(text('selectPhoto')),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // PICK IMAGE
  // ------------------------------------------------------------

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image == null) {
        return;
      }

      setState(() {
        _selectedImage = File(image.path);
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${text('unable')}: $e'),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // REMOVE IMAGE
  // ------------------------------------------------------------

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  // ------------------------------------------------------------
  // SUBMIT REPORT
  // ------------------------------------------------------------

  void _submitReport() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(text('submitted')),
        content: Text(
          _selectedImage != null
              ? text('successPhoto')
              : text('success'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(text('ok')),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text('title')),
        backgroundColor: Colors.orange.shade800,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              Text(
                text('observe'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              // LOCATION
              TextFormField(
                controller: _locationController,
                textInputAction: TextInputAction.next,

                decoration: InputDecoration(
                  labelText: text('location'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.location_on),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return text('enterLocation');
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // SEVERITY
              DropdownButtonFormField<String>(
                value: _selectedSeverity,

                decoration: InputDecoration(
                  labelText: text('severity'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(
                    Icons.warning,
                    color: Colors.orange,
                  ),
                ),

                items: [
                  DropdownMenuItem(
                    value: 'Low',
                    child: Text(text('low')),
                  ),
                  DropdownMenuItem(
                    value: 'Medium',
                    child: Text(text('medium')),
                  ),
                  DropdownMenuItem(
                    value: 'High',
                    child: Text(text('high')),
                  ),
                  DropdownMenuItem(
                    value: 'Critical',
                    child: Text(text('critical')),
                  ),
                ],

                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedSeverity = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // DESCRIPTION
              TextFormField(
                controller: _descController,
                maxLines: 4,
                textInputAction: TextInputAction.newline,

                decoration: InputDecoration(
                  labelText: text('description'),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return text('describe');
                  }

                  if (value.trim().length < 10) {
                    return text('moreDetails');
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ATTACH PHOTO
              OutlinedButton.icon(
                onPressed: _showImageSourceDialog,

                icon: const Icon(Icons.camera_alt),

                label: Text(
                  _selectedImage == null
                      ? text('attach')
                      : text('change'),
                ),

                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // PHOTO PREVIEW
              if (_selectedImage != null) ...[
                const SizedBox(height: 16),

                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.file(
                        _selectedImage!,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,

                      child: Material(
                        color: Colors.black54,
                        shape: const CircleBorder(),

                        child: IconButton(
                          onPressed: _removeImage,

                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),

                          tooltip: text('remove'),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      text('attached'),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 30),

              // SUBMIT
              ElevatedButton.icon(
                onPressed: _submitReport,

                icon: const Icon(Icons.send),

                label: Text(
                  text('submit'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  foregroundColor: Colors.white,

                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
