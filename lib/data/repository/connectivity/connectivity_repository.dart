import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:billie/core/interfaces/i_connectivity_repository.dart';

/// Implementation of the connectivity repository using the connectivity_plus package.
/// 
/// This repository:
/// - Abstracts away the complexity of handling connectivity changes
/// - Provides simplified, prioritized connectivity status
/// - Handles error cases gracefully
class ConnectivityRepository implements IConnectivityRepository {
  /// Instance of the connectivity service from the package
  final Connectivity _connectivity;

  /// Creates a new connectivity repository
  /// 
  /// [_connectivity] is injected to allow for better testability
  ConnectivityRepository(this._connectivity);

  @override
  Stream<ConnectivityResult> get connectivityStateChanges {
    try {
      // The connectivity_plus package returns single connectivity result in version 4.0.2
      return _connectivity.onConnectivityChanged;
    } catch (e) {
      debugPrint('Error monitoring connectivity changes: $e');
      return Stream.value(ConnectivityResult.none);
    }
  }
  
  @override
  Future<ConnectivityResult> checkConnectivity() async {
    try {
      // The connectivity_plus package returns single connectivity result in version 4.0.2
      return await _connectivity.checkConnectivity();
    } catch (e) {
      debugPrint('Error checking current connectivity: $e');
      return ConnectivityResult.none;
    }
  }

}
