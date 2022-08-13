import Cocoa

public class WindowsDetectionService {
        
    public init() {}
    
    public func listCurrentWindows() -> [WindowInfo] {
        let options = CGWindowListOption(arrayLiteral: CGWindowListOption.optionAll)
        let windows = CGWindowListCopyWindowInfo(options, CGWindowID(0)) as NSArray?
        return (windows ?? [])
            .compactMap { $0 as? NSDictionary }
            .compactMap { WindowInfo(with: $0) }
    }
}
