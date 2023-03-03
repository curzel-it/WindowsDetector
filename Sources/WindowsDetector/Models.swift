import CoreGraphics
import Foundation

#if os(macOS)
import Cocoa
#endif

public struct WindowInfo {
    public let alpha: CGFloat
    public let frame: CGRect
    public let id: Int
    public let layer: Int
    public let processName: String?
    public let processId: Int?
    public let title: String?
    
    init?(with dict: NSDictionary) {
        guard let windowNumber = dict["kCGWindowNumber"] as? Int else { return nil }
        guard let windowBoundsDict = dict["kCGWindowBounds"] as? NSDictionary else { return nil }
        guard let windowBounds = CGRect(from: windowBoundsDict) else { return nil }
        
        alpha = dict["kCGWindowAlpha"] as? CGFloat ?? 0
        frame = windowBounds
        id = windowNumber
        layer = dict["kCGWindowLayer"] as? Int ?? 0
        processId = dict["kCGWindowOwnerPID"] as? Int
        processName = dict["kCGWindowOwnerName"] as? String
        title = dict["kCGWindowName"] as? String
    }
}

public extension WindowInfo {
    var isVisible: Bool {
        let isOpaque = alpha > 0
        let sizeNotZero = frame.size != .zero
        let isVisibleLayer = layer >= 0
        return isOpaque && sizeNotZero && isVisibleLayer
    }
}

public extension WindowInfo {
    var isMenuItem: Bool {
        frame.minY == 0 && frame.height < 25
    }
}

public extension WindowInfo {
    var isFrontmost: Bool {
        #if os(macOS)
        let topProcess = Int(NSWorkspace.shared.frontmostApplication?.processIdentifier ?? 0)
        return processId == topProcess
        #else
        return false
        #endif
    }
}

extension WindowInfo {
    private static let knownSystemProcesses: [String] = [
        "control centre",
        "dock",
        "menubar",
        "notification centre",
        "screencapture",
        "screenshot",
        "spotlight",
        "window server"
    ]
    
    public var isSystemProcess: Bool {
        WindowInfo.knownSystemProcesses.contains(processName?.lowercased() ?? "")
    }
}

extension WindowInfo: CustomStringConvertible {
    public var description: String {
        let name = title ?? processName ?? "Window"
        return "\(name) { id=\(id); process=\(processName ?? "n/a") }"
    }
}

extension WindowInfo: Identifiable {}

extension WindowInfo: Equatable {
    public static func == (lhs: WindowInfo, rhs: WindowInfo) -> Bool {
        lhs.id == rhs.id
    }
}
