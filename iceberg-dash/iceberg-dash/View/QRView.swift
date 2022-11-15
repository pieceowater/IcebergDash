//
//  QRView.swift
//  iceberg-dash
//
//  Created by yury mid on 08.11.2022.
//

import SwiftUI
import Drops


struct QRView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    
    @Binding var someQrItem: QrItem
    @Binding var isEditable: Bool

    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 10){
                if (isEditable){
                    VStack{
                        HStack(alignment: .center){
                            Text("Edit")
                            Text(someQrItem.title)
                                .font(.headline)
                                .foregroundColor(.accentColor)
                        }
                        TextField("Enter QR title", text: $someQrItem.title)
                            .padding(.horizontal, 20)
                            .padding(.vertical,10)
                            .background(Color.bg)
                            .cornerRadius(10)
                        TextField("Enter QR content or link", text: $someQrItem.content)
                            .padding(.horizontal, 20)
                            .padding(.vertical,10)
                            .background(Color.bg)
                            .cornerRadius(10)
                    }
                }else{
                    Text(someQrItem.title)
                        .font(.title)
                        .foregroundColor(.accentColor)
                    Text(someQrItem.content)
                        .font(.caption)
                        .foregroundColor(.text.opacity(0.5))
                        .frame(maxWidth: 200)
                        .lineLimit(1)
                }
                Image(uiImage: generateQRCode(from: someQrItem.content))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
                    .padding(15)
                    .background(.ultraThinMaterial)
                    .cornerRadius(30)
                if (isEditable){
                    Button {
                        if ((someQrItem.title == "") || (someQrItem.content == "")){
                            Drops.show(qrStringIsEmptyDrop)
                        } else{
                            saveQrTapped()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                    Button {
                        deleteQrTapped()
                    } label: {
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.headline)

                    }
                }else{
                    HStack (alignment: .center){
                        Image("IconStroke")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        Text("ICEBERG Dash")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                    }
                    .padding(.top, 10)
                }
                
                
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(5)
            .foregroundColor(.text)
        }
        .ignoresSafeArea()
        .background(Color.bg)
    }
    
    private func saveQrTapped(){
        presentationMode.wrappedValue.dismiss()
        deleteQrTapped()
        var list = defaultsManager.LocalQrList.qrItems
        list.append(QrItem(title: someQrItem.title, content: someQrItem.content))
        defaultsManager.saveQrList(value: QrItemList(qrItems: list))
    }
    
    private func deleteQrTapped(){
        presentationMode.wrappedValue.dismiss()
        let list = defaultsManager.LocalQrList.qrItems.filter{$0.id != someQrItem.id}
        defaultsManager.saveQrList(value: QrItemList(qrItems: list))
        defaultsManager.refreshQrList()
    }
}

struct QRView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            
        }
//        QRView(someQrItem: QrItem(title: "Test", content: "tasdasdasdest"))
    }
}
