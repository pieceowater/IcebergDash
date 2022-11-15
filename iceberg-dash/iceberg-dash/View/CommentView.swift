//
//  CommentView.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct CommentView: View {
    
    @State private var textareaString = ""
    
    var body: some View {
        VStack{
            Text("Leave a comment")
                .foregroundColor(.accentColor)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.top)
            TextEditor(text: $textareaString)
                .padding()
                .scrollContentBackground(.hidden)
                .background(Color.bgSec)
                .foregroundColor(.text)
                .cornerRadius(15)
                .padding()
                .onTapGesture {}
                
            
                
            Button {
                
            } label: {
                Text("Save")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .padding()
            }

        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .background(Color.bg)
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
