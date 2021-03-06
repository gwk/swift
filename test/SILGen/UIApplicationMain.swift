// RUN: rm -rf %t && mkdir -p %t
// RUN: %build-silgen-test-overlays

// RUN: %target-swift-frontend(mock-sdk: -sdk %S/Inputs -I %t) -emit-silgen -parse-as-library %s | FileCheck %s
// RUN: %target-swift-frontend(mock-sdk: -sdk %S/Inputs -I %t) -emit-ir -parse-as-library %s | FileCheck %s -check-prefix=IR

// REQUIRES: OS=ios
// REQUIRES: objc_interop

import Foundation
import UIKit

@UIApplicationMain
class MyDelegate : UIApplicationDelegate {}

// CHECK-LABEL: sil @main
// CHECK:         function_ref @UIApplicationMain
// IR-LABEL: define{{( protected)?}} i32 @main
// IR:            call i32 @UIApplicationMain

// Ensure that we coexist with normal references to the functions we
// implicitly reference in the synthesized main.
func foo(x: AnyObject.Type) -> String {
  return NSStringFromClass(x)
}
func bar() {
  UIApplicationMain(0, nil, nil, nil)
}
