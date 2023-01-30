class EnvironmentImplementationException implements Exception {
  String message = 'Template Implementing Exception';

  @override
  String toString() {
    return message;
  }

  EnvironmentImplementationException(
      {this.message = 'Template Implementing Exception'});
}
