//
//  ContentView.swift
//  Demo
//
//  Created by Federico Curzel on 17/08/22.
//

import SwiftUI
import WindowsDetector

struct WindowsListView: View {
    
    @StateObject var windowsDetector = WindowsDetector().started(pollInterval: 1)
    
    var body: some View {
        List(windowsDetector.userWindows) { window in
            Text(window.description)
                .background(window.isFrontmost ? Color.red : Color.clear)
        }
    }
}
