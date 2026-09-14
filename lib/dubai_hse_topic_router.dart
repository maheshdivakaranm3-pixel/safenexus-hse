import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';

class DubaiDedicatedPageRouter {
  static Widget pageFor(ReferenceTopic topic) {
    return DubaiHseTopicRouter.pageFor(topic);
  }
}
