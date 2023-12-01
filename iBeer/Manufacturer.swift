//
//  Manufacturer.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import Foundation


class Manufacturer: ObservableObject, Identifiable, Hashable {
    
    
    @Published var name: String
    @Published var beers: [Beer] = []
    let id = UUID()
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Manufacturer, rhs: Manufacturer) -> Bool {
            return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
}
