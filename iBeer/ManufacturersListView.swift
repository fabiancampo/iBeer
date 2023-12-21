//
//  ContentView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturersListView: View {
    @ObservedObject var manufacturersViewModel: ManufacturersViewModel
    @State var isShowingAddView = false
    @State var searchText = ""
    
   
    var searchResults: [Manufacturer] {
        if searchText.isEmpty {
            return manufacturersViewModel.manufacturers
        } else {
            return manufacturersViewModel.manufacturers.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            /// manufacturers se dividen en domestic (nacionales) y imported (importados)
            List {
                
                // Primera sección domestic
                Section(header: Text("Domestic manufacturers")) {
                    ForEach(searchResults, id: \.self.id) { manufacturer in
                        if manufacturer.type == "Domestic" {
                            NavigationLink {
                                ManufacturerDetailsView(manufacturer: manufacturer, mvm: manufacturersViewModel)
                            } label: {
                                manufacturer.logo!
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(.circle)
                                Spacer(minLength: 10)
                                HStack {
                                    Text(manufacturer.name)
                                }
                            }
                        }
                    }
                    .onDelete(perform: manufacturersViewModel.deleteManufacturer)
                    // cuando eliminamos deslizando, se llama a esta función que recibe el offset
                }
                
                // Segunda sección imported
                Section(header: Text("Imported manufacturers")){
                    ForEach(searchResults, id: \.self.id) { manufacturer in
                        if (manufacturer.type == "Imported") {
                            NavigationLink {
                                ManufacturerDetailsView(manufacturer: manufacturer, mvm: manufacturersViewModel)
                            } label: {
                                manufacturer.logo!
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(.circle)
                                Spacer(minLength: 10)
                                HStack {
                                    Text(manufacturer.name)
                                }
                            }
                        }
                    }
                    .onDelete(perform: manufacturersViewModel.deleteManufacturer)
                }
            }
            .navigationTitle("Manufacturers")
            
            // barra de búsqueda siempre presente
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .toolbar {
                Button {
                    isShowingAddView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus.app.fill")
                        Text("Add")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddManufacturerView(manufacturersViewModel: manufacturersViewModel)
            }
        }
    }
}


struct ManufacturersListView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturersListView(manufacturersViewModel: ManufacturersViewModel())
        
    }
}

