import Cocoa

extension NSWorkspace {
    
    var frontmostProcessId: Int? {
        Int(frontmostApplication?.processIdentifier ?? 0)
    }
}

extension CGRect {
    
    init?(from someBounds: NSDictionary?) {
        guard let frameDict = someBounds,
              let x = frameDict["X"] as? CGFloat,
              let y = frameDict["Y"] as? CGFloat,
              let width = frameDict["Width"] as? CGFloat,
              let height = frameDict["Height"] as? CGFloat
        else { return nil }
        self.init(x: x, y: y, width: width, height: height)
    }
}
