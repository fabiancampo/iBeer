//
//  Beer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation
import UIKit

class Beer {
    var name: String
    var type: BeerType
    var icon: UIImage = UIImage(named: "beericon")!
    var alcoholContent: Float
    var calorieContent: Float
    
    init(name: String, type: BeerType, alcoholContent: Float, calorieContent: Float) {
        self.name = name
        self.type = type
        self.alcoholContent = alcoholContent
        self.calorieContent = calorieContent
    }
    
    init() {
        self.name = ""
        self.type = BeerType._default
        self.alcoholContent = 0
        self.calorieContent = 0
    }
}

enum BeerType {
    case pilsen
    case ipa
    case lager
    case _default
}
