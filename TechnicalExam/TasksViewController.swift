//
//  TasksViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    var tasks = [Task]()
    @IBOutlet weak var tableView: UITableView!
    var taskPresenter = TasksViewPresenter()
    let cellIdentifier = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         *   Finish this simple task recording app
         *   1. Make sure all defects are fixed
         *   2. Show a view (can be UIAlertController or any) that can add/edit the task.
         *   3. Show the added task in a UITableView/CollectionView
         *   4. Allow the user to toggle it as completed
         *   5. Allow the user to delete a task
         *
         **/
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.showAllTask()
    }
    
    @IBAction func addAction(_ sender: Any) {
        alertController(title: "Enter Description", buttonTitle: "Save", indexPath: nil)
    }
    
    func alertController(title:String, buttonTitle:String, indexPath:IndexPath?){
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            ac.addTextField()

        let submitAction = UIAlertAction(title: buttonTitle, style: .default) { [unowned ac] _ in
            let string = ac.textFields?[0].text ?? "No Description"
            if(buttonTitle == "Save"){
                self.add(text: string)
            }else{
                if let index = indexPath{
                    self.update(text: string, indexPath: index)
                }
                
            }
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    func add(text:String){
        let task = Task()
        task.description = text
        task.status = false
        self.addTaskToList(task: task)
        self.tasks.append(task)
        self.tableView.reloadData()
    }
    
    func update(text:String, indexPath:IndexPath){
        let task = self.tasks[indexPath.row]
        task.description = text
        updateTaskInList(task: task)
        self.tableView.reloadData()
    }
    
}


//MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            self.alertController(title: "Enter Description", buttonTitle: "Update", indexPath: indexPath)
        }
        editAction.backgroundColor = .blue

        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            let task = self.tasks[indexPath.row]
            self.removeTaskFromList(task: task)
            self.tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .red

        return [editAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        cell.setCell(task: task)
        cell.btnCheckMark.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)

        return cell
    }
    
    @objc func checkButtonTapped(sender: UIButton?, event: UIEvent) {
        let touches = event.allTouches
        let touch = touches!.first
        guard let touchPosition = touch?.location(in: self.tableView) else {
            return
        }
        if let indexPath = tableView.indexPathForRow(at: touchPosition) {
            let task = tasks[indexPath.row]
            let uncheckedImage = "CheckBoxUnChecked"
            let checkedImage = "CheckBoxChecked"
            let cell = tableView.cellForRow(at: indexPath) as! TaskCell
            if let isCompleted = task.status{
                if(isCompleted){
                    if let image = UIImage(named: uncheckedImage) {
                        cell.btnCheckMark.setImage(image, for: .normal)
                    }
                }else{
                    if let image = UIImage(named: checkedImage) {
                        cell.btnCheckMark.setImage(image, for: .normal)
                    }
                }
            }
            
            self.checkMarkTapped(taskId: task.id)
        }
    }
}

//MARK: - TaskView

extension TasksViewController:TaskView{
    func checkMarkTapped(taskId: UUID) {
        DispatchQueue.main.async {
            self.taskPresenter.checkedTask(taskId: taskId)
        }
    }
    
    func addTaskToList(task: Task) {
        taskPresenter.savedTask(task: task)
    }
    
    func removeTaskFromList(task: Task) {
        taskPresenter.deletedTask(taskId: task.id)
    }
    
    func updateTaskInList(task: Task) {
        taskPresenter.updateTask(task: task)
    }
    
    func displayTasks(tasks: [Task]) {
        self.tasks = tasks
        self.tableView.reloadData()
    }
    
    func showAllTask(){
        self.tasks = taskPresenter.findAll()
        if(self.tasks.count > 0){
            displayTasks(tasks: self.tasks)
        }
    }
}
