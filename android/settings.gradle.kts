// android/settings.gradle.kts

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        // 1. Flutter 官方镜像源 (最优先)
        maven("https://storage.flutter-io.cn/download.flutter.io")

        // 2. 阿里云镜像
        maven("https://maven.aliyun.com/repository/public")
        maven("https://maven.aliyun.com/repository/google")

        // 3. 官方源（可选，如果代理配置好了可以放开）
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    // 使用这个更灵活的规则来兼容各种插件
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        // 1. Flutter 官方镜像源 (最优先)
        maven("https://storage.flutter-io.cn/download.flutter.io")

        // 2. 阿里云镜像
        maven("https://maven.aliyun.com/repository/public")
        maven("https://maven.aliyun.com/repository/google")

        // 3. 官方源（可选，如果代理配置好了可以放开）
        google()
        mavenCentral()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")