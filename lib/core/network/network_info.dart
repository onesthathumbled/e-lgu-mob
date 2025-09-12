import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class for network connectivity checking
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity);
  
  final Connectivity _connectivity;
  
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
