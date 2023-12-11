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
  
    @State var manufacturers2: [Manufacturer2] = [Manufacturer2(name: "Mahou")]
    
    @State var filterSelection = 1
    @State var search = ""
    @State var scope: ManufacturerScope = .domestic
    @State var heartFilled = false
    
    var body: some View {
        
        NavigationStack {
            
            
            List(manufacturers.manufacturers) { manufacturer in
                
                NavigationLink {
                    ManufacturerDetailsView(manufacturer: manufacturer)
                } label: {
                    Image(manufacturer.logo)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(.capsule)
                    
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
                        manufacturer.isFavourited.toggle()
                    } label: {
                        Label("Add to favourites", systemImage: "heart.fill")
                    }
                    .tint(.indigo)
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
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search and filter")
       
        
        
        .searchScopes($scope, activation: .onSearchPresentation) {
            Text("Domestic").tag(ManufacturerScope.domestic)
            Text("Imported").tag(ManufacturerScope.imported)
        }
       
        
        
    }
}



struct ManufacturersListView_Previews: PreviewProvider {
    static var previews: some View {
        ManufacturersListView()
            .environmentObject(Manufacturers())
    }
}

