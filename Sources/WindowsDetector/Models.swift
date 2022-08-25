import Cocoa

public struct WindowInfo {
    
    public let alpha: CGFloat
    public let frame: CGRect
    public let id: Int
    public let layer: Int
    public let processName: String?
    public let processId: Int?
    public let sharingState: CGWindowSharingType
    public let title: String?
    
    init?(with dict: NSDictionary) {
        guard
            let windowNumber = dict["kCGWindowNumber"] as? Int,
            let windowBounds = CGRect(from: dict["kCGWindowBounds"] as? NSDictionary)
        else { return nil }
        
        alpha = dict["kCGWindowAlpha"] as? CGFloat ?? 0
        frame = windowBounds
        id = windowNumber
        layer = dict["kCGWindowLayer"] as? Int ?? 0
        processId = dict["kCGWindowOwnerPID"] as? Int
        processName = dict["kCGWindowOwnerName"] as? String
        sharingState = CGWindowSharingType(rawValue: dict["kCGWindowSharingState"] as? UInt32 ?? 0) ?? .none
        title = dict["kCGWindowName"] as? String
    }
}

// MARK: - Visibility

extension WindowInfo {
    
    public var isVisible: Bool {
        let isOpaque = alpha > 0
        let sizeNotZero = frame.size != .zero
        let isVisibleLayer = layer >= 0
        return isOpaque && sizeNotZero && isVisibleLayer
    }
}

// MARK: - Menu bar

extension WindowInfo {
    
    public var isMenuItem: Bool {
        frame.minY == 0 && frame.height < 25
    }
}

// MARK: - Frontmost window

extension WindowInfo {
    
    public var isFrontmost: Bool {
        processId == NSWorkspace.shared.frontmostProcessId
    }
}

// MARK: - System Processes

extension WindowInfo {
    
    private static let knownSystemProcesses: [String] = [
        "control centre",
        "dock",
        "menubar",
        "screencapture",
        "screenshot",
        "spotlight",
        "window server"
    ]
    
    public var isSystemProcess: Bool {
        WindowInfo.knownSystemProcesses.contains(processName?.lowercased() ?? "")
    }
}

// MARK: - String Convertible

extension WindowInfo: CustomStringConvertible {
    
    public var description: String {
        let name = title ?? processName ?? "Window"
        return "\(name) { id=\(id); process=\(processName ?? "n/a") }"
    }
}

// MARK: - Identifiable

extension WindowInfo: Identifiable {}

// MARK: - Equatable

extension WindowInfo: Equatable {
    
    public static func == (lhs: WindowInfo, rhs: WindowInfo) -> Bool {
        lhs.id == rhs.id
    }
}
