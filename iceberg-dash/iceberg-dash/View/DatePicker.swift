//
//  DatePicker.swift
//  iceberg-dash
//
//  Created by yury mid on 11.11.2022.
//

import SwiftUI

struct DatePickerScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var date: Date
    @State var headerText: String = "Date selector"
    @State var submitFunc: (() -> Void)
    
    var body: some View {
        VStack{
            Text(LocalizedStringKey(headerText))
                .foregroundColor(.accentColor)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 25)
            
            DatePicker("Select date & time", selection: $date, displayedComponents: [.date, .hourAndMinute])
            
            Spacer()
            
            Button {
                submitFunc()
                presentationMode.wrappedValue.dismiss()
                haptic(force: 1)
            } label: {
                Text("Save")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.bgSec)
        
    }
}

