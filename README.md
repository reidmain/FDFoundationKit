# Overview
An extension of Foundation Kit used in all of 1414 Degrees' projects.

Some of the highlights of this project include:

**FDLogger:** A powerful logging macro with log levels whose cutoff can be customized based on the build configuration. Also compiles down to a NOP for release builds.

**FDKeypath:** A macro for generating key path strings that are checked at compile time.

**FDIsEmpty:** A macro that will check if any arbitrary object is "empty".

**FDValueTransformer:** A block-based subclass of NSValueTransformer.

**FDDeclaredProperty:** An Objective-C wrapper around the metadata associated with property declaration. There is also a category on NSObject that allows you to easily retrieve a FDDeclaredProperty for a given key path.

**FDWeakReference:** A wrapped class designed to allow any object to be weakly retained inside collection objects i.e. NSArray. Also macros to "weakify" and "strongify" objects, particularly self, to avoid retain loops.

**FDURLEncoding protocol and corresponding categories:** Makes NSArray, NSDictionary, NSValue and NSString conform to the FDURLEncoding protocol which adds a method for easy URL encoding. Users can extend this functionality to their own classes by simply having them conform to the protocol as well.

# Installation
There are two supported methods for FDFoundationKit. Both methods assume your Xcode project is using modules.

### 1. Subprojects
1. Add the "FDFoundationKit" project inside the "Framework Project" directory as a subproject or add it to your workspace.
2. Add "FDFoundationKit (iOS/Mac)" to the "Target Dependencies" section of your target.
3. Use "@import FDFoundationKit" inside any file that will be using FDFoundationKit.

### 2. CocoaPods
Simply add `pod "FDFoundationKit", "~> 1.0.0"` to your Podfile.
