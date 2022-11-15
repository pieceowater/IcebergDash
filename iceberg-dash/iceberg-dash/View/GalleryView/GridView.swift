//
//  GridView.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var dataModel: DataModel

    private static let initialColumns = 2

    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) \(LocalizedStringKey("Columns").stringValue())" : "1 \(LocalizedStringKey("Column").stringValue())"
    }
    
    var body: some View {
        VStack {
            ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns)
                .padding(.horizontal)
            ScrollView {
                LazyVGrid(columns: gridColumns) {
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            NavigationLink(destination: DetailView(item: item)) {
                                GridItemView(size: geo.size.width, item: item)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Attachments")
        .background(Color.bgSec)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView().environmentObject(DataModel())
            
    }
}
 
