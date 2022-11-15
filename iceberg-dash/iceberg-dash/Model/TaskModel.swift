//
//  TaskModel.swift
//  iceberg-dash
//
//  Created by yury mid on 08.11.2022.
//

import Foundation

struct TaskExecutor: Hashable {
    let id: Int
    let name: String
    
    static func == (lhs: TaskExecutor, rhs: TaskExecutor) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TaskManager: Hashable {
    let id: Int
    let name: String
    
    static func == (lhs: TaskManager, rhs: TaskManager) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Task: Hashable{
    let id: Int
    let title: String
    let caption: String
    let deadline: Int64
    let createDate: Int64
    let executorsList: [TaskExecutor]
    let managersList: [TaskManager]
    let order: CrmOrder?
    var seen: Bool
    var completed: Bool
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
} 
