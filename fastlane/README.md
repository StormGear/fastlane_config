fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android beta

```sh
[bundle exec] fastlane android beta
```

Submit a new Beta Build to Crashlytics Beta

### android increase_build_number

```sh
[bundle exec] fastlane android increase_build_number
```

Increment the build number in pubspec.yaml[works]

### android increment_vc

```sh
[bundle exec] fastlane android increment_vc
```

Increment version code in build.gradle

### android internal

```sh
[bundle exec] fastlane android internal
```

Deploy a new version to the Google Play Store

### android build_apk

```sh
[bundle exec] fastlane android build_apk
```

Build release APK

### android upload_to_slack

```sh
[bundle exec] fastlane android upload_to_slack
```

Upload the APK to Slack channel

### android upload_to_firebase

```sh
[bundle exec] fastlane android upload_to_firebase
```

Upload AAB to Firebase App Distribution

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
