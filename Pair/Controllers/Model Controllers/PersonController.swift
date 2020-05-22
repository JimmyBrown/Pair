//
//  PersonController.swift
//  Pair
//
//  Created by Jimmy on 5/22/20.
//  Copyright © 2020 Jimmy. All rights reserved.
//

import Foundation

class PersonController {
    
    private init() {
        loadFromPersistence()
    }
    
    
    // MARK: - Shared Instance
    static let sharedInstance = PersonController()
    
    // MARK: - Source of Truth
    var people: [Person] = []
    
    // MARK: - Properties
    var pairs: [[Person]] {
        var pairs: [[Person]] = []
        let people = PersonController.sharedInstance.people
        var counter = 0
        
        if people.count > 1 && people.count % 2 == 0 {
            while counter < people.count {
                var personArray: [Person] = []
                personArray.append(people[counter])
                personArray.append(people[counter + 1])
                pairs.append(personArray)
                counter += 2
            }
        } else if people.count > 1 {
            while counter < people.count - 1 {
                var personArray: [Person] = []
                personArray.append(people[counter])
                personArray.append(people[counter + 1])
                pairs.append(personArray)
                counter += 2
            }
            
            let personArray = [people[people.count - 1]]
            pairs.append(personArray)
            
        } else {
            while counter < people.count {
                var personArray: [Person] = []
                personArray.append(people[counter])
                pairs.append(personArray)
                counter += 1
            }
        }
        return pairs
    }
    
    func addPerson(person: Person) {
        people.append(person)
        saveToPersistence()
    }
    
    func deletePerson(person: Person) {
        guard let index = people.firstIndex(of: person) else { return }
        people.remove(at: index)
        saveToPersistence()
    }
    
    func randomize() {
        people.shuffle()
        saveToPersistence()
    }
    
    // MARK: - Persistence
    
    func createFileForPersistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Pairs.json")
        return fileURL
    }
    
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(people)
            try data.write(to: createFileForPersistentStore())
        } catch {
            print("Error saving to persistence: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: createFileForPersistentStore())
            let decodedData = try jsonDecoder.decode([Person].self, from: data)
            people = decodedData
        } catch {
            print("Error loading data from persistence: \(error.localizedDescription)")
        }
    }
}
