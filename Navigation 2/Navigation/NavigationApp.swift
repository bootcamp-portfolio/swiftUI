//
//  NavigationApp.swift
//  Navigation
//
//  Created by electrozone on 3/30/26.
//

import SwiftUI

@main
struct Navigation01App: App {
    @StateObject private var lampData = LampData()//********
    //메모리에 올린다?
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lampData)//************
        }
    }
}
