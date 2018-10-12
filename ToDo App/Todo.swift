//
//  Todo.swift
//  ToDo App
//
//  Created by minami on 2018-10-09.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import Foundation

struct Todo {
    var title: String
    var todoDescription: String
    var priority: Int
    var isCompleted: Bool
    
    init(withTitle title: String, andDescription descript: String, andPriority level:Int) {
        self.title = title
        self.todoDescription = descript
        self.priority = level
        self.isCompleted = false
    }
    
    func printDescription() {
        print("Title: \(self.title), Priority: \(self.priority)")
    }
    
    enum Priority: String {
        case low = "low"
        case middle = "middle"
        case high = "high"
    }
}

