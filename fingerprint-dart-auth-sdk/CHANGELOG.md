## 0.0.1

### Added
- **Global .gitignore**  
  - Ignore Flutter/Dart build and tool files (`build/`, `.dart_tool/`, `.flutter-plugins*`) and IDE folders (`.idea/`, `.vscode/`).  
- **Automated Release Workflow**  
  - In CI scripts, configure Git user/email from `GITLAB_USERNAME`/`_GIT_USER` env-vars.  
  - Set remote origin to include credentials for tagging.  
  - Create and push annotated Git tags `v$VERSION`.  
  - Extract release notes for this version from `CHANGELOG.md` via `awk`.  
  - Publish a GitLab Release via the API (`curl … /releases`).

### Changed
- **GitHub Issue Templates**  
  - `.github/ISSUE_TEMPLATE/community-documentation.yml`: removed `ginjardev` from the assignees list.  
  - `.github/ISSUE_TEMPLATE/config.yml`: updated rules and cleaned up deprecated entries.  
- **CI Pipeline Cleanup**  
  - Removed the legacy “collaboration” echo-loop (scanning `error_issues.txt`).  
  - Deleted obsolete artifact paths (`info_issues.txt`, `warning_issues.txt`, `error_issues.txt`).  
  - Dropped deprecated jobs: `unit_testing`, `analyze_sample_apps`, `analyze_example`, and `release`.

### Removed
- **Obsolete CI Jobs & Artifacts**  
  - All references to the old sample-app analysis and artifact-gathering jobs have been purged from the pipeline.  

## 0.0.1-pre+2

- Add All Methods
- Cleanup Repo

## 0.0.1-pre+1

- Add All Methods
- Cleanup Repo

## 0.0.1-pre

- Initial pre-release version of the fingerprint Dart Auth SDK.
