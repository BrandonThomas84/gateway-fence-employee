# gateway_fence_employee

A new Flutter project.

> NOTE: If you cazn't run adb on windows open a powershell instance with admin rights and run the following command: `netstat -ano | Select-String "5037"` and kill the process with the PID that is using the port 5037. Then run `adb kill-server` and `adb start-server` and try again.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Firebase Emulation

First make sure you have the firebase cli installed. If you don't have it installed you can install it by running the following command in the terminal:

```shell
npm install -g firebase-tools
```

Then you need to login to firebase by running the following command in the terminal:

```shell
firebase login
```

> NOTE: If you are using a google account that has 2FA enabled you will need to use the `firebase login --no-localhost` command instead.

Then you need to install the firebase emulators by running the following command in the terminal:

To start the firebase emulators you can either use the included VS Code task `firebase emu start` or you can run the following command in the terminal: 

```shell
firebase emulators:start --only auth,firestore,functions,hosting,ui
``` 

> The `--only` flag is optional and can be used to start only the emulators you need.

### Install JAVA

Insure you have the proper version ogf java installed. 

You can download it from here: https://www.oracle.com/java/technologies/downloads/#jdk21-windows