//
//  AttachmentsView.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct AttachmentsView: View {
    @EnvironmentObject private var dataModel: DataModel
    var body: some View {
        GridView()
            .environmentObject(dataModel)
            .toolbar {
                Menu {
                    Button {
                        
                    } label: {
                        Image(systemName: "camera")
                        Text("Take a photo")
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "photo")
                        Text("Choose from gallery")
                    }

                } label: {
                    HStack{
                        Image(systemName: "plus.circle")
                        Text("Photo")
                    }
                    .font(.subheadline)
                }

            }
    }
}

struct AttachmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AttachmentsView()
    }
}
