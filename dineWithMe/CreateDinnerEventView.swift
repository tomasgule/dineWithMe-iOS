//
//  createDinnerEventView.swift
//  dineWithMe
//
//  Created by Tomas Gule on 21/03/2021.
//

import SwiftUI

struct CreateDinnerEventView: View {
    @EnvironmentObject var user: User
    @State var header: String = ""
    @State var description: String = ""
    @State var address: String = ""
    @State var price: String = ""
    @State var maxGuests: String = ""
    @State var date = Date()
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    func resetStates() {
        header = ""
        description = ""
        address = ""
        price = ""
        maxGuests = ""
    }
        
    var body: some View {
        Form{
            TextField("Tittel", text: $header)
            TextField("Beskrivelse", text: $description)
            TextField("Adresse", text: $address)
            TextField("Pris", text: $price)
                .keyboardType(.decimalPad)
            TextField("Maks antall gjester", text: $maxGuests)
                .keyboardType(.numberPad)
            DatePicker(
                "Tidspunkt",
                 selection: $date,
                 in: dateRange,
                displayedComponents: [.date, .hourAndMinute]
            ).datePickerStyle(WheelDatePickerStyle())
        }
        .navigationBarItems(
            leading: Button("X"){
                resetStates()
            }.buttonStyle(PlainButtonStyle()),
            trailing: Button("Legg til"){
                user.postDinner(header: header, description: description, address: address, price: price, maxGuest: maxGuests, date: date)
                resetStates()
            }
        )
    }
}

