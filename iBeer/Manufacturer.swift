//
//  Manufacturer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation
import PhotosUI
import SwiftUI

enum ManufacturerType {
    case domestic
    case imported
    case _default
    
    init?(rawValue: String) {
        switch rawValue {
            case "Domestic":
                self = .domestic
            case "Imported":
                self = .imported
         
            default:
                self = ._default
        }
    }
}


class Manufacturer: Identifiable, ObservableObject, Decodable {
    
    let id = UUID()
    @Published var name: String
    @Published var logo: Image?
    @Published var type: ManufacturerType
    @Published var beers: [Beer]
    @Published var isFavourited: Bool = true
    
    init(name: String, logo: Image, type: ManufacturerType, beers: [Beer]) {
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let string_logo = try container.decode(String.self, forKey: .logo)
        self.logo = Image(string_logo)
        let aux = try container.decode(String.self, forKey: .type)
        self.type = ManufacturerType(rawValue: aux) ?? ManufacturerType._default
        self.beers = try container.decode([Beer].self, forKey: .beers)
    }
    
    static func fetchData() -> [Manufacturer] {
        
        if let url = Bundle.main.url(forResource: "manufacturers", withExtension: "json") {
            do {
                
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let manufacturers = try decoder.decode([Manufacturer].self, from: data)
                return manufacturers
                
                
            } catch {
                print("Erro fetchdata")
            }
        }
        
        return []
        
    }
    
    static func calculateBeerTypes(manufacturer: Manufacturer) -> [String] {
        
        var beerTypes: [String] = []
        for beer in manufacturer.beers {
            beerTypes.append(beer.type)
        }
        
        return beerTypes
    }
    
}


