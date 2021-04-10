//
//  loginView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 20/03/2021.
//

import SwiftUI

struct loginView: View {
    @EnvironmentObject var user: User
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingLoginAlert: Bool = false
    

    
    var body: some View {
        VStack{
            Spacer()
            Text("DineWithMe").font(.largeTitle)
            VStack(alignment: .leading){
                TextField("Brukernavn", text: $username)
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20.0)
                SecureField("Passrod", text: $password)
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(20.0)
            }.padding()
            
            Button(action: {user.login(username: username, password: password){ loginSucceed in
                if !loginSucceed {
                    password = ""
                    showingLoginAlert = true
                } else {
                    showingLoginAlert = false
                }
            }
            }) {
              Text("Logg inn")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.green)
                .cornerRadius(15.0)
            }
            Spacer()
        }.background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
              .edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showingLoginAlert) {
            Alert(title: Text("Innlogging feilet"), message: Text("Galt brukernavn eller passord"), dismissButton: .default(Text("Prøv på nytt")))
        }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            loginView()
        }
    }
}
