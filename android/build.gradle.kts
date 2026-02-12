allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")

    plugins.withId("com.android.library") {
        val androidExtension = extensions.findByName("android")
        if (androidExtension is com.android.build.gradle.LibraryExtension) {
            if (androidExtension.namespace == null) {
                androidExtension.namespace =
                    "com.fkmeup.${project.name.replace('-', '_')}"
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
