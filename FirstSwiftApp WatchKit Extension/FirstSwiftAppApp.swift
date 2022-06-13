//
//  FirstSwiftAppApp.swift
//  FirstSwiftApp WatchKit Extension
//
//  Created by Alexandre Javet on 09.06.22.
//

import SwiftUI

@main
struct FirstSwiftAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
