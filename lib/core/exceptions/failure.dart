import 'package:equatable/equatable.dart';
import 'package:simulated_delivery_app/core/exceptions/exceptions.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {
  final String? message;
  final ExceptionType? type;

  const ServerFailure({this.message, this.type});
}

class ConnectionFailure extends Failure {
  final String? message;

  const ConnectionFailure({this.message = "We've lost Your Connection"});
}

class UserUnAuthorized extends Failure {}

class CacheFailure extends Failure {}
