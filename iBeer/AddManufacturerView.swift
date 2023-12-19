//
//  AddManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import SwiftUI
import PhotosUI

struct AddManufacturerView: View {
    @ObservedObject var manufacturers: Manufacturers
    
    @State private var name: String = ""
    @State private var logoImage: Image?
    @State private var imageSelection: PhotosPickerItem?
    @Environment(\.dismiss) private var dismiss
    
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
                    
                }
                
                Button {
                    
                    manufacturers.manufacturers.append(Manufacturer(name: name, logo: logoImage!, type: .domestic, beers: []))
                    dismiss()
                } label: {
                    Text("Add")
                    
                    
                }
               
                .disabled(name.isEmpty)
                .disabled(logoImage == nil)
                
           
            
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



struct AddManufacturerView_Previews: PreviewProvider {
    static var previews: some View {
        var manufacturers: Manufacturers = Manufacturers()
        AddManufacturerView(manufacturers: manufacturers)
    }
}



