//
//  DinnerEventDetailView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 21/03/2021.
//

import SwiftUI
import MapKit

struct DinnerEventDetailView: View {
    @State var dinner: Dinner
    @EnvironmentObject var user: User
    @State private var region = MKCoordinateRegion(
           center: CLLocationCoordinate2D(
            latitude: 63.41723633,
            longitude: 10.40404952
           ),
           span: MKCoordinateSpan(
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
           )
    )

    
    var body: some View {
        VStack(alignment: .leading){
            DinnerEventListView(dinner: dinner)
            HStack(){
                Text("Påmeldte \(dinner.guests.count)/\(dinner.maxGuests)").bold()
                Spacer()
                if (dinner.host == user.user) {
                    Button("Endre"){
                    }.foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
                }
                else if (dinner.guests.contains(user.user!)){
                    Button("Meld av"){
                        user.attendDinner(dinner: dinner.id, isAttending: false)
                        dinner.guests.remove(at: dinner.guests.firstIndex(matching: user.user!)!)
                    }.foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
                } else if (dinner.hasEmptySlots){
                    Button("Meld på"){
                        print("Meld på")
                        user.attendDinner(dinner: dinner.id, isAttending: true)
                        dinner.guests.append(user.user!)
                    }.foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            ForEach(dinner.guests){ guest in
                NavigationLink(destination: ProfileView(userProfile: guest)){
                    Text(guest.username)
                }
            }
            Map(coordinateRegion: $region,
                showsUserLocation: true)
            Spacer()
                
        }.padding()
    }
}

