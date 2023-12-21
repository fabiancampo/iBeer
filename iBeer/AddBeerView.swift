//
//  AddBeerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 20/12/23.
//

import SwiftUI

//
//  AddManufacturerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 28/11/23.
//

import SwiftUI
import PhotosUI

struct AddBeerView: View {
    @ObservedObject var manufacturer: Manufacturer
    @ObservedObject var mvm: ManufacturersViewModel
    
    @State private var name: String = ""
    @State private var beerImage: Image?
    @State private var imageSelection: PhotosPickerItem?
    @State private var type: String = ""
    @State private var alcoholContent: Float = 0.0
    @State private var calorieContent: Int = 0

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 5) {
                    HStack {
                        PhotosPicker(selection: $imageSelection, matching: .images, label: {
                            if (beerImage == nil) {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(
                                        Circle()
                                            .fill(.blue)
                                    )
                            }
                            beerImage?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                            
                                .clipShape(.circle)
                        })
                    }
                    Spacer()
                    
                    TextField(text: $name, label: {
                        Text("Beer's name...")
                    })
                    .font(.title3)
                    .fontWeight(.bold)
                }
                .onChange(of: imageSelection) { newItem in
                    Task {
                        if let loaded = try? await newItem?.loadTransferable(type: Image.self) {
                            beerImage = loaded
                        } else {
                            print("Failed")
                        }
                    }
                }
                
                HStack {
                    Text("Beer type:")
                    TextField(text: $type, label: {
                        Text("Beer's type...")
                    })
                }
                HStack {
                    Text("Alcohol content:")
                    TextField("Enter Float", value: $alcoholContent, format: .number)
                }
                HStack {
                    Text("Calorie content:")
                    TextField("Enter Float", value: $calorieContent, format: .number)
                    //formatter: NumberFormatter()
                }
                
                Section {
                    Button {
                        if(beerImage == nil) {
                            beerImage = Image("beericon")
                        }
                        
                        let beer = Beer(name: name, type: type, icon: beerImage!, alcoholContent: alcoholContent, calorieContent: calorieContent)
                        mvm.addBeer(manufacturer: manufacturer, beer: beer)
                        dismiss()
                    } label: {
                        Text("Add Beer")
                    }
                    .disabled(name.isEmpty)
                    .disabled(type.isEmpty)
                    .disabled(alcoholContent == 0.0)
                    .disabled(calorieContent == 0)
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
            .navigationTitle("Add Beer")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct AddBeerView_Previews: PreviewProvider {
    static var previews: some View {
        let manufacturer = Manufacturer(name: "Mahou", logo: Image("mahou"), type: "Domestic", beers: [])
        AddBeerView(manufacturer: manufacturer, mvm: ManufacturersViewModel())
    }
}



