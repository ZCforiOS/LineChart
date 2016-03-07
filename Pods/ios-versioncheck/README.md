ios-versioncheck
================

Quick, cached version checking for iOS

Usage:
~~~~
#import "DLVersionCheck.h"

// ...
if(majorOSVersion() >= 7) {
    NSLog(@"We're on the shiny new!");
}
else {
    NSLog(@"Back in skeuomorphism-land.");
}
~~~~

