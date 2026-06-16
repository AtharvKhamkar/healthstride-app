abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class HealthFailure extends Failure {
  const HealthFailure(super.message);
}
