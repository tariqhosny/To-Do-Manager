//
//  taskEditingViewController.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/29/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import CoreData

class taskEditingViewController: UIViewController {

    var taskData = Tasks()
    var changeDate: String?

    
    @IBOutlet weak var editeOutlet: UIButton!
    @IBOutlet weak var completedOutlet: UIButton!
    @IBOutlet weak var taskDate: UITextField!
    @IBOutlet weak var taskDescreption: UITextView!
    @IBOutlet weak var taskName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        showCompletedDate()
        showData()
        
        if taskData.completed == true{
            taskDate.isEnabled = false
            taskDescreption.isEditable = false
            taskName.isEnabled = false
            completedOutlet.isHidden = true
            editeOutlet.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func showData(){
        taskName.text = taskData.taskName
        taskDescreption.text = taskData.descreption
        taskDate.text = taskData.completedDate
    }

    @IBAction func deleteTask(_ sender: UIButton) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        fetchRequest.predicate = NSPredicate(format: "taskName = %@", taskName.text ?? "")
        
        do
        {
            let test = try context.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            context.delete(objectToDelete)
            
            do{
                try context.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    @IBAction func completedTask(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        do {
            try context.fetch(fetchRequest);
            taskData.setValue(true, forKey: "completed")
            try context.save()
            print("Completed")
        }
        catch let error as NSError {
            print("Could not Fetch \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func updateTask(_ sender: UIButton) {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do {
            try context.fetch(fetchRequest);
            
            taskData.setValue(taskName.text ?? "", forKey: "taskName")
            taskData.setValue(taskDescreption.text ?? "", forKey: "descreption")
            taskData.setValue(changeDate, forKey: "completedDate")
            
            try context.save()
            
        }
        catch let error as NSError {
            print("Could not Fetch \(error), \(error.userInfo)")
        }
    }
    
    func showCompletedDate(){
        var datePicker: UIDatePicker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(newTaskViewController.dateChange(datePicker:)), for: .valueChanged)
        self.view.endEditing(false)
        taskDate.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        let dateEdeted = dateFormat.string(from: datePicker.date)
        taskDate.text = dateEdeted
        changeDate = dateEdeted
        view.endEditing(true)
    }
    
    
}
