//
//  Manufacturer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 11/12/23.
//

import Foundation

enum ManufacturerType {
    case domestic
    case imported
}

class Manufacturer: Identifiable, ObservableObject {
    
    let id = UUID()
    @Published var name: String
    @Published var logo: String
    @Published var type: ManufacturerType
    @Published var beers: [Beer]
    @Published var isFavourited: Bool = true
    
    init(name: String, logo: String, type: ManufacturerType, beers: [Beer]) {
        self.name = name
        self.logo = logo
        self.type = type
        self.beers = beers
    }
    
    
}
