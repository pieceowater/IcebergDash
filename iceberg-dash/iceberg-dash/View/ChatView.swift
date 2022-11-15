//
//  ChatView.swift
//  iceberg-dash
//
//  Created by yury mid on 06.11.2022.
//

import SwiftUI

struct ChatView: View {

    var msgHistory = [
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 1, name: "Виталий Калугин"), message: "Привет, kotlin!", datetime: Date()),
        ChatMessage(incoming: false, author: ChatMessageAuthor(id: 2, name: "Юрий Литвиненко"), message: "Привет, swift!", datetime: Date()),
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 1, name: "Виталий Калугин"), message: "Обожаю писать под Андроид", datetime: Date()),
        ChatMessage(incoming: false, author: ChatMessageAuthor(id: 2, name: "Юрий Литвиненко"), message: "Здоровья погибшим", datetime: Date()),
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 1, name: "Виталий Калугин"), message: "F", datetime: Date()),
        ChatMessage(incoming: false, author: ChatMessageAuthor(id: 2, name: "Юрий Литвиненко"), message: "F", datetime: Date()),
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 3, name: "Марлен Монро"), message: "F", datetime: Date()),
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 3, name: "Марлен Монро"), message: "Всем привет, кстати", datetime: Date()),
        ChatMessage(incoming: true, author: ChatMessageAuthor(id: 3, name: "Марлен Монро"), message: "Выезжаю на заявку!", datetime: Date()),
        ChatMessage(incoming: false, author: ChatMessageAuthor(id: 2, name: "Юрий Литвиненко"), message: "Понял тебя", datetime: Date()),
    ]
    
    @State var messageToSend: String = ""
    
    @State var chosenImageContent: UIImage = UIImage()
 
    
    @State var showImagePicker: Bool = false
    @State var showCameraImagePicker: Bool = false
    
    @State var showImageViewScreen: Bool = false
    @State var chosenImageName: String = ""
    
    let date: Date
    let dateFormatter: DateFormatter
        
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm, dd MMM YY"
    }
    
    var body: some View {
        VStack{
            ScrollViewReader { proxy in
                ScrollView{
                    ForEach(msgHistory, id: \.self) { msg in
                        messageBlock(msg: msg)
                    }
                    .onAppear {
                        proxy.scrollTo("end")
                    }
                    Color.bgSec
                        .id("end")
                        .listRowBackground(Color.bgSec)
                        .listRowSeparatorTint(.clear)
                }
                .refreshable {
                    
                }
            
            toolbarBlock
            }
        }
        .background(Color.bgSec)
        .navigationTitle("Employee chat")
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .fullScreenCover(isPresented: $showCameraImagePicker, content: {
            ImagePicker(sourceType: .camera, selectedImage: self.$chosenImageContent, showImageViewScreen: $showImageViewScreen)
                .ignoresSafeArea()
        })
        .fullScreenCover(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$chosenImageContent, showImageViewScreen: $showImageViewScreen)
                .ignoresSafeArea()
        })
        .fullScreenCover(isPresented: $showImageViewScreen, content: {
            ImageViewScreen(img: $chosenImageContent, imgName: $chosenImageName, show: $showImageViewScreen, isSendable: true)
                .ignoresSafeArea()
        })
        .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
        .onEnded({ value in
            if ((value.translation.height > 0) || (value.translation.height < 0)){
                UIApplication.shared.endEditing()
            }
        }))
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

extension ChatView {
    private var toolbarBlock: some View {
        HStack(alignment: .center){
            CustomMenu(showCameraImagePicker: $showCameraImagePicker, showImagePicker: $showImagePicker)
            
            TextField("Message", text: $messageToSend)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.bgSec)
                .cornerRadius(10)
                .onTapGesture {
                    
                }
            if (messageToSend != ""){
                Button {
                    
                } label: {
                    
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.accentColor)
                        
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.bgSec)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                    }
                    
                
                }
            }
            

        }
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
    
    private func messageBlock(msg: ChatMessage) -> some View {
        
        HStack{
            if (msg.incoming){
                VStack{
                    Image(systemName: "person.2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(100)
                        .padding(.leading, 5)
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            } else {
                Spacer()
            }
            
            
            VStack(alignment: .trailing){
                VStack(alignment: .leading, spacing: 5){
                    Text(msg.author.name)
                        .font(.caption)
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                    
                    Text(msg.message)
                        .font(.subheadline)
                        .contextMenu{
                            Button {
                                copyTextToClipboard(string: msg.message)
                            } label: {
                                Text("Copy message text")
                            }
                        }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                
                Text(msg.datetime, formatter: dateFormatter)
                    .font(.caption)
                    .foregroundColor(.text).opacity(0.5)
            }
            
            if (!msg.incoming){
                VStack{
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(100)
                        .padding(.trailing, 5)
                        .foregroundColor(.accentColor)
                    Spacer()
                }
            } else {
                Spacer()
            }
            
        }
        .padding(5)
    }
}
