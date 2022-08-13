# WindowsDetector

Swift Package that allows you to list all windows running on the user macOS system.

# Usage

You can use a WindowsDetector instance like any other ObservableObject, like in the state of your view: 

``` swift 
import SwiftUI
import WindowsDetector

struct WindowsListView: View {
    
    @StateObject var windowsDetector = WindowsDetector().started(pollInterval: 10)
    
    var body: some View {
        List {
            if let activeWindow = windowsDetector.activeWindow {
                Text(window.id).background(Color.red)
            }
            ForEach(windowsDetector.userWindows) {
                Text(window.id)
            }
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
