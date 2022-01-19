//
//  Car.swift
//  CarCustomiser
//
//  Created by Clyde Lartey on 16/01/2022.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    
    func displayStats() -> String {
          return """
              Make: \(make)
              Model: \(model)
              Top Speed: \(topSpeed)mph
              Acceleration (0-60 in): \(acceleration)s
              Handling: \(handling)
              """
    }
}
