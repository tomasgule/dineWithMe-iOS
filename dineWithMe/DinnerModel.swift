//
//  DinnerModel.swift
//  dineWithMe
//
//  Created by Tomas Gule on 27/03/2021.
//

import Foundation

struct UserProfile: Codable, Identifiable, Equatable {
    let id: Int
    let username: String
    let first_name: String
    let last_name: String
    let bio: String
}

struct LoginResponse: Codable {
    var userProfile: UserProfile?
    var token: String?
}

struct Dinner: Codable, Identifiable{
    var id: Int
    var header: String
    var description: String
    var host: UserProfile
    var maxGuests: Int
    var price: String
    var guests:[UserProfile]
    var dateTime: Date
    var address: String
    var hasEmptySlots: Bool {
        guests.count < maxGuests
    }
    var dateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: dateTime)
    }
    
    mutating func add(guest: UserProfile){
        guests.append(guest)
    }
    
    
}
