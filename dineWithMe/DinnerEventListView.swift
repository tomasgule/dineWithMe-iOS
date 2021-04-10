//
//  DinnerEventListView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 21/03/2021.
//

import SwiftUI

struct DinnerEventListView: View {
    @State var dinner: Dinner
    var body: some View {
        VStack(alignment: .leading){
            Text(dinner.header).font(.largeTitle)
            HStack(alignment: .center, spacing: 50){
                NavigationLink(destination: ProfileView(userProfile: dinner.host)){
                    Text("@\(dinner.host.username)").italic()
                }
                Text("Pris: \(dinner.price)").italic()
            }
            Text(dinner.description).padding(.vertical)
        }
    }
}
