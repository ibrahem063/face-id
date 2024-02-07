import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

// class AuthService {
//   static Future<bool> authenticateUser() async {
//     //initialize Local Authentication plugin.
//     final LocalAuthentication _localAuthentication = LocalAuthentication();
//
//     //status of authentication.
//     bool isAuthenticated = false;
//
//     //check if device supports biometrics authentication.
//     bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
//
//
//     List<BiometricType> biometricTypes =
//     await _localAuthentication.getAvailableBiometrics();
//
//     print(biometricTypes);
//
//     //if device supports biometrics, then authenticate.
//     if (isBiometricSupported) {
//       try {
//         isAuthenticated = await _localAuthentication.authenticate(
//             localizedReason: 'To continue, you must complete the biometrics',
//             options: const AuthenticationOptions(
//                 biometricOnly: true,
//                 useErrorDialogs: true,
//                 stickyAuth: true,
//             ),
//           authMessages: const<AuthMessages>[
//             AndroidAuthMessages()
//           ]
//             );
//       } on PlatformException catch (e) {
//         print(e);
//       }
//     }
//
//     return isAuthenticated;
//   }
// }

class LocalAuth{
  static final _auth=LocalAuthentication();
  static Future<bool> _canAuthenticate() async=>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool?> authenticate()async{
    try{
      if(!await _canAuthenticate())return false;
      return await _auth.authenticate(
          localizedReason: 'Use Face Id to authenticate',
        authMessages: const<AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Sign in',
              cancelButton: 'No Thanks',
            ),
          IOSAuthMessages(
            cancelButton: 'No Thanks',
          ),
          ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        )
      );
    }catch (e){
      debugPrint('error $e');
    }
    return null;
  }
}