import Cocoa

public class WindowsDetector: ObservableObject {
    
    private let service = WindowsDetectionService()
    
    @Published public var windows: [WindowInfo] = []
    @Published public var userWindows: [WindowInfo] = []
    @Published public var activeWindow: WindowInfo?
    
    private var timer: Timer!
    
    public init() {}
    
    @discardableResult
    public func started(pollInterval: TimeInterval) -> WindowsDetector {
        start(pollInterval: pollInterval)
        return self
    }
    
    public func start(pollInterval: TimeInterval) {
        stop()
        timer = Timer(timeInterval: pollInterval, repeats: true) { _ in self.update() }
        RunLoop.current.add(timer, forMode: .common)
        update()
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func update() {
        windows = service.listCurrentWindows()
        userWindows = windows
            .filter { $0.isVisible }
            .filter { !$0.isSystemProcess }
            .filter { !$0.isMenuItem }        
        activeWindow = userWindows.first { $0.isFrontmost }
    }
}

