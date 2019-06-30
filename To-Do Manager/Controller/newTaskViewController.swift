//
//  newTaskViewController.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/28/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import CoreData

class newTaskViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    var selectedCategory = [Categories]()
    var changeDate: String?
    var selectedCategoryNameFromTableView: String?
    var selectedCategoryColorFromTableView: Int32?

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var descreptionText: UITextView!
    @IBOutlet weak var datePackerShow: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        categoryTableView.delegate=self
        categoryTableView.dataSource=self
        loadTasks()
        showCompletedDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTasks()
    }
    
    func showCompletedDate(){
        var datePicker: UIDatePicker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(newTaskViewController.dateChange(datePicker:)), for: .valueChanged)
        self.view.endEditing(false)
        datePackerShow.inputView = datePicker
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        let dateEdeted = dateFormat.string(from: datePicker.date)
        datePackerShow.text = dateEdeted
        changeDate = dateEdeted
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! categoriesCell
        cell.setCategoryData(categoryNode: selectedCategory[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategoryNameFromTableView = selectedCategory[indexPath.row].categoryName
        selectedCategoryColorFromTableView = selectedCategory[indexPath.row].categoryColour
        print(selectedCategory[indexPath.row].categoryName ?? "")
    }
    
    @IBAction func saveTask(_ sender: Any) {
        let newTask = Tasks(context: context)
        newTask.categoryName = selectedCategoryNameFromTableView
        newTask.categoryColour = selectedCategoryColorFromTableView ?? 0
        newTask.taskName = taskName.text
        newTask.descreption = descreptionText.text
        newTask.completed = false
        newTask.completedDate = changeDate
        
        do{
            ad.saveContext()
            print("Saved")
        }
        
    }
    
    func displayErrors (errorText: String){
        let alert = UIAlertController.init(title: "Message", message: errorText, preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadTasks(){
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        do{
            selectedCategory = try context.fetch(fetchRequest)
            categoryTableView.reloadData()
        }catch{
            
        }
    }
    


}
