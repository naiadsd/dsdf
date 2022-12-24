import 'package:flutter/foundation.dart' show immutable;

typedef ClosedLoadingSccreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final ClosedLoadingSccreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
