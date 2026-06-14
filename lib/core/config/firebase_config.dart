import 'package:firebase_core/firebase_core.dart';
import 'package:healthstride/firebase/firebase_options_dev.dart';
import 'package:healthstride/firebase/firebase_options_prod.dart';
import 'package:healthstride/flavors.dart';

class FirebaseConfig {
  static FirebaseOptions get options {
    switch (F.appFlavor) {
      case Flavor.dev:
        return DefaultFirebaseOptionsDev.currentPlatform;

      case Flavor.prod:
        return DefaultFirebaseOptionsProd.currentPlatform;
    }
  }
}
