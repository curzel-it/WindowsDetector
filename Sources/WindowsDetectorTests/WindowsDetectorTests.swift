import XCTest
@testable import WindowsDetector

class WindowsDetectorTests: XCTestCase {
    func testCanListWindows() {        
        let service = WindowsDetectionService()
        let windows = service.listCurrentWindows()
        windows.forEach {
            print("Window \($0.title ?? $0.processName ?? "unknown") \($0.frame)")
        }
        #if os(macOS)
        XCTAssertGreaterThan(windows.count, 0)
        #else
        XCTAssertEqual(0, windows.count)
        #endif
    }
}
