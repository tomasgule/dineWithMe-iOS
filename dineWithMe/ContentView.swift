//
//  ContentView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 20/03/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var user: User = User()
    
    
    var body: some View {
        Group{
            if !user.isLoggedIn{
                loginView()
            } else {
                loggedInView()
            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
