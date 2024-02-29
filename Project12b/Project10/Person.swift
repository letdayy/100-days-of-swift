//
//  Person.swift
//  Project10
//
//  Created by leticia.dayane on 19/02/24.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
