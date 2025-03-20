# fingerprint-dart-sample-app

## Description

A sample app to showcase the process of installing, setting up and using the fingerprint_dart_auth_sdk

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

- Add the absolute path of the fingerprint_dart_auth_sdk to the sample app's pubspec.yaml file
  ```yaml
  dependencies:
  fingerprint_dart_auth_sdk:
    path: /Users/user/Documents/GitLab/fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk
  ```

## Usage

    Depending on the platform fingerprint_dart_auth_sdk can be initialized via three methods

**Web:**
For Web we use Enviroment Variable

```
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

    void main() async
    {

        fingerprintApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);

        fingerprintApp.instance.getAuth();

        runApp(const MyApp());
    }

```

- Import the fingerprint_dart_auth_sdk and the material app
  ```
  import 'package:flutter/material.dart';
  import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
  ```
- In the main function call the 'fingerprintApp.initializeAppWithEnvironmentVariables' and pass in your api key and project id

  ```
    fingerprintApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);
  ```

- Aftwards call the 'fingerprintApp.instance.getAuth()'
  ```
    fingerprintApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```

**Mobile:**
For mobile we can use either [Service Account](#serviceaccount) or [Service account impersonation](#ServiceAccountImpersonation)

## ServiceAccount

    ```
    import 'package:flutter/material.dart';
    import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

    void main() async
    {
        fingerprintApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');

        fingerprintApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the fingerprint_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
  ```

- In the main function call the 'fingerprintApp.initializeAppWithServiceAccount' function and pass the path to your the json file
  ```
   fingerprintApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');
  ```
- Aftwards call the 'fingerprintApp.instance.getAuth()'
  ```
    fingerprintApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```

## ServiceAccountImpersonation

    ```
    import 'package:flutter/material.dart';
    import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

    void main() async
    {
        fingerprintApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: service_account_email, userEmail: user_email)

        fingerprintApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the fingerprint_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
  ```

- In the main function call the 'fingerprintApp.initializeAppWithServiceAccountImpersonation' function and pass the service_account_email and user_email
  ```
    fingerprintApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: serviceAccountEmail,userEmail:userEmail,)
  ```
- Aftwards call the 'fingerprintApp.instance.getAuth()'
  ```
    fingerprintApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```
