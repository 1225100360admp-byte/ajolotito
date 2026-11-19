# Configuración nativa (una sola vez, después de `flutter create`)

## android/app/src/main/AndroidManifest.xml
Dentro de <manifest> (fuera de <application>):

    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>

Dentro de <application>:

    <receiver android:exported="false"
      android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
    <receiver android:exported="false"
      android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
      <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED"/>
        <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
        <action android:name="android.intent.action.QUICKBOOT_POWERON" />
        <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
      </intent-filter>
    </receiver>

## android/app/build.gradle.kts

    android { compileOptions { isCoreLibraryDesugaringEnabled = true } }
    dependencies { coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") }

(Las versiones exactas las dicta el README de flutter_local_notifications.)

## ios/Runner/AppDelegate.swift
Dentro de application(_:didFinishLaunchingWithOptions:), antes del return:

    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

## Chrome
En Chrome la app usa `PuertoDemo` (no hay notificaciones del sistema); la UI y
el flujo de permisos sí funcionan. Para notificaciones reales usa Android/iOS.
