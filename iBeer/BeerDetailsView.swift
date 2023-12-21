//
//  BeerDetailsView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//


import SwiftUI

struct BeerDetailsView: View {
    
    @ObservedObject var beer: Beer
    @ObservedObject var mvm: ManufacturersViewModel
    var index: Int
    var beerIndex: Int
    
    @State var isShowingEditView = false
    
    init(beer: Beer, mvm: ManufacturersViewModel, index: Int) {
        self.mvm = mvm
        self.beer = beer
        self.index = index
        self.beerIndex = mvm.getIndex(beer: beer, index: index)
        
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                Section {
                    
                    if(beer.icon == Image("beericon")) {
                        VStack() {
                            beer.icon
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                    } else {
                        VStack() {
                            beer.icon
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 200, minHeight: 200)
                                .clipShape(.circle)
                        }
                        .frame(maxWidth: .infinity)
                        .listRowBackground(Color.clear)
                    }
                    
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
                
                Section {
                    Button {
                        isShowingEditView.toggle()
                    } label: {
                        Text("Edit beer")
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
                }
                .listRowBackground(Color.clear)
            }
            
            .navigationTitle(beer.name)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingEditView) {
                EditBeerView(mvm: mvm, index: index, beerIndex: beerIndex)
            }
        }
    }
}

struct BeerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailsView(beer: Beer(), mvm: ManufacturersViewModel(), index: 0)
    }
}

