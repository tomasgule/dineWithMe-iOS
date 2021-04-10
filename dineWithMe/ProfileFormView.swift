//
//  ProfileFormView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 23/03/2021.
//

import SwiftUI

struct ProfileFormView: View {
    @EnvironmentObject var user: User
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var bio: String = ""

    var body: some View {
        Form{
            Section(header: Text("Fornavn")){
                HStack{
                    TextField("Fornavn", text: $firstName)
                }
            }
            Section(header: Text("Etternavn")){
                HStack{
                    TextField("Etternavn", text: $lastName)
                }
            }
            Section(header: Text("Bio")){
                HStack{
                    TextField("Bio", text: $bio)
                }
            }
        }.navigationBarTitle(user.user!.username, displayMode: .large)
    }
}

