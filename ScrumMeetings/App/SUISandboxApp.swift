//
//  SUISandboxApp.swift
//  SUISandbox
//
//  Created by Yan Moroz on 25.01.2024.
//

import SwiftUI

@main
struct SUISandboxApp: App {
    @StateObject var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $store.scrums) {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
