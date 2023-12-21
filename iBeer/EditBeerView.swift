//
//  EditBeerView.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 20/12/23.
//

import SwiftUI
import PhotosUI

struct EditBeerView: View {
    @ObservedObject var mvm: ManufacturersViewModel
    var index: Int
    var beerIndex: Int
    var beer: Beer
    
    @State var name: String
    @State var type: String
    @State var icon: Image
    @State var alcoholContent: Float
    @State var calorieContent: Int
    @State private var imageSelection: PhotosPickerItem?
    
    @Environment(\.dismiss) private var dismiss
    
    init(mvm: ManufacturersViewModel, index: Int, beerIndex: Int) {
        self.mvm = mvm
        self.index = index
        self.beerIndex = beerIndex
        self.beer = mvm.manufacturers[index].beers[beerIndex]
        self._name = State(initialValue: beer.name)
        self._type = State(initialValue: beer.type)
        self._icon = State(initialValue: beer.icon)
        self._alcoholContent = State(initialValue: beer.alcoholContent)
        self._calorieContent = State(initialValue: beer.calorieContent)
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    PhotosPicker(selection: $imageSelection, matching: .images, label: {
                        if(icon == Image("beericon")) {
                            VStack() {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: 200, minHeight: 200)
                                    .background(
                                        Circle()
                                            .fill(.blue)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            VStack() {
                                icon
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: 200, minHeight: 200)
                                    .clipShape(.circle)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    })
                    .onChange(of: imageSelection) { newItem in
                        Task {
                            if let loaded = try? await newItem?.loadTransferable(type: Image.self) {
                                icon = loaded
                            } else {
                                print("Failed")
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name:")
                            TextField(text: $name, label: {
                                Text("Name...")
                            })
                        }
                        .font(.title)
                        .bold()
                        
                        HStack {
                            Text("Type:")
                            
                            TextField(text: $type, label: {
                                Text("Type...")
                            })
                        }
                        .font(.title)
                        .bold()
                        
                        HStack {
                            HStack {
                                TextField("", value: $alcoholContent, format: .number)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(width: 60, height: nil)
                                Text("% ALC./VOL.")
                                    .font(.caption)
                            }
                            Divider()
                            
                            HStack {
                                TextField("", value: $calorieContent, format: .number)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("CAL.")
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Section {
                    Button {
                        beer.name = name
                        beer.type = type
                        beer.icon = icon
                        beer.alcoholContent = alcoholContent
                        beer.calorieContent = calorieContent
                        
                        mvm.editBeer(beer: beer, index: index, beerIndex: beerIndex)
                        dismiss()
                        
                    } label: {
                        Text("Save changes")
                    }
                    .disabled(name.isEmpty)
                    .disabled(type.isEmpty)
                    .disabled(alcoholContent == 0)
                    .disabled(calorieContent == 0)
                    
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
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
            .navigationTitle("Editing \(beer.name)")
            .navigationBarTitleDisplayMode(.inline)
        } 
    }
}

struct EditBeerView_Previews: PreviewProvider {
    static var previews: some View {
        EditBeerView(mvm: ManufacturersViewModel(), index: 0, beerIndex: 0)
    }
}
