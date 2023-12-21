//
//  ManufacturersViewModel.swift
//  iBeer
//
//  Created by Fabián Gómez Campo on 20/12/23.
//

import SwiftUI

final class ManufacturersViewModel: ObservableObject {
    @Published var manufacturers: [Manufacturer] = []
    
    init() {
        manufacturers = getAllManufacturers()
        print(URL.documentsDirectory)
        
    }
    
    /// Obtiene el fichero json con los datos y lo carga en la aplicación
    /// Sí el fichero existe en el directorio documents, abre ese archivo
    /// Si no existe, carga el archivo del bundle
    func getAllManufacturers() -> [Manufacturer] {
        
        let fileManager = FileManager.default
        let jsonFileURL = getDocumentsDirectory().appendingPathComponent("manufacturers.json")
        
        if fileManager.fileExists(atPath: jsonFileURL.path) {
            do {
                
                let data = try Data(contentsOf: jsonFileURL)
                let decoder = JSONDecoder()
                
                let manufacturers = try decoder.decode([Manufacturer].self, from: data)
                return manufacturers
                
                
            } catch {
                print("Error getAll - docuements")
            }
        } else {
        
            if let url = Bundle.main.url(forResource: "manufacturers", withExtension: "json") {
                do {
                    
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    
                    let manufacturers = try decoder.decode([Manufacturer].self, from: data)
                    return manufacturers
                    
                    
                } catch {
                    print("Error getAll - bundle")
                }
            }
        }
        
        return []
        
    }
    
    /// Devuelve URL del directorio documentos
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Guarda los datos en un json y lo guarda en el directorio documents
    /// Esta función depende del phase de la aplicación
    func saveAll() {
        do {
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(manufacturers)
            
            let jsonFileURL = getDocumentsDirectory().appendingPathComponent("manufacturers.json")
            try data.write(to: jsonFileURL)
            
        } catch {
            print("Error saveAll - documents")
        }
    }
    
    /// Añade la empresa de cerveza al array
    func addManufacturer(manufacturer: Manufacturer) {
        manufacturers.append(manufacturer)
    }
    
    /// Esta función se ejecuta cuando borramos un archivo de una lista deslizando.
    /// Recibe el offset de la posición y lo elimina del array
    func deleteManufacturer(at offsets: IndexSet) {
        manufacturers.remove(atOffsets: offsets)
    }
    
    /// Recibe un objeto manufacturer que se ha cambiado, seguidamente se obtiene el indice de la primera coincidencia
    /// del antiguo objeto y lo sobreescribe
    func editManufacturer(manufacturer: Manufacturer) {
        if let selectedIndex = manufacturers.firstIndex(where: { $0.id == manufacturer.id }) {
            manufacturers[selectedIndex] = manufacturer
        }
        
    }
    
    /// obtiene el índice en el array de manufacturers
    func getIndex(manufacturer: Manufacturer) -> Int {
        if let selectedIndex = manufacturers.firstIndex(where: { $0.id == manufacturer.id }) {
            return selectedIndex
        }
        
        return 0
    }
    
    /// obtiene el indice de la cerveza en el array Beers. Para ello, necesita el indíce de manufacturers
    func getIndex(beer: Beer, index: Int) -> Int {
        if let selectedIndex = manufacturers[index].beers.firstIndex(where: { $0.id == beer.id }) {
            return selectedIndex
        }
        
        return 0
    }
    
    /// Añade una cerveza
    func addBeer(manufacturer: Manufacturer, beer: Beer) {
        if let selectedIndex = manufacturers.firstIndex(where: { $0.id == manufacturer.id }) {
            manufacturers[selectedIndex].beers.append(beer)
        }
        
    }
    
    ///Sobreescribe los datos antiguos de una cerveza
    func editBeer(beer: Beer, index: Int, beerIndex: Int) {
            manufacturers[index].beers[beerIndex] = beer
        
    }
    
    /// Borra una cerveza en la posición del offset
    func deleteBeer(at offsets: IndexSet, manufacturer: Manufacturer) {
        manufacturers[getIndex(manufacturer: manufacturer)].beers.remove(atOffsets: offsets)
    }
    
    /// Dada las cervezas de un manufacturer, calcula cuantos tipos distintos ahí
    /// y se los devuelve a la vista para dividir las cervezas de una list en sections
    func calculateBeerTypes(index: Int) -> [String] {
        var beerTypes: [String] = []
        for beer in manufacturers[index].beers {
            beerTypes.append(beer.type)
        }
        
        return Array(Set(beerTypes)).sorted() // elimina valores repetidos
    }
}
