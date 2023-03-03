#if os(macOS)
import Cocoa
#endif

public class WindowsDetectionService {
    public init() {}
    
    public func listCurrentWindows() -> [WindowInfo] {
#if os(macOS)
        let options = CGWindowListOption(arrayLiteral: .optionOnScreenOnly)
        let windows = CGWindowListCopyWindowInfo(options, CGWindowID(0)) as NSArray?
        let windowsInfo = (windows ?? [])
            .compactMap { $0 as? NSDictionary }
            .compactMap { WindowInfo(with: $0) }
        
        return windowsInfo
#else
        return []
#endif
    }
}
