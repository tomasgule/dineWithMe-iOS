//
//  ProfileView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 21/03/2021.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: User
    @State var userProfile: UserProfile
    @State private var dinners: [Dinner] = []
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Vertskap for").bold()
            Divider()
            ScrollView(.horizontal){
                HStack{
                    ForEach(dinners) { dinner in
                        if (dinner.host == userProfile){
                            DinnerScrollView(dinner: dinner)
                        }
                    }
                }
            }
            Divider()
            Text("Deltar på").bold()
            Divider()
            ScrollView(.horizontal){
                HStack{
                    ForEach(dinners) { dinner in
                        if (dinner.guests.contains(userProfile)){
                            DinnerScrollView(dinner: dinner)
                        }
                    }
                }
            }
            Divider()
            Spacer()
        }.onAppear(perform: {user.fetchDinnerList(){ dinners in
            self.dinners = dinners
        }})
        .padding()
        .navigationBarTitle("\(userProfile.first_name) \(userProfile.last_name)",displayMode: .large)
    }
}

struct DinnerScrollView: View {
    @State var dinner: Dinner
    
    var body: some View {
        NavigationLink(destination: DinnerEventDetailView(dinner: dinner)){
            VStack(){
                Text(dinner.header)
                Text(dinner.dateTimeString)
            }.padding()
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
}

