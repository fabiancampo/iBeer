//
//  BreweryDetailsView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturerDetailsView: View {
    
    @ObservedObject var manufacturer: Manufacturer
    @ObservedObject var mvm: ManufacturersViewModel
    var index: Int
    
    
    @State var searchText = ""
    @State var isShowingEditView: Bool = false
    @State var isShowingAddBeerView: Bool = false
    
    var orders = ["Name A-Z", "Alcohol content", "Calorie content"]
    @State private var selectedOrder = "Name A-Z"
    
    // al
    var searchResults: [Beer] {
        if searchText.isEmpty {
            return mvm.manufacturers[index].beers
        } else {
            return mvm.manufacturers[index].beers.filter { $0.name.contains(searchText) }
        }
    }
    
    init(manufacturer: Manufacturer, mvm: ManufacturersViewModel) {
        self.manufacturer = manufacturer
        self.mvm = mvm
        self.index = mvm.getIndex(manufacturer: manufacturer)
    }
    var body: some View {
        
        // calcula los tipos de cerveza para dividirlas en secciones
        let beerTypes: [String] = mvm.calculateBeerTypes(index: index)
        
        // ordenar alfabeticamente, por contenido de alcohol o calorias
        // la ordenación se realiza dentro de cada seccion
        var sortedBeers: [Beer] {
            switch selectedOrder {
                case "Name A-Z":
                    mvm.manufacturers[index].beers.sorted { $0.name < $1.name }
                
                case "Alcohol content":
                    mvm.manufacturers[index].beers.sorted { $0.alcoholContent < $1.alcoholContent}
                    
                case "Calorie content":
                    mvm.manufacturers[index].beers.sorted { $0.calorieContent < $1.calorieContent }
                    
                default:
                    mvm.manufacturers[index].beers.sorted { $0.name < $1.name }
            }
        }
        
        NavigationStack {
            VStack {
                if (searchText.isEmpty) {
                    List {
                        Section {
                            VStack() {
                                mvm.manufacturers[index].logo!
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 200, minHeight: 200)
                                    .clipShape(.circle)
                            }
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                            
                        }
                        
                        Section {
                            Text("Type: \(mvm.manufacturers[index].type)")
                                .fontWeight(.bold)
                            
                            Button {
                                isShowingAddBeerView.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Add beer")
                                }
                            }
                            .foregroundStyle(.green)
                        }
                        
                        // muestra boton de filtrar si hay alguna cerveza
                        if mvm.manufacturers[index].beers.count > 0 {
                            Section {
                                Picker("Order by: ", selection: $selectedOrder) {
                                    ForEach(orders, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                        }
                        
                        // crea las secciones
                        ForEach(beerTypes, id: \.self) { beerType in
                            Section(header: Text(beerType)) {
                                
                                // muestra las cervezas cuya seccion es la misma
                                ForEach(sortedBeers) { beer in
                                    if(beer.type == beerType) {
                                        NavigationLink {
                                            BeerDetailsView(beer: beer, mvm: mvm, index: index)
                                        } label: {
                                            Image("beericon")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Spacer(minLength: 10)
                                            Text(beer.name)
                                        }
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    mvm.deleteBeer(at: indexSet, manufacturer: manufacturer)
                                })
                            }
                            .textCase(nil)
                        }
                    }
                } else {
                    // muestra resultados de la busqueda en una vista simplificada
                    List {
                        ForEach(searchResults, id: \.self.id) { beer in
                            NavigationLink {
                                BeerDetailsView(beer: beer, mvm: mvm, index: index)
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
            .toolbar {
                Button {
                    isShowingEditView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                        Text("Edit")
                    }
                }
            }
            .sheet(isPresented: $isShowingEditView) {
                EditManufacturerView(manufacturer: manufacturer, mvm: mvm)
            }
            .sheet(isPresented: $isShowingAddBeerView) {
                AddBeerView(manufacturer: manufacturer, mvm: mvm)
            }
            .navigationTitle(mvm.manufacturers[index].name)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            
        }
    }
}

struct ManufacturerDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturerDetailsView(manufacturer: Manufacturer(name: "Mahou", logo: Image("moritz"), type: "Domestic", beers: [Beer(name: "A", type: "Lager", icon: Image("beericon"), alcoholContent: 33, calorieContent: 33), Beer(name: "B", type: "Lager", icon: Image("mahou"), alcoholContent: 43, calorieContent: 23), Beer(name: "C", type: "Otra", icon: Image("beericon"), alcoholContent: 33, calorieContent: 33)]), mvm: ManufacturersViewModel())
        
    }
}

