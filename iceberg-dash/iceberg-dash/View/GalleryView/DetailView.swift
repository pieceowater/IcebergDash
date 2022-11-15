//
//  DetailView.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "mushy1", withExtension: "jpg") {
            DetailView(item: Item(url: url))
        }
    }
}
