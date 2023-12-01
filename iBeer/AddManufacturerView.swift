//
//  AddManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import SwiftUI

struct AddManufacturerView: View {
    
    @Binding var manufacturers: [Manufacturer]
    @Binding var isShowingAddView: Bool
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $text, label: {
                    Text("Escribe...")
                })
                Button {
                    manufacturers.append(Manufacturer(name: text))
                    dismiss()
                } label: {
                    Text("Añadir")
                    
                    
                }
                .disabled(text.isEmpty)
            }
            .navigationTitle("Añadir")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}


