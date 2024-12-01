sealed class FirebaseAuthenticationError implements Exception {
  FirebaseAuthenticationError();
}

class InvalidPhoneNumberError extends FirebaseAuthenticationError {}

class InvalidSMSCodeError extends FirebaseAuthenticationError {}

class AccountExistsWithDifferentCredentialError extends FirebaseAuthenticationError {}

class UnknownFirebaseAuthenticationError extends FirebaseAuthenticationError {}
