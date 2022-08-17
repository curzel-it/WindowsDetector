# WindowsDetector

Swift Package that allows you to list all windows running on the user macOS system.

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
