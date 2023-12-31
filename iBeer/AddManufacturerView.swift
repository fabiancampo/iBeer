//
//  AddManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import SwiftUI
import PhotosUI

struct AddManufacturerView: View {
    @ObservedObject var manufacturersViewModel: ManufacturersViewModel
    
    @State private var name: String = ""
    @State private var logoImage: Image?
    @State private var imageSelection: PhotosPickerItem?
    var types = ["Domestic", "Imported"]
    @State private var selectedType = "Domestic"
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 5) {
                    HStack {
                        PhotosPicker(selection: $imageSelection, matching: .images, label: {
                            // si el usuario no ha seleccionado una imagen, muestra un botón
                            if (logoImage == nil) {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(
                                        Circle()
                                            .fill(.blue)
                                    )
                            }
                            logoImage?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                            
                                .clipShape(.circle)
                        })
                    }
                    Spacer()
                    TextField(text: $name, label: {
                        Text("Manufacturer's name...")
                    })
                    .font(.title3)
                    .fontWeight(.bold)
                }
                // al cargar la imagen transfierela a la variable
                .onChange(of: imageSelection) { newItem in
                    Task {
                        if let loaded = try? await newItem?.loadTransferable(type: Image.self) {
                            logoImage = loaded
                        } else {
                            print("Failed")
                        }
                    }
                }
                
                Picker("Select a type", selection: $selectedType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.automatic)
                
                Section {
                    Button {
                        // se crea todos el objeto y se pasa al viewmodel para que lo añada al array
                        var manufacturer = Manufacturer(name: name, logo: logoImage!, type: selectedType, beers: [])
                        
                        manufacturersViewModel.addManufacturer(manufacturer: manufacturer)
                        
                        dismiss()
                    } label: {
                        Text("Add Manufacturer")
                    }
                    .disabled(name.isEmpty)
                    .disabled(logoImage == nil)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                }
                .listRowBackground(Color.clear)
            }
            
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            .navigationTitle("Add Manufacturer")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}



struct AddManufacturerView_Previews: PreviewProvider {
    static var previews: some View {
        var manufacturersViewModel = ManufacturersViewModel()
        AddManufacturerView(manufacturersViewModel: manufacturersViewModel)
    }
}



