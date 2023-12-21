//
//  Manufacturer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation
import PhotosUI
import SwiftUI


class Manufacturer: Identifiable, ObservableObject, Codable {
    let id = UUID()
    @Published var name: String
    @Published var logo: Image? = Image(systemName: "photo.fill")
    @Published var type: String
    @Published var beers: [Beer]
    
    init(name: String, logo: Image, type: String, beers: [Beer]) {
        self.name = name
        self.logo = logo
        self.type = type
        self.beers = beers
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case logo
        case type
        case beers
    }
    
    /* CODABLE */
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        /// El archivo json puede no tener la key logo
        /// Esto ocurre porque al guardar los datos, las imagenes no se guardan
        /// Pero en el primer json si que existen las declaraciones de imagenes de ejemplo
        if let string_logo = try container.decodeIfPresent(String.self, forKey: .logo) {
            self.logo = Image(string_logo)
        } else {
            
            self.logo = Image(systemName: "photo.fill")
        }
        
        self.type = try container.decode(String.self, forKey: .type)
        self.beers = try container.decode([Beer].self, forKey: .beers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(beers, forKey: .beers)
    }
    
    
}


