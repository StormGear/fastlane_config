# Fastlane Configuration to Automate Uploads to Play Store and Notify team via Slack

<br/>

<div style="display: flex; justify-content: space-between; flex-direction: row; width: 100%">
  <img src="./assets/fastlane.png" alt="Fastlane" style="width: 50%;">
  <img src="./assets/slack.webp" alt="Slack" style="width: 50%;">
</div>

<br/>

# About Repository
- This repository contains scripts needed to automate tasks listed under [Lanes in fastlane Fastfile](#lanes-in-fastlane-fastfile) for a flutter-Firebase project.

*Fastlane* is an open-source platform aimed at simplifying Android and iOS deployment. It automates numerous tasks such as screenshots, beta deployment, and release to app stores. Fastlane can also integrate with various services, including Slack for notifications, making it a powerful tool for mobile app development and continuous delivery pipelines

*Slack* is a workplace communication platform that allows teams to chat, share files, and collaborate on projects. 


# Slack APIs Used
- [Slack API](https://api.slack.com/) - For creating apps within your workspace.
- [Upload files to Slack](https://api.slack.com/methods/files.getUploadURLExternal) - Documentation on how to use slack to upload files(in our case we upload apk files)

# Prerequisites
- Create a Firebase Android App.
- Ensure that you create a service account on GCP and allow needed permissions in your Google Play Console for the service account email.
- Install [Ruby](https://www.ruby-lang.org/en/downloads/) on your local machine.
- Set up [fastlane](https://docs.fastlane.tools/getting-started/cross-platform/flutter/) in your android directory of your flutter project.
- Create an App on slack, and add the App to the channel that you'd like to send messages to(e.g your team's channel)

# Lanes in fastlane Fastfile
> **Lane name** : increase_build_number
>> **What it does** <br>
Increase the build number in the pubspec.yaml file by 1.
Executes ruby script which performs this task.

> **Lane name** : increment_vc
>> **What it does** <br>
Increase the version code in the build.gradle(app-level) file to 1

> **Lane name** : internal
>> **What it does** <br>
Deploys app bundle to Google Play Store and notifies channel on Slack, upon success or failure

> **Lane name** : build_apk
>> **What it does** <br>
Run a shell command to build apk

> **Lane name** : upload_to_slack
>> **What it does** <br>
Upload apk to Slack Channel. It runs a script written in Ruby that utilizes the *[Slack Upload API](https://api.slack.com/methods/files.getUploadURLExternal)*. Notifies channel upon success or failure.

> **Lane name** : upload_to_firebase
>> **What it does** <br>
Releases appbundles to Firebase App Distribution.

> **Lane name** : upload_ipa
>> **What it does** <br>
Upload ios builds to app store connect. Follow this link to [learn more.](https://docs.fastlane.tools/actions/pilot/)

# Custom Ruby Scripts
<code> slack_uploader.rb </code>  - Uploads apk to Slack. <br/>
<code> increase_version.rb </code>  - Increase build number by 1 in pubspec.yaml.

# Future/Further Additions to this Repo
- I intend on including Github Actions workflows for CI/CD.
- Addition of more detailed instructions with screenshots.

# Reach Out
This repo is still in development. If you'd like clarifications on anything, please reach out at [papakofi.tech](https://papakofi.tech). Have fun automating your Play Store releases.





