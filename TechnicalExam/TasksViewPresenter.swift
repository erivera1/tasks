//
//  TaskPresenter.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TasksViewPresenter : TaskPresenter{
    let taskProvider = TaskLocalServiceProvider()
    
    func taskClicked() {
        
    }
    
    func savedTask(task: Task) {
        taskProvider.save(task: task)
    }
    
    func checkedTask(taskId: UUID) {
        taskProvider.updateStatus(taskId: taskId)
    }
    
    func uncheckedTask(taskId: UUID) {
        taskProvider.updateStatus(taskId: taskId)
    }
    
    func deletedTask(taskId: UUID) {
        taskProvider.deleteTask(taskId: taskId)
    }
    
    func findAll()->[Task]{
        taskProvider.findAll()
    }
    
    func updateTask(task:Task){
        taskProvider.update(task: task)
    }
}
