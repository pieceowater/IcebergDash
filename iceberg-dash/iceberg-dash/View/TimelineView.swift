//
//  TimelineView.swift
//  iceberg-dash
//
//  Created by yury mid on 12.11.2022.
//

import SwiftUI

struct TimelineView: View {
    
    
    var timelineItems = [
        OrderTimelineItem(itemId: 1, itemAuthorId: 0, itemAuthorName: "", itemHeader: "Заказ создан", itemContent: "", itemDatetime: 1668233140, iconKey: 2),
        OrderTimelineItem(itemId: 2, itemAuthorId: 1, itemAuthorName: "Виталий Калугин", itemHeader: "Комментарий", itemContent: "Привет, мир!", itemDatetime: 1668233150, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
        OrderTimelineItem(itemId: 3, itemAuthorId: 2, itemAuthorName: "Марлен", itemHeader: "Комментарий", itemContent: "Саламалейкум", itemDatetime: 1668233160, iconKey: 1),
    ]
    
    @State private var showCommentView: Bool = false
    
    var body: some View {
        ScrollView{
            ScrollViewReader { proxy in
                VStack{
                    ForEach(timelineItems, id: \.self) { item in
                        timelineItemblock(item: item)
                    }
                    Color.bgSec.frame(height: 50)
                        .id("end")
                }
                .padding()
                .onAppear {
                    proxy.scrollTo("end")
                }
            }
        }
        .background(Color.bgSec)
        .navigationTitle("Timeline")
        .overlay(alignment: .bottom, content: {
            timelineToolbarBlock
        })
        .sheet(isPresented: $showCommentView, content: {
            CommentView()
                .presentationDetents([.fraction(0.50)])
        })
        .refreshable {
            
        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}

extension TimelineView {
    private var timelineToolbarBlock: some View {
        HStack{
            
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
                    Image(systemName: "paperclip")
                    Text("Image")
                }
                .frame(maxWidth: .infinity)
            }

            Divider()
            Button {
                showCommentView = true
            } label: {
                HStack{
                    Image(systemName: "plus")
                    Text("Comment")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .font(.subheadline)
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity, maxHeight: 50)
    }
    
    private func timelineItemblock(item: OrderTimelineItem) -> some View {
        VStack(spacing: 5){
            HStack{
                timelineIcons[item.iconKey]
                Text(item.itemHeader)
                Spacer()
            }
            .foregroundColor(.accentColor)
            .font(.headline)
            VStack(alignment: .leading, spacing: 5){
                Text(item.itemContent)
                    .font(.subheadline)
                    .padding(.leading, 30)
                HStack{
                    if (!item.itemAuthorName.isEmpty){
                        Image(systemName: "person")
                            .font(.caption2)
                        Text(item.itemAuthorName)
                    }
                    Spacer()
                    Text(String(
                        unixTimeConverter(ts: Double(item.itemDatetime))
                    ))
                }
                .foregroundColor(.text.opacity(0.5))
                .font(.caption)
                .padding(.top,10)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}
