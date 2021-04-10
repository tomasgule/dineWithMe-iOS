//
//  loggedInView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 20/03/2021.
//

import SwiftUI

struct loggedInView: View {
    @EnvironmentObject var user: User
    var body: some View {
        TabView{
            NavigationView{
                DinnerEventView()
                    .navigationBarTitle("Middager", displayMode: .inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "house.fill")
                Text("Middager")
            
            }
            NavigationView {
                CreateDinnerEventView()
                    .navigationBarTitle("Legg til middag", displayMode: .inline)
            }.tabItem {
                Image(systemName: "plus.circle.fill")
                Text("Ny middag") }
            
            NavigationView {
                ProfileView(userProfile: user.user!)
                    .navigationBarTitle("Profil")
                    .navigationBarItems(
                        trailing: NavigationLink(destination: ProfileFormView(firstName: user.user!.first_name, lastName: user.user!.last_name, bio: user.user!.bio)){
                            Image(systemName: "gearshape")
                        }
                    )
            }.tabItem {
                Image(systemName: "person.fill")
                Text("Profil")
            }
        }
    }
}
