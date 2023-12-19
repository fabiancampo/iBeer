//
//  BreweryDetailsView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturerDetailsView: View {
    @ObservedObject var manufacturer: Manufacturer
    
    
    // var name: String
    var body: some View {
        
        var beerTypes: [String] = Manufacturer.calculateBeerTypes(manufacturer: manufacturer)
        
        
        NavigationStack {
            List {
                
                Section {
                    VStack() {
                        manufacturer.logo!
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 200, minHeight: 200)
                            .clipShape(.circle)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    
                }
                ForEach(beerTypes, id: \.self) { beerType in
                    Section(header: Text(beerType)) {
                        ForEach(manufacturer.beers) { beer in
                            if(beer.type == beerType) {
                                NavigationLink {
                                    BeerDetailsView(beer: beer)
                                } label: {
                                    Image("beericon")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                
                                    Spacer(minLength: 10)
                                    Text(beer.name)
                                    
                                }
                            }
                        }
                    }
                    
                }
                            
               
            }
            .navigationTitle(manufacturer.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    
        
        
        
    }
}

struct ManufacturerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturerDetailsView(manufacturer: Manufacturer(name: "Mahou", logo: Image("moritz"), type: .domestic, beers: []))
            
    }
}
