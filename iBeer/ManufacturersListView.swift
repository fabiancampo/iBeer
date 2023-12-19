//
//  ContentView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturersListView: View {
    @EnvironmentObject var manufacturers: Manufacturers
    
    
    
    
    @State var isShowingAddView = false
  
    @State var filterSelection = 1
    @State var searchText = ""
    @State var scope: ManufacturerScope = .domestic
    @State var heartFilled = false
    
    var searchResults: [Manufacturer] {
            if searchText.isEmpty {
                return manufacturers.manufacturers
            } else {
                return manufacturers.manufacturers.filter { $0.name.contains(searchText) }
            }
        }
    
    var body: some View {
        
        NavigationStack {
               
            List {
                ForEach(searchResults, id: \.self.id) { manufacturer in
                    NavigationLink {
                                ManufacturerDetailsView(manufacturer: manufacturer)
                            } label: {
                              manufacturer.logo!
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(.circle)
                                Spacer(minLength: 10)
                                HStack {
                                    Text(manufacturer.name)
                                    
                                    if (manufacturer.isFavourited == true) {
                                        Spacer()
                                        Image(systemName: "heart.fill")
                                            .bold()
                                    }
                                    
                                }
                            }
                    
                            
                            .swipeActions(edge: .leading) {
                                Button {
                                   
                                } label: {
                                    Label("Add to favourites", systemImage: "heart.fill")
                                }
                                .tint(.indigo)
                        }
                }
                .onDelete { indexSet in
                    manufacturers.manufacturers.remove(atOffsets: indexSet)
                }
                        
            }
                
                    
            
            .navigationTitle("Manufacturers")
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
                
                AddManufacturerView(manufacturers: manufacturers)
            }
            
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search and filter")
      
        .searchScopes($scope, activation: .onSearchPresentation) {
            Text("Domestic").tag(ManufacturerScope.domestic)
            Text("Imported").tag(ManufacturerScope.imported)
        }
        .onAppear {
            manufacturers.manufacturers.append(contentsOf: Manufacturer.fetchData())
        }
       
        
        
    }
        
}



struct ManufacturersListView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturersListView()
            .environmentObject(Manufacturers())
    }
}

