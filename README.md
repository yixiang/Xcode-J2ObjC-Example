# Introduction
This is a step-by-step guide on how to Setup J2ObjC as static library in Xcode. After completing this guide, you will be able to setup a j2objc in Xcode and be ready to work. The shared java files are added to Xcode for tracking, and they generated code are compiled into a static library with ARC (automatic reference count) turned off.

# Prerequisite

The guide assumes the following.
* You J2ObjC already installed somewhere. If you have not, here is [how to](https://github.com/google/j2objc/wiki/Getting-Started]).
  * The sample project assumes installation location -- $HOME/bin/j2objc. If you have it installed at a different location, you will need to modify J2OBJC_HOME variable in LibConfig.xcconfig and AppConfig.xcconfig later.
* You have latest Xcode installed (Version 6 or above)
* You already have an iOS Xcode project created. If you are working a on Mac project, you will need to create a static library for Mac instead of iOS.
 
# Step-by-Step Guide

## Add a new target for the static library

The reason why we create a separate target for j2objc generated files, it allows us to extra build configuration to the target without affecting the main app target. One particular thing is that we want to turn off ARC for performance gains. With a separate target, we can turn off ARC on the static library target, but keep ARC on for the main app.

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/1-add-target.png)
![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/2-choose-static-lib.png)

## Fix Group Path

Your target group points to a directory that may not exist. Make sure the folder is created. You will need to put LibConfig.xcconfig into it later. What's more, not having it created will cause problem when you add your java source files later.
![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/3-fix-group-path.png)

## Adding Configuration Settings File

We now add LibConfig.xcconfig to static lib target and AppConfig.xcconfig to app target. The xcconfig files capture some common build settings associated with j2objc. We are doing it in a Settings bundle because it saves you the trouble to dig into Build Settings and find the entries to modify.

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/4-add-xcconfig.png)

Once you have the files added, copy the content of xcconfig in the sample project into them. The only things you need to modify are J2OBJC_HOME and JAVA_SOURCE_PATH. Set J2OBJC_HOME to your j2objc/dist path. Set JAVA_SOURCE_PATH to the root folder of your java source path.

Adding the files to the project doesn't make them effective. To use them, set them in the project settings.

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/5-use-xcconfig.png)

As mentioned earlier, we need to turn off ARC on the static lib. Having ARC on could cause your program an order of magnitude slower than it would with ARC off. Since j2objc is writing the code for us, turning ARC off is nothing but benefit. The ARC flagged (CLANG_ENABLE_OBJC_ARC) in turned off by LibConfig.xcconfig for you.

## Adding Java Source Files

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/6-add-java-sources.png)

## Adding Build Rules

Adding your initial set of java files.

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/7-add-build-rule.png)

## Adding Target Dependencies and Linking The Static Lib to App

Target dependency will make your static library is built before your app target is built.

![](https://raw.githubusercontent.com/yixiang/Xcode-J2ObjC-Example/master/screenshots/8-add-dependency.png)

## Ready to Work

You can now build and run your project. The j2objc generated files sit in $(SRCROOT)/Generated directory. Put Generated directory into your .gitignore because you generally don't want them tracked.

You may modify existing java files or add new java files to the project. They will automatically be transpiled.

# References
https://github.com/google/j2objc/wiki/Xcode-Build-Rules
