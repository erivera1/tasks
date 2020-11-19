//
//  TaskLocalServiceProvider.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TaskLocalServiceProvider : TaskLocalService {
    let defaults = UserDefaults.standard
    let taskKey = "Tasks"
    var allTasks = [Task]()
    init() {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
    }
    
    func save(task: Task) {
        allTasks.append(task)
        JSONEncode()
    }
    
    func findAll() -> [Task] {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
        return allTasks
    }
    
    func deleteTask(taskId:UUID){
        if let index = allTasks.index(where: {$0.id == taskId}) {
            allTasks.remove(at: index)
        }
        JSONEncode()
    }
    
    func update(task:Task){
        if let index = allTasks.index(where: {$0.id == task.id}) {
            let this = allTasks[index]
            this.status = task.status
        }
        JSONEncode()
    }
    
    func updateStatus(taskId:UUID){
        if let index = allTasks.index(where: {$0.id == taskId}) {
            let task = allTasks[index]
            task.status?.toggle()
        }
        JSONEncode()
    }
    
    func JSONEncode(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allTasks){
            defaults.set(encoded, forKey: taskKey)
        }
    }
    
}
