//
//  MasterViewController.swift
//  ToDo App
//
//  Created by minami on 2018-10-09.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var todoList = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewTodo(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        for i in 0..<5 {
            var todo = Todo(withTitle: "TODO " + String(i), andDescription: "")
            if i % 2 == 0 {
                todo.todoDescription = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
            } else {
                todo.todoDescription = "Description"
            }
            todoList.append(todo)
        }
    }

    @objc
    func insertNewTodo(_ sender: Any) {
        let alert = UIAlertController(title: "TODO", message: "Create a new todo?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Input a title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Write a description"
        }
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let title = alert.textFields![0] as UITextField
            let descript = alert.textFields![1] as UITextField
            self.todoList.insert(Todo(withTitle: title.text ?? "Title", andDescription: descript.text ?? "Description"), at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            // write action when the user choose 'cancel'
        }))
        self.present(alert, animated: true, completion: nil)

    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let todo = todoList[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.todoItem = todo
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoTableViewCell

        let todo = todoList[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.descriptionLabel.text = todo.todoDescription
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = todoList[sourceIndexPath.row]
        todoList.remove(at: sourceIndexPath.row)
        todoList.insert(temp, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editPriority = UIContextualAction(style: .normal, title: "Priority") { (action, view, completion) in
            // TODO: show alert
            let alert = UIAlertController(title: "TODO", message: "Choose it's priority", preferredStyle: .alert)
            let highButton = UIAlertAction(title: "HIGHT", style: .default) {
                (alertAction) in
                // action when they press OK
                self.todoList[indexPath.row].priority = .high
            }
            let middleButton = UIAlertAction(title: "MIDDLE", style: .default) {
                (alertAction) in
                self.todoList[indexPath.row].priority = .middle
            }
            let lowButton = UIAlertAction(title: "LOW", style: .default) {
                (alertAction) in
                self.todoList[indexPath.row].priority = .low
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) {
                (alertAction) in
                // action when they press Cancel
            }
            alert.addAction(highButton)
            alert.addAction(middleButton)
            alert.addAction(lowButton)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
            completion(true)
        }
        editPriority.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        let deletAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completion(false)
        }
        
        return UISwipeActionsConfiguration(actions: [editPriority, deletAction])
    }
}

