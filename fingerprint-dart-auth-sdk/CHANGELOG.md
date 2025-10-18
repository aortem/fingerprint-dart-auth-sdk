# 0.0.2

### Added

* Documentation improvements for `README.md` and `example/` test setup to guide consumers on integrating the testing helpers.
* Added `license:` field explicitly to **pubspec.yaml** for pub.dev compliance.
* Introduced structured dependency organization (core vs. dev tooling separation).

### Changed

* Refactored **pubspec.yaml** to correctly categorize dependencies:

  * Moved `build_runner` out of dependencies (no longer required or exported).
  * Retained `build_test`, `mockito`, `coverage`, `http`, and `test` as core runtime dependencies so they’re available transitively to consumers.
* Cleaned up **lib/ds_tools_testing.dart** by removing invalid `build_runner` export.
* Normalized export order for clarity and lint compliance.
* Updated repository and metadata fields to match current `dartstream` namespace.

### Fixed

* Analyzer error: *Target of URI doesn't exist: 'package:build_runner/build_runner.dart'* by removing invalid import.
* Minor typo and spacing corrections in `pubspec.yaml` and top-level documentation.
* Ensured all exported libraries exist and resolve correctly in analyzer and consumer packages.

### Removed

* Invalid export of `build_runner` (no longer included in library or dependency list).
* Deprecated internal mocks and redundant test references.

### Notes

* **No breaking API changes** for consumers.
* Consumers can continue using:

  ```dart
  import 'package:ds_tools_testing/ds_tools_testing.dart';
  ```

  without modification.
* Package now conforms to **pub.dev scoring guidelines** (metadata, license, example, and docs).
* Next step: prepare minor bump `0.2.0` for adding optional `browser_test` exports once reviewed.


## 0.0.1

### Added
- **Global .gitignore**  
  Added a `.gitignore` at the root of `fingerprint-dart-auth-sdk/` to ignore Flutter/Dart build artifacts (`build/`, `.dart_tool/`, `.flutter-plugins*`) and IDE folders (`.idea/`, `.vscode/`).

- **Automated Release Workflow**  
  Introduced CI scripts under `fingerprint-dart-auth-sdk/ci/` (and corresponding GitLab-CI hooks) to:  
  - Auto-configure Git user/email from `GITLAB_USERNAME`/`_GIT_USER` env-vars  
  - Create and push annotated tags `v$VERSION`  
  - Extract the release notes for this version from `CHANGELOG.md`  
  - Publish a GitLab Release via the API

### Changed
- **Example App Updates**  
  - Renamed the sample-app README title:  
    `firebase-dart-admin-sample-app` → `firebase-dart-sample-app`  
  - Bumped the Dart SDK constraint in  
    `example/fingerprint-dart-auth-sdk-flutter-mobile-app/pubspec.yaml` from `^3.7.2` to `^3.9.0`.  
  - Updated Android config in  
    `example/.../android/app/oldbuild.gradle` and  
    `AndroidManifest.xml` to reflect the new bundle identifiers.  
  - Tweaked Linux CMakeLists in the example for updated target names.

- **Test Suite Polish**  
  - Reformatted several `test/unit/api/…` and `test/unit/types/…` files for consistent trailing commas and single-line constructors.  
  - Fixed JSON-instantiation in `fingerprint_events_update_request_test.dart` to throw on missing `eventId`.

- **GitHub Issue Templates**  
  - In `.github/ISSUE_TEMPLATE/community-documentation.yml`, removed `ginjardev` from the default assignees.  
  - Cleaned up deprecated fields in `.github/ISSUE_TEMPLATE/config.yml`.

### Removed
- **Obsolete CI Artifacts & Jobs**  
  - Deleted all references to `info_issues.txt`, `warning_issues.txt`, and `error_issues.txt` in the pipeline configs under `fingerprint-dart-auth-sdk/`.  
  - Purged the deprecated `unit_testing`, `analyze_sample_apps`, and `release` jobs from the CI definition.



## 0.0.1-pre+2

- Add All Methods
- Cleanup Repo

## 0.0.1-pre+1

- Add All Methods
- Cleanup Repo

## 0.0.1-pre

- Initial pre-release version of the fingerprint Dart Auth SDK.
