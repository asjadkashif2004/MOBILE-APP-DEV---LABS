// Top‑level (project) Gradle file for the Android side of your Flutter app.

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // ▼ existing or generated classpaths (examples, keep yours)
        // classpath("com.android.tools.build:gradle:8.4.0")
        // classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.24")

        // ▼▼ ADDED: Firebase / Google Services plugin
        classpath("com.google.gms:google-services:4.4.1")
    }
}

/* ---------- everything below is exactly what you already had ---------- */

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Relocate build outputs to the Flutter‑level build folder
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Ensure the :app module is evaluated first
subprojects {
    project.evaluationDependsOn(":app")
}

// Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
