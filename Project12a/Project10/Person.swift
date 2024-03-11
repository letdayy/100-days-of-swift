//
//  Person.swift
//  Project10
//
//  Created by leticia.dayane on 19/02/24.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
        let image = aDecoder.decodeObject(forKey: "image") as? String
        else { return nil }
        self.init(name: name, image: image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.image, forKey: "image")
    }
}
