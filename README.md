## SECURE STORAGE

[link](https://pub.dev/packages/flutter_secure_storage)

min sdk 23
add

```xml
<uses-permission android:name="android.permission.INTERNET" />

```

in aplication add android:allowBackup="true"

```xml

    <application android:label="tv" android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher" android:allowBackup="true">
```

<!--  -->

dart fix --dry-run # preview of the proposed changes
dart fix --apply # apply the changes

<!--  -->

# LOCAL DEPLOY

Run

```
flutter pub get
flutter pub run build_runner build
```

```
flutter pub run flutter_gen:flutter_gen_command

```
