//
//  ContentView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 24/11/23.
//

import SwiftUI

struct ManufacturersListView: View {
    @State var isShowingAddView = false
    @ObservedObject var model = Manufacturer()
    
    
    var body: some View {
        
        NavigationStack {
            
            List(model.manufacturer, id: \.self) { manu in
                Text(manu)
               
            }
            
            .navigationTitle("Lista de fabricantes")
            .toolbar {
                Button {
                    isShowingAddView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus.app.fill")
                        Text("Añadir")
                        
                    }
                    
                    
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                
                AddManufacturerView(manu: $model.manufacturer, isPresented: $isShowingAddView)
            }
            
        }
        
    }
}


#Preview {
    ManufacturersListView()
}


