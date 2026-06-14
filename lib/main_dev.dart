import 'bootstrap.dart';
import 'flavors.dart';

Future<void> main() async {
  await bootstrap(Flavor.dev);
}
