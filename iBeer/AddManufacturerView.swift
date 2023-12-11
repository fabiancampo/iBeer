//
//  AddManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import SwiftUI

struct AddManufacturerView: View {
    @ObservedObject var manufacturers: Manufacturers
    
    @State var name: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $name, label: {
                    Text("Nombre...")
                })
                Button {
               
                    manufacturers.manufacturers.append(Manufacturer(name: name, logo: "", type: .domestic, beers: []))
                    dismiss()
                } label: {
                    Text("Añadir")
                    
                    
                }
                .disabled(name.isEmpty)
            }
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                    
                    
                }
                
                
                
            }
            .navigationTitle("Añadir")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}


