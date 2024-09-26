// lib/core/error_manager/firebase_failure.dart

import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.message});

  factory FirebaseFailure.fromFirebaseError(Object error) {
    if (error is FirebaseException) {
      return FirebaseFailure(message: error.message ?? 'Firebase Error');
    } else if (error is FirebaseAuthException) {
      if (error.code == 'weak-password') {
        return const FirebaseFailure(message: 'كلمه السر ضعيفه');
      } else if (error.code == 'email-already-in-use') {
        return const FirebaseFailure(
            message: 'هذا البريد الالكتروني مسجل بالفعل');
      } else {
        return const FirebaseFailure(message: 'حدث خطأ ما,حاول مره اخري');
      }
    } else {}
    if (error is FirebaseAuthException) {
      if (error.code == 'weak-password') {
        return const FirebaseFailure(message: 'كلمه السر ضعيفه');
      } else if (error.code == 'email-already-in-use') {
        return const FirebaseFailure(
            message: 'هذا البريد الالكتروني مسجل بالفعل');
      } else {
        return const FirebaseFailure(message: 'حدث خطأ ما,حاول مره اخري');
      }
    } else {
      return FirebaseFailure(message: 'An error occurred: $error');
    }
  }
}
