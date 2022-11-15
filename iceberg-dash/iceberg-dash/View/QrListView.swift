//
//  QrListView.swift
//  iceberg-dash
//
//  Created by yury mid on 08.11.2022.
//

import SwiftUI
import CodeScanner
import Drops

struct Window: Shape {
    let size: CGSize
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)

        let origin = CGPoint(x: rect.midX - size.width / 2, y: rect.midY - size.height / 2)
        path.addRect(CGRect(origin: origin, size: size))
        return path
    }
}

struct QrListView: View {
    
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
/*
    QrItem(title: "HW", content: "hello world"),
    QrItem(title: "Greeting", content: "kak dela Vlad?"),
    QrItem(title: "True story", content: "Swift is cool")
 */

//    var qrList:QrItemList = QrItemList(qrItems:[])
    
    let qrListRemote:[QrItem] = [
        QrItem(title: "Kaspi Pay", content: "19291187238212729833613382201937422080324"),
        QrItem(title: "Qr from CRM", content: "qwerty"),
        QrItem(title: "TV", content: "xaxaxaxa"),
        QrItem(title: "Kaspi Buy", content: "19291187238212729833613382201937422080324")
    ]
    
    @State var customQRString: String = ""
    @State var customQRTitleString: String = ""
    
    @State private var isShowingScanner: Bool = false
    
    @State private var isShowingQrEditing: Bool = false
    @State var isQrEditable: Bool = false
    @State var selectedQrItem: QrItem = QrItem(title: "", content: "")
    

    
    var body: some View {
        ScrollView{
            createLocalQRBlock
            localQrCodesBlock
            remoteQrCodesBlock
        }
        .background(Color.bg)
        .navigationTitle("QR Settings")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], manualSelect: true, showViewfinder: true, shouldVibrateOnSuccess: true, completion: handleScan)
                .overlay(alignment: .top) {
                    Text("Point camera at QR")
                        .font(.headline)
                        .shadow(color: Color.black.opacity(0.3), radius: 3)
                        .padding()
                }
                .overlay(alignment: .topTrailing) {
                    Button {
                        isShowingScanner = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding()
                            .background(.ultraThinMaterial.opacity(0.5))
                            .cornerRadius(10)
                            .padding(5)
                    }

                }
        }
        .sheet(isPresented: $isShowingQrEditing){
            QRView(someQrItem: $selectedQrItem, isEditable: $isQrEditable)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onEnded({ value in
                        if ((value.translation.height > 0) || (value.translation.height < 0)){
                            UIApplication.shared.endEditing()
                        }
                }))
                .onDisappear{
                    selectedQrItem = QrItem(title: "", content: "")
                    isQrEditable = false
                }
        }
        .refreshable {
            
        }
        .onAppear{
            
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
        print(result)
        switch result {
        case .success(let result):
                Drops.show(qrReadingSuccessDrop)
                customQRString = result.string
        case .failure(let error):
                Drops.show(qrCreatingSuccessDrop)
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct QrListView_Previews: PreviewProvider {
    static var previews: some View {
        QrListView()
    }
}

extension QrListView {
    
    private var createLocalQRBlock: some View {
        VStack{
            HStack{
                Text("Add Local QR")
                    .font(.headline)
                Spacer()
            }
            
            TextField("Enter QR title", text: $customQRTitleString)
                .padding(.horizontal, 20)
                .padding(.vertical,10)
                .background(Color.bg)
                .cornerRadius(10)
            
            TextField("Enter QR content or link", text: $customQRString)
                .padding(.horizontal, 20)
                .padding(.vertical,10)
                .background(Color.bg)
                .cornerRadius(10)
            Text("Or just")
                .font(.subheadline)
            Button {
                isShowingScanner = true
            } label: {
                Label("Scan QR", systemImage: "qrcode.viewfinder")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial.opacity(0.5))
                    .cornerRadius(10)
            }
            
            Button {
                if ((customQRString == "") || (customQRTitleString == "")){
                    Drops.show(qrStringIsEmptyDrop)
                } else{
                    var list = defaultsManager.LocalQrList.qrItems
                    list.append(QrItem(title: customQRTitleString, content: customQRString))
                    defaultsManager.saveQrList(value: QrItemList(qrItems: list))
                    Drops.show(qrCreatingSuccessDrop)
                }
            } label: {
                Text("Add QR")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding(.vertical, 5)
            }


        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding()
    }
    
    private func qrItemBlock (item: QrItem) -> some View {
        VStack(alignment: .center, spacing: 10){
            Text(item.title)
                .font(.headline)
                .foregroundColor(.accentColor)
            Text(item.content)
                .font(.caption)
                .foregroundColor(.text.opacity(0.5))
            Image(uiImage: generateQRCode(from: item.content))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(5)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
        }
        .frame(maxWidth: 150)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding(5)
        .foregroundColor(.text)
        
    }
    
    private var localQrCodesBlock: some View {
        VStack{
            if (!defaultsManager.LocalQrList.qrItems.isEmpty){
                HStack{
                    Text("Local QR codes")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal, 20)
                ScrollView(.horizontal){
                    HStack{
                        ForEach(defaultsManager.LocalQrList.qrItems, id: \.self) { item in
                            Button {
                                selectedQrItem = item
                                isQrEditable = true
                                isShowingQrEditing = true
                            } label: {
                                qrItemBlock(item: item)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private var remoteQrCodesBlock: some View {
        VStack{
            HStack{
                Text("External QR codes")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 20)
            ScrollView(.horizontal){
                HStack{
                    ForEach(qrListRemote, id: \.self) { item in
                        Button {
                            selectedQrItem = item
                            isQrEditable = false
                            isShowingQrEditing = true
                        } label: {
                            qrItemBlock(item: item)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
