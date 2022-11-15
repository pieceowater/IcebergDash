//
//  ChatMessagesModel.swift
//  iceberg-dash
//
//  Created by yury mid on 11.11.2022.
//

import Foundation

struct ChatMessageAuthor{
    let id: Int
    let name: String
}

struct ChatMessage: Hashable {
    let incoming: Bool
    let id: UUID = UUID()
    let author: ChatMessageAuthor
    let message: String
    let datetime: Date
    
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
