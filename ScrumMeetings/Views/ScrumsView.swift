//
//  ScrumsView.swift
//  SUISandbox
//
//  Created by Yan Moroz on 10.02.2024.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrum")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(scrums: $scrums,
                          isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase, initial: false) { _, newValue in
            if newValue == .inactive {
                saveAction()
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData),
               saveAction: {})
}
