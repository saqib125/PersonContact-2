//
//  ReadData.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import Foundation

var Person: [User] = load("data.json")

func load<T: Decodable>(_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
func writeJSON(items: [User]) {
    do {
        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("data.json")
        
        let encoder = JSONEncoder()
        try encoder.encode(items).write(to: fileURL)
    } catch {
        print(error.localizedDescription)
    }
}

