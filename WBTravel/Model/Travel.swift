//
//  Travel.swift
//  WBTravel
//
//  Created by Shalopay on 13.05.2023.
//

import Foundation

struct Travel: Codable {
    var flights: [Flight]
}

// MARK: - Flight
struct Flight: Codable {
    var startDate: String
    var endDate: String
    var startLocationCode: String
    var endLocationCode: String
    var startCity: String
    var endCity: String
    var serviceClass: String
    var seats: [Seat]
    var price: Int
    var searchToken: String
}

// MARK: - Seat
struct Seat: Codable {
    var count: Int
    var passengerType: String
}

//enum PassengerType {
//    case ADT
//    case CHD
//    case INF
//}

//enum ServiceClass {
//    case ECONOMY
//}

//enum StartCity {
//    case санктПетербург
//}

//enum StartLocationCode {
//    case LED
//}
