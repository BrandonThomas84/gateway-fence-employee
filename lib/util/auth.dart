
String getFirebaseAuthenticationErrorMessageFromCode(String code) {
  switch (code) {
    case 'claims-too-large':
      return 'The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.';
    case 'email-already-exists':
      return 'The provided email is already in use by an existing user. Each user must have a unique email.';
    case 'id-token-expired':
      return 'The provided Firebase ID token is expired.';
    case 'id-token-revoked':
      return 'The Firebase ID token has been revoked.';
    case 'insufficient-permission':
      return 'The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource. Refer to Set up a Firebase project for documentation on how to generate a credential with appropriate permissions and use it to authenticate the Admin SDKs.';
    case 'internal-error':
      return 'The Authentication server encountered an unexpected error while trying to process the request. The error message should contain the response from the Authentication server containing additional information. If the error persists, please report the problem to our Bug Report support channel.';
    case 'invalid-argument':
      return 'An invalid argument was provided to an Authentication method. The error message should contain additional information.';
    case 'invalid-claims':
      return 'The custom claim attributes provided to setCustomUserClaims() are invalid.';
    case 'invalid-continue-uri':
      return 'The continue URL must be a valid URL string.';
    case 'invalid-creation-time':
      return 'The creation time must be a valid UTC date string.';
    case 'invalid-credential':
      return 'The credential used to authenticate the Admin SDKs cannot be used to perform the desired action. Certain Authentication methods such as createCustomToken() and verifyIdToken() require the SDK to be initialized with a certificate credential as opposed to a refresh token or Application Default credential. See Initialize the SDK for documentation on how to authenticate the Admin SDKs with a certificate credential.';
    case 'invalid-disabled-field':
      return 'The provided value for the disabled user property is invalid. It must be a boolean.';
    case 'invalid-display-name':
      return 'The provided value for the displayName user property is invalid. It must be a non-empty string.';
    case 'invalid-dynamic-link-domain':
      return 'The provided dynamic link domain is not configured or authorized for the current project.';
    case 'invalid-email':
      return 'The provided value for the email user property is invalid. It must be a string email address.';
    case 'invalid-email-verified':
      return 'The provided value for the emailVerified user property is invalid. It must be a boolean.';
    case 'invalid-hash-algorithm':
      return 'The hash algorithm must match one of the strings in the list of supported algorithms.';
    case 'invalid-hash-block-size':
      return 'The hash block size must be a valid number.';
    case 'invalid-hash-derived-key-length':
      return 'The hash derived key length must be a valid number.';
    case 'invalid-hash-key':
      return 'The hash key must a valid byte buffer.';
    case 'invalid-hash-memory-cost':
      return 'The hash memory cost must be a valid number.';
    case 'invalid-hash-parallelization':
      return 'The hash parallelization must be a valid number.';
    case 'invalid-hash-rounds':
      return 'The hash rounds must be a valid number.';
    case 'invalid-hash-salt-separator':
      return 'The hashing algorithm salt separator field must be a valid byte buffer.';
    case 'invalid-id-token':
      return 'The provided ID token is not a valid Firebase ID token.';
    case 'invalid-last-sign-in-time':
      return 'The last sign-in time must be a valid UTC date string.';
    case 'invalid-page-token':
      return 'The provided next page token in listUsers() is invalid. It must be a valid non-empty string.';
    case 'invalid-password':
      return 'The provided value for the password user property is invalid. It must be a string with at least six characters.';
    case 'invalid-password-hash':
      return 'The password hash must be a valid byte buffer.';
    case 'invalid-password-salt':
      return 'The password salt must be a valid byte buffer';
    case 'invalid-phone-number':
      return 'The provided value for the phoneNumber is invalid. It must be a non-empty E.164 standard compliant identifier string.';
    case 'invalid-photo-url':
      return 'The provided value for the photoURL user property is invalid. It must be a string URL.';
    case 'invalid-provider-data':
      return 'The providerData must be a valid array of UserInfo objects.';
    case 'invalid-provider-id':
      return 'The providerId must be a valid supported provider identifier string.';
    case 'invalid-oauth-responsetype':
      return 'Only exactly one OAuth responseType should be set to true.';
    case 'invalid-session-cookie-duration':
      return 'The session cookie duration must be a valid number in milliseconds between 5 minutes and 2 weeks.';
    case 'invalid-uid':
      return 'The provided uid must be a non-empty string with at most 128 characters.';
    case 'invalid-user-import':
      return 'The user record to import is invalid.';
    case 'maximum-user-count-exceeded':
      return 'The maximum allowed number of users to import has been exceeded.';
    case 'missing-android-pkg-name':
      return 'An Android Package Name must be provided if the Android App is required to be installed.';
    case 'missing-continue-uri':
      return 'A valid continue URL must be provided in the request.';
    case 'missing-hash-algorithm':
      return 'Importing users with password hashes requires that the hashing algorithm and its parameters be provided.';
    case 'missing-ios-bundle-id':
      return 'The request is missing a Bundle ID.';
    case 'missing-uid':
      return 'A uid identifier is required for the current operation.';
    case 'missing-oauth-client-secret':
      return 'The OAuth configuration client secret is required to enable OIDC code flow.';
    case 'operation-not-allowed':
      return 'The provided sign-in provider is disabled for your Firebase project. Enable it from the Sign-in Method section of the Firebase console.';
    case 'phone-number-already-exists':
      return 'The provided phoneNumber is already in use by an existing user. Each user must have a unique phoneNumber.';
    case 'project-not-found':
      return 'No Firebase project was found for the credential used to initialize the Admin SDKs. Refer to Set up a Firebase project for documentation on how to generate a credential for your project and use it to authenticate the Admin SDKs.';
    case 'reserved-claims':
      return 'One or more custom user claims provided to setCustomUserClaims() are reserved. For example, OIDC specific claims such as (sub, iat, iss, exp, aud, auth_time, etc) should not be used as keys for custom claims.';
    case 'session-cookie-expired':
      return 'The provided Firebase session cookie is expired.';
    case 'session-cookie-revoked':
      return 'The Firebase session cookie has been revoked.';
    case 'too-many-requests':
      return 'The number of requests exceeds the maximum allowed.';
    case 'uid-already-exists':
      return 'The provided uid is already in use by an existing user. Each user must have a unique uid.';
    case 'unauthorized-continue-uri':
      return 'The domain of the continue URL is not whitelisted. Whitelist the domain in the Firebase Console.';
    case 'user-not-found':
      return 'There is no existing user record corresponding to the email address provided. You can register for an account or if you think this is an error please contact the system administrator.';
    default:
      return 'An unknown error occurred.';
  }
}