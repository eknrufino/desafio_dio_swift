import UIKit

//Projeto POO
/*
 Explorar os seguintes conceitos:
 
 - Controle de Fluxo
 - Coleções
 - Funções e Closures
 - Enums e Struct
 - Concorrência
 
 */

enum DogBreed{
    case chihuahua
    case maltese
    case australianShepard
    case americanWaterSpaniel
    case akita
    case alaskanMalamute
    
    var name: String {
        switch self {
        case .chihuahua:
            return "Chihuahua"
        case .maltese:
            return "Maltes"
        case .australianShepard:
            return "Pastor Australiano"
        case .americanWaterSpaniel:
            return "Water Spaniel Americano"
        case .akita:
            return "Akita"
        case .alaskanMalamute:
            return "Malamute do Alaska"
        }
    }
    
    
}


struct Dog {
    
    var breeds: DogBreed
    var name: String
    var age: Int
    
    func dogSize() -> String {
        switch breeds {
        case DogBreed.chihuahua, DogBreed.maltese:
            return "Pequeno"
        case DogBreed.australianShepard, DogBreed.americanWaterSpaniel:
            return "Médio"
        case DogBreed.akita, DogBreed.alaskanMalamute:
            return "Grande"
        }
    }
}

class DogAdoptionCenter{
    var name: String
    var store: Int
    static var dogForAdoption: [Dog] = []
    var dogAge: String = ""
    
    init(name: String, store: Int) {
        self.name = name
        self.store = store
    }
    
    func newDogForAdoption(breeds: DogBreed, name: String, age: Int) {
        let newDog = Dog(breeds: breeds, name: name, age: age)
        let queue = DispatchQueue(label: "com.example.myqueue")
        queue.async { [self] in
            DogAdoptionCenter.dogForAdoption.append(newDog)
            if (newDog.age == 1) {
                dogAge = " ano"
            } else {
                dogAge = " anos"
            }
        }
        print("Um novo cachorro chegou para adoção, seu nome é \(newDog.name), da raça \(newDog.breeds.name) e tem \(newDog.age) \(dogAge) de idade")
    }
    
    func dogAdopted(breeds: DogBreed, name: String, age:Int){
        let adoptedDog = Dog(breeds: breeds, name: name, age: age)
        if let index = DogAdoptionCenter.dogForAdoption.firstIndex(where: {
            $0.name == adoptedDog.name &&
            $0.breeds == adoptedDog.breeds &&
            $0.age == adoptedDog.age}) {
            
            let dogAdopted = DogAdoptionCenter.dogForAdoption.remove(at: index)
            print("\(dogAdopted.name) ganhou uma nova família, parabéns")
        } else {
            print("Cachorro não encontrado nos bancos de dados, verifique se o nome a raça e a idade foram colocadas corretamente.")
        }
        
    }
    
}


let petPlace01 = DogAdoptionCenter(name: "Pet Place 01", store: 1)
petPlace01.newDogForAdoption(breeds: .akita, name: "Saori", age: 5)
petPlace01.newDogForAdoption(breeds: .alaskanMalamute, name: "Tikara", age: 5)
petPlace01.newDogForAdoption(breeds: .chihuahua, name: "Hulk", age: 10)
petPlace01.newDogForAdoption(breeds: .maltese, name: "Floki", age: 1)
petPlace01.dogAdopted(breeds: .akita, name: "Tikara", age: 5)
let petPlace02 = DogAdoptionCenter(name: "Pet Place 02", store: 2)
petPlace02.newDogForAdoption(breeds: .americanWaterSpaniel, name: "Thor", age: 2)
petPlace02.dogAdopted(breeds: .akita, name: "Saori", age: 5)
DogAdoptionCenter.dogForAdoption

