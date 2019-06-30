//
//  ViewController.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/28/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var tasksTableView: UITableView!
    
    var taskList = [Tasks]()
    var categoryList = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        hideKeyboardWhenTappedAround()
        loadTasks()
        print(taskList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTasks()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell", for: indexPath) as! tasksCell
        cell.setTaskData(taskNode: taskList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskData = taskList[indexPath.row]
        performSegue(withIdentifier: "taskEditing", sender: taskData)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let indexpath = IndexPath(item: 0, section: 0)
        let cell = self.tasksTableView.cellForRow(at: indexpath) as! tasksCell
        if (editingStyle == .delete) {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
            fetchRequest.predicate = NSPredicate(format: "taskName = %@", cell.taskName.text ?? "")
            
            do
            {
                let test = try context.fetch(fetchRequest)
                self.taskList.remove(at: indexpath.row)
                let objectToDelete = test[indexpath.row] as! NSManagedObject
                context.delete(objectToDelete)
                ad.saveContext()
            }
            catch
            {
                print(error)
            }
            
            tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? taskEditingViewController {
            if let tasks = sender as? Tasks{
                destenation.taskData = tasks
            }
        }
    }
    
    func loadTasks(){
        let fetchRequest1: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let fetchRequest2: NSFetchRequest<Categories> = Categories.fetchRequest()
        do{
            taskList = try context.fetch(fetchRequest1)
            categoryList = try context.fetch(fetchRequest2)
            tasksTableView.reloadData()
        }catch{
            
        }
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func circlView(selectedColorView: UIView){
        selectedColorView.layer.cornerRadius = selectedColorView.frame.width/2
        selectedColorView.clipsToBounds = true
        selectedColorView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        selectedColorView.layer.borderWidth = 2.0
    }
}
