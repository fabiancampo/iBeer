//
//  EditManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 20/12/23.
//

import SwiftUI
import PhotosUI

struct EditManufacturerView: View {
    @ObservedObject var manufacturer: Manufacturer
    @ObservedObject var mvm: ManufacturersViewModel
    
    @State private var name: String
    @State private var logoImage: Image?
    @State private var imageSelection: PhotosPickerItem?
    var types = ["Domestic", "Imported"]
    @State private var selectedType = "Domestic"
    
    @Environment(\.dismiss) private var dismiss
    
    // init necesario para cargar los valores
    init(manufacturer: Manufacturer, mvm: ManufacturersViewModel) {
        self.manufacturer = manufacturer
        self.mvm = mvm
        self._name = State(initialValue: manufacturer.name)
        self._logoImage = State(initialValue: manufacturer.logo)
        self._selectedType = State(initialValue: manufacturer.type)
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack(spacing: 5) {
                    HStack {
                        PhotosPicker(selection: $imageSelection, matching: .images, label: {
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
                        manufacturer.logo = logoImage
                        manufacturer.name = name
                        manufacturer.type = selectedType
                        
                        // pasamos los cambios al viewmodel para que actualice el elemento
                        // en el array principal
                        mvm.editManufacturer(manufacturer: manufacturer)
                        dismiss()
                        
                    } label: {
                        Text("Save changes")
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
            .navigationTitle("Editing \(manufacturer.name)")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct EditManufacturerView_Previews: PreviewProvider {
    static var previews: some View {
        var manufacturer = Manufacturer(name: "Mahou", logo: Image("mahou"), type: "Domestic", beers: [])
        EditManufacturerView(manufacturer: manufacturer, mvm: ManufacturersViewModel())
    }
}
