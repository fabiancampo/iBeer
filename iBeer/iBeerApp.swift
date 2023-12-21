//
//  iBeerApp.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

@main
struct iBeerApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var manufacturersViewModel = ManufacturersViewModel()
    
    var body: some Scene {
        WindowGroup {
            ManufacturersListView(manufacturersViewModel: manufacturersViewModel)
              
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                manufacturersViewModel.saveAll()
            }
        }
    }
}
