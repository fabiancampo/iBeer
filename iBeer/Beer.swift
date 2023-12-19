//
//  Beer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation
import UIKit
import SwiftUI

class Beer: Decodable, Identifiable {
    let id = UUID()
    var name: String
    var type: String
    var icon: Image = Image("beericon")
    var alcoholContent: Float
    var calorieContent: Int
    
    init(name: String, type: String, alcoholContent: Float, calorieContent: Int) {
        self.name = name
        self.type = type
        self.alcoholContent = alcoholContent
        self.calorieContent = calorieContent
    }
    
    init() {
        self.name = ""
        self.type = ""
        self.alcoholContent = 0
        self.calorieContent = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case alcoholContent
        case calorieContent
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.alcoholContent = try container.decode(Float.self, forKey: .alcoholContent)
        self.calorieContent = try container.decode(Int.self, forKey: .calorieContent)

    }
}

  

