//
//  TasksContract.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

protocol TaskView {
    func displayTasks(tasks : [Task])
    func addTaskToList(task : Task)
    func removeTaskFromList(task : Task)
    func updateTaskInList(task : Task)
    func showAllTask()
    func checkMarkTapped(taskId:UUID)
}

protocol TaskPresenter {
    func taskClicked()
    func savedTask(task : Task)
    func checkedTask(taskId : UUID)
    func uncheckedTask(taskId : UUID)
    func deletedTask(taskId : UUID)
    func findAll()->[Task]
    func updateTask(task:Task)
}
