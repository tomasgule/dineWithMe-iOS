//
//  api.swift
//  dineWithMe
//
//  Created by Tomas Gule on 20/03/2021.
//

import SwiftUI

class User: ObservableObject {
    @Published var user: UserProfile?
    @Published var token: String?
    @Published var isLoggedIn: Bool = false
    let baseUrl: String = "http://localhost:8000"
    
    
    
    func login(username: String, password: String, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "\(baseUrl)/api/auth/login") else { return }
        var loginSucceed = false
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "username": username,
            "password": password
        ]
        
        if let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse)
                    if let response = try? JSONDecoder().decode(LoginResponse.self, from: data!) {
                        if let userprofile = response.userProfile {
                            loginSucceed = true
                            DispatchQueue.main.async {
                                self.user = userprofile
                                self.token = response.token
                                self.isLoggedIn = true
                            }
                        }
                    }
                }
            }
            .resume()
            completion(loginSucceed)
        }
    }
    
    func fetchDinnerList(completion: @escaping ([Dinner]) -> ()) {
        guard let url = URL(string: "\(baseUrl)/api/dinnerEvent/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let dinners = try? decoder.decode([Dinner].self, from: data!){
                completion(dinners)
                print("Middager lastet")
            }
        }.resume()
    }
    
    func postDinner(header: String, description: String, address: String, price: String, maxGuest: String, date: Date){
        let formatter = ISO8601DateFormatter()
        let body = [
            "header": header,
            "description": description,
            "address": address,
            "price": price,
            "maxGuests": maxGuest,
            "dateTime": formatter.string(from: date)
        ]
        
        guard let url = URL(string: "\(baseUrl)/api/dinnerEvent/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.token!)", forHTTPHeaderField: "Authorization")
        
        if let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    print(String(data: data!, encoding: .utf8)!)
                }
                if let response = try? JSONDecoder().decode(Dinner.self, from: data!) {
                    print(response)
                }
            }
            .resume()
        }
    }
    
    func putDinner(header: String, description: String, address: String, price: String, maxGuest: String, date: Date, dinner_id id: Int){
        let formatter = ISO8601DateFormatter()
        let body = [
            "header": header,
            "description": description,
            "address": address,
            "price": price,
            "maxGuests": maxGuest,
            "dateTime": formatter.string(from: date)
        ]
        
        guard let url = URL(string: "\(baseUrl)/api/dinnerEvent/\(id)/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.token!)", forHTTPHeaderField: "Authorization")
        
        if let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    print(String(data: data!, encoding: .utf8)!)
                }
                if let response = try? JSONDecoder().decode(Dinner.self, from: data!) {
                    print(response)
                }
            }
            .resume()
        }
    }
    
    
    func attendDinner(dinner id: Int, isAttending: Bool){
        guard let url = URL(string: "\(baseUrl)/api/attend") else { return }
        var request = URLRequest(url: url)
        
        let body = [
            "dinner_id": id
        ]
        if (isAttending) {
        request.httpMethod = "POST"
        } else {
        request.httpMethod = "DELETE"
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.token!)", forHTTPHeaderField: "Authorization")
        
        if let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    print(String(data: jsonBody, encoding: .utf8)!)
                    print(String(data: data!, encoding: .utf8)!)
                }
                if let response = try? JSONDecoder().decode(Dinner.self, from: data!) {
                    print(response)
                }
            }
            .resume()
        }
    }
}


