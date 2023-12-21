//
//  Beer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation
import UIKit
import SwiftUI

class Beer: Codable, Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var type: String
    @Published var icon: Image = Image("beericon")
    @Published var alcoholContent: Float
    @Published var calorieContent: Int
    
    init(name: String, type: String, icon: Image, alcoholContent: Float, calorieContent: Int) {
        self.name = name
        self.type = type
        self.icon = icon
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
    
    /* CODABLE */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.alcoholContent = try container.decode(Float.self, forKey: .alcoholContent)
        self.calorieContent = try container.decode(Int.self, forKey: .calorieContent)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(alcoholContent, forKey: .alcoholContent)
        try container.encode(calorieContent, forKey: .calorieContent)
     
        }
   
}

  

