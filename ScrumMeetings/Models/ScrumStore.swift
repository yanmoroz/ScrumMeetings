//
//  ScrumStore.swift
//  SUISandbox
//
//  Created by Yan Moroz on 12.02.2024.
//

import Foundation

@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums = [DailyScrum]()
    
    private static var fileURL: URL {
        get throws {
            try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            .appendingPathComponent("scrums.data")
        }
    }
    
    func load() async throws {
        let task = Task<[DailyScrum], Error> {
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                return []
            }
            
            return try JSONDecoder().decode([DailyScrum].self, from: data)
        }
        self.scrums = try await task.value
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL
            try data.write(to: outfile)
        }
        try await task.value
    }
}
