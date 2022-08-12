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
                WindowInfoItem(window: activeWindow)
                    .background(Color.red)
            }
            ForEach(windowsDetector.userWindows) {
                WindowInfoItem(window: $0)
            }
        }
    }
}

private struct WindowInfoItem: View {
    
    let window: WindowInfo
    
    var body: some View {
        HStack {
            Text("\(window.id)").frame(width: 50)
            Text(window.title ?? "n/a").frame(width: 100)
            Text(window.processName ?? "n/a").frame(width: 200)
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
