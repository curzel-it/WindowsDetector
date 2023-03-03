import CoreGraphics
import Foundation

extension CGRect {
    init?(from frameDict: NSDictionary) {
        guard let x = frameDict["X"] as? CGFloat,
              let y = frameDict["Y"] as? CGFloat,
              let width = frameDict["Width"] as? CGFloat,
              let height = frameDict["Height"] as? CGFloat
        else { return nil }
        self.init(x: x, y: y, width: width, height: height)
    }
}
