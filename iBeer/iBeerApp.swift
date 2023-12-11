//
//  iBeerApp.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

@main
struct iBeerApp: App {
    @StateObject private var manufacturers = Manufacturers()
    
    var body: some Scene {
        WindowGroup {
            ManufacturersListView()
                .environmentObject(manufacturers)
        }
    }
}
