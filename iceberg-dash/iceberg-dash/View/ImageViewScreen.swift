//
//  ImageViewScreen.swift
//  iceberg-dash
//
//  Created by yury mid on 10.11.2022.
//

import Foundation
import SwiftUI

struct ImageViewScreen: View {
    
    @Binding var img: UIImage
    @Binding var imgName: String
    @Binding var show: Bool
    @State var isSendable: Bool
    
    var body: some View {
        if  show {
            ZStack{
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            show = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                                .padding(15)
                                .background(Color.bgSec)
                                .cornerRadius(15)
                        }
                        
                    }
                    .padding()
                    .padding(.top,35)
                    .background(.black.opacity(0.4))
                    
                    Spacer()
                    
                    VStack{
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 400, maxHeight: 500)
                    }
                    .onTapGesture {}
                    
                    Spacer()
                    
                        HStack{
                            Text(imgName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            if (isSendable){
                                Button {
                                    show = false
                                } label: {
                                    HStack{
                                        Text("Send image")
                                        Image(systemName: "paperplane")
                                            .font(.headline)
                                    }
                                    .padding(15)
                                    .background(Color.bgSec)
                                    .cornerRadius(15)
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom,25)
                        .background(.black.opacity(0.4))
                    
                }
                .onTapGesture {
                    show = false
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.5))
        }
    }
    
}
