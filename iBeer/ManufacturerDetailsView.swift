//
//  BreweryDetailsView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturerDetailsView: View {
    
    var name: String
    var body: some View {
        
        List {
            
            Section {
                VStack() {
                    Image("mahou")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                        .clipShape(.capsule)
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                
                
            }
            
            Section {
                HStack {
                    Image("beericon")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Cerveza 1")
                }
                
                
                HStack {
                    Image(systemName: "mug")
                    Text("Cerveza 1")
                }
            } header: {
                Text("Categoria 1")
            }
            
            Section {
                Text("Cerveza 1")
                Text("Cerveza 2")
            } header: {
                Text("Categoria 2")
            }
            
        }
        
        
        
        
    }
}

#Preview {
    ManufacturerDetailsView(name: "test")
}
