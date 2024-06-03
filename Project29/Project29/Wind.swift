//
//  Wind.swift
//  Project29
//
//  Created by leticia.dayane on 03/06/24.
//

import UIKit
//challenge 3
struct Wind {
    var dx: CGFloat
    var dy: CGFloat
    
    var direction: String {
        var dir = ""
        if dx > 0 {
            dir += "→" //vento leste
        } else if dx < 0 {
            dir += "←" //vento oeste
        }
        
        if dy > 0 {
            dir += "↑" //vento norte
        } else if dy < 0 {
            dir += "↓" //vento sul
        }
        return dir.isEmpty ? "Calm" : dir
    }
}
