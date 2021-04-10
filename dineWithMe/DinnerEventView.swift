//
//  DinnerEventView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 20/03/2021.
//

import SwiftUI

struct DinnerEventView: View {
    @EnvironmentObject var user: User
    @State private var dinners: [Dinner] = []
    
    var body: some View {
        List{
            ForEach(dinners) { dinner in
                NavigationLink(destination: DinnerEventDetailView(dinner: dinner)){
                    DinnerEventListView(dinner: dinner).padding()
                }
            }
        }.onAppear(perform: {user.fetchDinnerList(){ dinners in
            self.dinners = dinners
        }})
    }
}
