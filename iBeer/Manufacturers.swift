//
//  Manufacturers.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import Foundation

class Manufacturers: ObservableObject {
    @Published var manufacturers: [Manufacturer] = [Manufacturer(name: "Mahou")]
}
