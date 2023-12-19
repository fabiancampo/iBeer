//
//  BeerDetailsView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct BeerDetailsView: View {
    
    var beer: Beer
    
    var body: some View {
        
        
        NavigationStack {
            List {
                
                Section {
                    VStack() {
                        Image("beericon")
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        
                        
                        
                        /*  manufacturer.logo!
                         .resizable()
                         .scaledToFill()
                         .frame(maxWidth: 200, minHeight: 200)
                         .clipShape(.circle) */
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("Tipo: \(String(describing: beer.type))")
                            .font(.title)
                            .bold()
                        HStack {
                            HStack {
                                Text("\(beer.alcoholContent, specifier: "%.2f")")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("% ALC./VOL.")
                                    .font(.caption)
                            }
                            Divider()
                            
                            HStack {
                                Text("\(beer.calorieContent)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("CAL.")
                                    .font(.caption)
                            }
                        }
                        
                        
                        
                    }
                }
                    
            }
            .navigationTitle(beer.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
        
        
    }
}

#Preview {
    BeerDetailsView(beer: Beer(name: "Cerveza", type: "Lager", alcoholContent: 0.7, calorieContent: 223))
}
