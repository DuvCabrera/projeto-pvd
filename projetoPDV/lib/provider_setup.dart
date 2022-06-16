import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...withoutDependency,
  ...dependent,
];

List<SingleChildWidget> withoutDependency = [
  // Provider(create: (context) => )
];

List<SingleChildWidget> dependent = [];
