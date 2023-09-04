import UIKit

//Desafio POP
/*
 Explorar os seguintes conceitos:
 
 - Controle de Fluxo
 - Coleções
 - Funções e Closures
 - Enums e Struct
 - Concorrência
 
 */

enum CarBrand {
    case toyota
    case volkswagem
    case honda
    case hyundai
    
    var name: String {
        switch self {
        case .toyota:
            return "Toyota"
        case .volkswagem:
            return "VW"
        case .honda:
            return "Honda"
        case .hyundai:
            return "Hyundai"
        }
    }
}

protocol Car {
    var name: String { get }
    var year: String { get }
    var brand: CarBrand { get }
    var maximumSpeed: Double { get }
    var tenSecondCar: Bool { get }
}


protocol TenSecondCar {
}

extension Car {
    var tenSecondCar: Bool { self is TenSecondCar }
}

class ToyotaPopularCar: Car {
    var name: String
    var year: String
    var brand = CarBrand.toyota
    var maximumSpeed: Double
    
    init(name: String, year: String, maximumSpeed: Double) {
        self.name = name
        self.year = year
        self.maximumSpeed = maximumSpeed
    }
}

class VolkswagemPopularCar: Car {
    var name: String
    var year: String
    var brand = CarBrand.volkswagem
    var maximumSpeed: Double
    
    init(name: String, year: String, maximumSpeed: Double) {
        self.name = name
        self.year = year
        self.maximumSpeed = maximumSpeed
    }

}

struct HondaPopularCar: Car {
    var name: String
    var year: String
    var brand = CarBrand.honda
    var maximumSpeed: Double
}

struct HyundaiPopularCar: Car {
    var name: String
    var year: String
    var brand = CarBrand.hyundai
    var maximumSpeed: Double
}

class ToyotaSportCar: ToyotaPopularCar, TenSecondCar {
    
}

class VolkswagemSportCar: VolkswagemPopularCar, TenSecondCar {
    
}

struct HondaSportCar: Car, TenSecondCar {
    var name: String
    var year: String
    var brand = CarBrand.honda
    var maximumSpeed: Double
}
struct HyundaiSporCar: Car, TenSecondCar {
    var name: String
    var year: String
    var brand = CarBrand.hyundai
    var maximumSpeed: Double
}

let toyotaPC = ToyotaPopularCar(name: "Yaris XLS", year: "2020", maximumSpeed: 170.0)
let toyotaSC = ToyotaSportCar(name: "GR Supra", year: "2020", maximumSpeed: 250.0)
let volkswagemPC = VolkswagemPopularCar(name: "Polo Track", year: "2020", maximumSpeed: 180.0)
let volkswagemSC = VolkswagemSportCar(name: "Golf GTI", year: "2020", maximumSpeed: 250.0)
let hondaPC = HondaPopularCar(name: "City XL", year: "2020", maximumSpeed: 180.0)
let hondaSC = HondaSportCar(name: "Civic SI", year: "2020", maximumSpeed: 208.0)
let hyundaiPC = HyundaiPopularCar(name: "HB20S Vision", year: "2020", maximumSpeed: 170.0)
let hyundaiSC = HyundaiSporCar(name: "Veloster N", year: "2020", maximumSpeed: 250.0)

let racersPopularCar:[Car] = [
    toyotaPC,
    volkswagemPC,
    hondaPC,
    hyundaiPC
]

Task {
    func topSpeed(of racersPopularCar: [Car]) async -> Double {
        racersPopularCar.max (by: { $0.maximumSpeed < $1.maximumSpeed })?.maximumSpeed ?? 0.0
    }
    print("Velocidade maxima dos pilotos \(await topSpeed(of: racersPopularCar))")
}
