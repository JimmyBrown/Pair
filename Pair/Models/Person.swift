//
//  Person.swift
//  Pair
//
//  Created by Jimmy on 5/22/20.
//  Copyright © 2020 Jimmy. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
