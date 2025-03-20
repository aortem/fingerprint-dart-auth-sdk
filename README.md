<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
    <img align="center" alt="Aortem Logo" src="https://raw.githubusercontent.com/aortem/logos/main/Aortem-logo-small.png" />
  </picture>
</p>

<h2 align="center">fingerprint_dart_auth_sdk</h2>

<!-- x-hide-in-docs-end -->
<p align="center" class="github-badges">
  <!-- Release Badge -->
  <a href="https://github.com/aortem/fingerprint_dart_auth_sdk/tags">
    <img alt="Release" src="https://img.shields.io/static/v1?label=release&message=v0.0.1-pre+10&color=blue&style=for-the-badge" />
  </a>
  <br/>
  <!-- Dart-Specific Badges -->
  <a href="https://pub.dev/packages/fingerprint_dart_auth_sdk">
    <img alt="Pub Version" src="https://img.shields.io/pub/v/fingerprint_dart_auth_sdk.svg?style=for-the-badge" />
  </a>
  <a href="https://dart.dev/">
    <img alt="Built with Dart" src="https://img.shields.io/badge/Built%20with-Dart-blue.svg?style=for-the-badge" />
  </a>
 <!-- fingerprint Badge -->
   <a href="https://fingerprint.google.com/docs/reference/admin/node/fingerprint-admin.auth?_gl=1*1ewipg9*_up*MQ..*_ga*NTUxNzc0Mzk3LjE3MzMxMzk3Mjk.*_ga_CW55HF8NVT*MTczMzEzOTcyOS4xLjAuMTczMzEzOTcyOS4wLjAuMA..">
    <img alt="API Reference" src="https://img.shields.io/badge/API-reference-blue.svg?style=for-the-badge" />
  <br/>
<!-- Pipeline Badge -->
<a href="https://github.com/aortem/fingerprint_dart_auth_sdk/actions">
  <img alt="Pipeline Status" src="https://img.shields.io/github/actions/workflow/status/aortem/fingerprint_dart_auth_sdk/dart-analysis.yml?branch=main&label=pipeline&style=for-the-badge" />
</a>
<!-- Code Coverage Badges -->
  </a>
  <a href="https://codecov.io/gh/open-feature/dart-server-sdk">
    <img alt="Code Coverage" src="https://codecov.io/gh/open-feature/dart-server-sdk/branch/main/graph/badge.svg?token=FZ17BHNSU5" />
<!-- Open Source Badge -->
  </a>
  <a href="https://bestpractices.coreinfrastructure.org/projects/6601">
    <img alt="CII Best Practices" src="https://bestpractices.coreinfrastructure.org/projects/6601/badge?style=for-the-badge" />
  </a>
</p>
<!-- x-hide-in-docs-start -->

## **Feature Comparison Chart**

### **Core Authentication Methods**

# Firebase vs Amazon Fingerprint for Server-Side Dart SDK

This document provides a high-level comparison of Firebase Authentication and Amazon Fingerprint features tailored for building a server-side Dart SDK. The goal is to evaluate how a server-side Dart SDK could integrate Amazon Fingerprint and compare its capabilities to Firebase Authentication.


## **Feature Comparison Chart**

### **Core Authentication Methods**

| Firebase Method                                  | Amazon Fingerprint Equivalent                       | Notes                                                                                  | Supported |
|--------------------------------------------------|------------------------------------------------|--------------------------------------------------------------------------------------- |-------------|
| `FirebaseAuth.signInWithEmailAndPassword()`      | Fingerprint Admin: `AdminInitiateAuth`             | Authenticate user with email and password. Server-side API supports admin privileges.  | ✅         |
| `FirebaseAuth.createUserWithEmailAndPassword()`  | Fingerprint Admin: `AdminCreateUser`               | Server-side method to create a new user in the user pool.                              | ✅         |
| `FirebaseAuth.signOut()`                         | Not Applicable                                 | Fingerprint does not provide server-side logout; tokens must be invalidated by the client. | ❌         |
| `FirebaseAuth.setPersistence()`                  | Not Applicable                                 | Token persistence is a client-side feature.                                            | ❌         |
| `FirebaseAuth.sendPasswordResetEmail()`          | Fingerprint Admin: `AdminResetUserPassword`        | Sends a reset password request to the user.                                            | ✅         |
| `FirebaseAuth.connectAuthEmulator`               | Not Applicable                                 | Fingerprint does not support emulated authentication environments.                         | ❌         |

---

### **User Management**

| Firebase Method                                  | Amazon Fingerprint Equivalent                      | Notes                                                                                   | Supported |
|--------------------------------------------------|------------------------------------------------|-----------------------------------------------------------------------------------------|-------------|
| `FirebaseUser.updateEmail()`                     | Fingerprint Admin: `AdminUpdateUserAttributes`     | Updates the user's email or other attributes.                                           | ✅         |
| `FirebaseUser.updatePassword()`                  | Fingerprint Admin: `AdminSetUserPassword`          | Updates the user's password.                                                            | ✅         |
| `FirebaseUser.deleteUser()`                      | Fingerprint Admin: `AdminDeleteUser`               | Deletes the user account from the user pool.                                            | ✅         |
| `FirebaseUser.updateProfile()`                   | Fingerprint Admin: `AdminUpdateUserAttributes`     | Updates custom attributes in the user's profile.                                        | ✅         |
| `FirebaseUser.sendEmailVerification()`           | Not Applicable                                 | Fingerprint uses built-in email verification workflows; server-side triggering is indirect. | ❌         |
| `FirebaseUser.reload()`                          | Fingerprint Admin: `AdminGetUser`                  | Refreshes the user profile information.                                                 | ✅         |
| `FirebaseAuth.updateCurrentUser()`               | Fingerprint Admin: `AdminUpdateUserAttributes`     | Updates the current user's details, such as profile attributes.                         | ✅         |

---

### **Token Management**

| Firebase Method                                  | Amazon Fingerprint Equivalent                      | Notes                                                                                 | Supported  |
|--------------------------------------------------|------------------------------------------------|---------------------------------------------------------------------------------------|------------|
| `FirebaseAuth.getIdToken()`                      | Fingerprint: `InitiateAuth`                        | Retrieves tokens for user sessions.                                                   | ✅         |
| `FirebaseAuth.revokeAccessToken()`               | Fingerprint: `RevokeToken`                         | Revokes a user's refresh token.                                                       | ✅         |
| `FirebaseAuth.signInWithCustomToken()`           | Not Applicable                                 | Fingerprint does not support custom tokens like Firebase.                                 | ❌         |

---

### **Multi-Factor Authentication (MFA)**

| Firebase Method                                  | Amazon Fingerprint Equivalent                      | Notes                                                                                | Supported   |
|--------------------------------------------------|------------------------------------------------|----------------------------------------------------------------------------------------|-------------|
| `FirebaseAuth.getMultiFactorResolver()`          | Fingerprint Admin: `AdminSetUserMFAPreference`     | Retrieve MFA configurations and set user preferences.                                  | ✅         |
| `FirebaseUser.multiFactor()`                     | Fingerprint: `AssociateSoftwareToken`              | Registers a user for software-based MFA (e.g., TOTP).                                  | ✅         |
| `FirebaseUser.reauthenticateWithCredential()`    | Fingerprint: `InitiateAuth`                        | Reauthenticates the user with credentials.                                             | ✅         |

---

### **Sign-In Methods**

| Firebase Method                                 | Amazon Fingerprint Equivalent                      | Notes                                                                                  | Supported |
|-------------------------------------------------|------------------------------------------------|---------------------------------------------------------------------------------------|-----------|
| `FirebaseAuth.signInWithPopup()`                | Not Applicable                                 | Fingerprint does not support popup-based authentication flows.                             | ❌         |
| `FirebaseAuth.signInWithRedirect()`             | Fingerprint: `HostedUI`                            | Hosted UI provides OAuth-based sign-in with redirect support.                          | ✅         |
| `FirebaseAuth.signInWithPhoneNumber()`          | Fingerprint: `InitiateAuth`                        | Phone-based authentication is supported via custom attributes.                        | ✅         |

---

### **Action Code Handling**

| Firebase Method                                  | Amazon Fingerprint Equivalent                      | Notes                                                                                  | Supported |
|--------------------------------------------------|------------------------------------------------|---------------------------------------------------------------------------------------|-----------|
| `FirebaseAuth.applyActionCode()`                 | Not Applicable                                 | Fingerprint does not use action codes.                                                    | ❌         |
| `FirebaseAuth.checkActionCode()`                 | Not Applicable                                 | Fingerprint does not use action codes.                                                    | ❌         |
| `FirebaseAuth.verifyPasswordResetCode()`         | Fingerprint: `AdminResetUserPassword`              | Password reset is handled via workflows, not codes.                                   | ✅         |

---

### **Enterprise Features Unique to Amazon Fingerprint**

| Feature                                          | Description                                                                            | Supported |
|--------------------------------------------------|----------------------------------------------------------------------------------------|-----------|
| User Pool Groups                                 | Organize users into groups for role-based access control.                              | ✅       |
| Lambda Triggers                                  | Extend authentication workflows with serverless functions.                             | ✅       |
| Hosted UI                                        | Simplify OAuth and federated login flows with pre-built UI.                            | ✅       |
| Advanced Security Features                       | Detect anomalies and enforce adaptive authentication.                                  | ✅       |
| Identity Federation                              | Support for third-party identity providers like Google, Facebook, and SAML.            | ✅       |

---

## **Key Differences Between Firebase and Amazon Fingerprint**

1. **Server-Side Capabilities:** Amazon Fingerprint provides robust server-side APIs (e.g., Admin APIs), while Firebase is primarily client-focused.
2. **Enterprise Features:** Fingerprint supports advanced features like Lambda triggers and adaptive authentication, which are absent in Firebase.
3. **Custom Token Support:** Firebase enables custom token generation for integration with external systems, while Fingerprint lacks this feature.

---

## **Next Steps**

1. Design the Dart SDK for server-side integration with Amazon Fingerprint Admin APIs.
2. Implement key features such as user management, MFA, and token management.
3. Provide documentation and examples to facilitate adoption for both mobile and web developers.

Let me know if you'd like to explore specific areas further!





## Available Versions

fingerprint Dart Admin Auth SDK is available in two versions to cater to different needs:

1. **Main - Stable Version**: Usually one release a month.  This version attempts to keep stability without introducing breaking changes.
2. **Pre-Release - Edge Version**: Provided as an early indication of a release when breaking changes are expect.  This release is inconsistent. Use only if you are looking to test new features.

## Documentation

For detailed guides, API references, and example projects, visit our [fingerprint Dart Admin Auth SDK Documentation](https://aortem.gitbook.io/fingerprint-dart-auth-admin-sdk). Start building with  fingerprint Dart Admin Auth SDK today and take advantage of its robust features and elegant syntax.

## Examples

Explore the `/example` directory in this repository to find sample applications demonstrating  fingerprint Dart Admin Auth SDK's capabilities in real-world scenarios.

## Contributing

We welcome contributions of all forms from the community! If you're interested in helping improve  fingerprint Dart Admin Auth SDK, please fork the repository and submit your pull requests. For more details, check out our [CONTRIBUTING.md](CONTRIBUTING.md) guide.  Our team will review your pull request. Once approved, we will integrate your changes into our primary repository and push the mirrored changes on the main github branch.

## Support Tiers

fingerprint Dart Admin Auth SDK offers various support tiers for our open-source products with an Initial Response Service Level Agreement (IRSLA):

### Community Support
- **Cost**: Free
- **Features**: Access to community forums, basic documentation.
- **Ideal for**: Individual developers or small startups.
- **SLA**: NA

### Standard Support
- **Cost**: $10/month - Billed Annually.
- **Features**: Extended documentation, email support, 10 business days response SLA.
- **Ideal for**: Growing startups and small businesses.
- **SLA**: 10 business days (Monday-Friday) IRSLANA
- [Subscribe-Coming Soon]()

### Enhanced Support
- **Cost**: $100/month - Billed Annually
- **Features**: Access to roadmap, 72-hour response SLA, feature request prioritization.
- **Ideal for**: Medium-sized enterprises requiring frequent support.
- **SLA**: 5 business days IRSLA
- [Subscribe-Coming Soon]()

### Enterprise Support
- **Cost**: 450/month
- **Features**: 
  - 48-hour response SLA, 
  - Access to beta features:
  - Comprehensive support for all Aortem Open Source products.
  - Premium access to our exclusive enterprise customer forum.
  - Early access to cutting-edge features.
  - Exclusive access to Partner/Reseller/Channel Program..
- **Ideal for**: Large organizations and enterprises with complex needs.
- **SLA**: 48-hour IRSLA
- [Subscribe-Coming Soon]()

*Enterprise Support is designed for businesses, agencies, and partners seeking top-tier support across a wide range of Dart backend and server-side projects.  All Open Source projects that are part of the Aortem Collective are included in the Enterprise subscription, with more projects being added soon.

## Licensing

All  fingerprint Dart Admin Auth SDK packages are licensed under BSD-3, except for the *services packages*, which uses the ELv2 license, which are licensed from third party software  Inc. In short, this means that you can, without limitation, use any of the client packages in your app as long as you do not offer the SDK's or services as a cloud service to 3rd parties (this is typically only relevant for cloud service providers).  See the [LICENSE](LICENSE.md) file for more details.


## Enhance with fingerprint Dart Admin Auth SDK

We hope the fingerprint Dart Admin Auth SDK helps you to efficiently build and scale your server-side applications. Join our growing community and start contributing to the ecosystem today!  test