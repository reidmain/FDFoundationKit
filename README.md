# Overview
An extension of Foundation Kit used in all of 1414 Degrees' projects. Below are some of the highlights of the project.

## FDLogger
A powerful logging macro with log levels that compiles down to a NOP for release builds.

## FDKeypath
A macro that converts dot syntax property calls on objects to strings to allow for compile time checking.

## FDIsEmpty
A macro that will check if any arbitrary object is "empty".

## FDURLEncoding protocol and corresponding categories
Adds methods to NSArray, NSDictionary, NSValue and NSString to allow for easy URL encoding. The protocol also allows users to extend this functionality to any of their own custom classes.

## FDValueTransformer
A block based subclass of NSValueTransformer.

## FDDeclaredProperty
A class that adds an Objective-C wrapper around the metadata associated with property declaration.

## FDWeakReference
A class designed to allow for objects to be weakly held inside collection objects i.e. NSArray. Also macros to "weakify" and "strongify" objects particularly self to avoid retain loops.

# Installation
There are three supported ways to use FDFoundationKit. All three methods assume your Xcode project is using modules.

## 1. Use subprojects
1. Add the "FDFoundationKit" framework project as a subproject or add it to your workspace.
2. Add "FDFoundationKit (iOS/Mac)" to the "Target Dependencies" section of your target.
3. Add "@import FDFoundationKit" to wherever you want to use it.

## 2. Copy source code files
Copy all the files under the "FDFoundationKit" folder into your project.

## 3. CocoaPods
Simply add `pod "FDFoundationKit", "~> 1.0.0"` to your Podfile.
