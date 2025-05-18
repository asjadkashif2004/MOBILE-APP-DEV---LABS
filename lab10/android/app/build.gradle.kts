
plugins {
    id("com.android.application")
    id("kotlin-android")

    // Google‑services Gradle plugin (adds `google-services.json` processing)
    id("com.google.gms.google-services")

    // The Flutter Gradle Plugin must be applied AFTER the Android & Kotlin plugins
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.lab9"

    compileSdk = flutter.compileSdkVersion
    ndkVersion  = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // ↳ change to your own ID if you later rename the package
        applicationId = "com.example.lab9"

        // Values inherited from the Flutter `local.properties`
        minSdk       = flutter.minSdkVersion
        targetSdk    = flutter.targetSdkVersion
        versionCode  = flutter.versionCode
        versionName  = flutter.versionName
    }

    buildTypes {
        release {
            // Sign with debug keys for now so `flutter run --release` works
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    // Path back to the Flutter project’s root (do not change)
    source = "../.."
}
