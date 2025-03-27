# firebase-dart-admin-sample-app

## Description

A sample app to showcase the process of installing, setting up and using the entra_id_dart_auth_sdk

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

- Add the absolute path of the entra_id_dart_auth_sdk to the sample app's pubspec.yaml file
  ```yaml
  dependencies:
  entra_id_dart_auth_sdk:
    path: /Users/user/Documents/GitLab/entra_id_dart_auth_sdk/entra_id_dart_auth_sdk
  ```

## Usage

    Depending on the platform entra_id_dart_auth_sdk can be initialized via three methods

**Web:**
For Web we use Enviroment Variable

```
import 'package:flutter/material.dart';
import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';

    void main() async
    {

        FirebaseApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);

        FirebaseApp.instance.getAuth();

        runApp(const MyApp());
    }

```

- Import the entra_id_dart_auth_sdk and the material app
  ```
  import 'package:flutter/material.dart';
  import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';
  ```
- In the main function call the 'FirebaseApp.initializeAppWithEnvironmentVariables' and pass in your api key and project id

  ```
    FirebaseApp.initializeAppWithEnvironmentVariables(apiKey:'api_key',projectId: 'project_id',);
  ```

- Aftwards call the 'FirebaseApp.instance.getAuth()'
  ```
    FirebaseApp.instance.getAuth();
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
    import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';

    void main() async
    {
        FirebaseApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');

        FirebaseApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the entra_id_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';
  ```

- In the main function call the 'FirebaseApp.initializeAppWithServiceAccount' function and pass the path to your the json file
  ```
   FirebaseApp.initializeAppWithServiceAccount(serviceAccountKeyFilePath: 'path_to_json_file');
  ```
- Aftwards call the 'FirebaseApp.instance.getAuth()'
  ```
    FirebaseApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```

## ServiceAccountImpersonation

    ```
    import 'package:flutter/material.dart';
    import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';

    void main() async
    {
        FirebaseApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: service_account_email, userEmail: user_email)

        FirebaseApp.instance.getAuth();
        runApp(const MyApp());
    }
    ```

- Import the entra_id_dart_auth_sdk and the material app

  ```
  import 'package:flutter/material.dart';
  import 'package:entra_id_dart_auth_sdk/entra_id_dart_auth_sdk.dart';
  ```

- In the main function call the 'FirebaseApp.initializeAppWithServiceAccountImpersonation' function and pass the service_account_email and user_email
  ```
    FirebaseApp.initializeAppWithServiceAccountImpersonation(serviceAccountEmail: serviceAccountEmail,userEmail:userEmail,)
  ```
- Aftwards call the 'FirebaseApp.instance.getAuth()'
  ```
    FirebaseApp.instance.getAuth();
  ```
- Then call the 'runApp(const MyApp())' method

  ```
      runApp(const MyApp())

  ```
