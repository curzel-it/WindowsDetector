# WindowsDetector

Swift Package to list all windows running on the user macOS system.

This solution is App Store-compliant and does not require user actions, nor special permissions.

This is being used [in production](https://apps.apple.com/app/desktop-pets/id1575542220) by my Desktop Pets app (which is also [here on GitHub](https://github.com/curzel-it/pet-therapy)).

# Usage

You can use a WindowsDetector instance like any other ObservableObject, like in the state of your view: 

``` swift 
import SwiftUI
import WindowsDetector

struct WindowsListView: View {
    
    @StateObject var windowsDetector = WindowsDetector().started(pollInterval: 1)
    
    var body: some View {
        List(windowsDetector.userWindows) { window in
            Text(window.description)
                .background(window.isFrontmost ? Color.red : Color.clear)
        }
    }
}
```

Or, you can use the underlying service as you need:
``` swift
import WindowsDetector

let service = WindowsDetectionService()
let windows = service.listCurrentWindows()
```
