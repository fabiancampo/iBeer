//
//  ContentView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturersListView: View {
    @State var isShowingAddView = false
    @EnvironmentObject var manufactuers: Manufacturers
    
    @State var manufacturers: [Manufacturer] = [Manufacturer(name: "Mahou")]
    
    @State var filterSelection = 1
    @State var search = ""
    @State var scope: ManufacturerScope = .domestic
    @State var heartFilled = false
    
    var body: some View {
        
        NavigationStack {
            
            
            
            List($manufacturers, id: \.self, editActions: .delete) { $manufacturer in
                
             
                
                NavigationLink {
                    ManufacturerDetailsView(name: manufacturer.name)
                } label: {
                    
                   
                        Image("mahou")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .clipShape(.capsule)
                    Spacer(minLength: 10)
                    HStack {
                        Text(manufacturer.name)
                        Spacer()
                        Image(systemName: heartFilled ? "heart" : "heart.fill")
                            .bold()
                            .onTapGesture {
                                heartFilled.toggle()
                            }
                       
                        
                    }
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
                
                AddManufacturerView(manufacturers: $manufacturers, isShowingAddView:  $isShowingAddView)
            }
            
        }
        .searchable(text: $search, prompt: "Search and filter")
        .searchScopes($scope, activation: .onSearchPresentation) {
            Text("Domestic").tag(ManufacturerScope.domestic)
            Text("Imported").tag(ManufacturerScope.imported)
        }
       
        
        
    }
}


#Preview {
    ManufacturersListView()
}


