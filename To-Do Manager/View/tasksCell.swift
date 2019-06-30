//
//  tasksCell.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/28/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import CoreData

class tasksCell: UITableViewCell {

    let colorFunc = UIViewController()
    
    
    @IBOutlet weak var CompletedTask: UILabel!
    @IBOutlet weak var categoryColour: UIView!
    @IBOutlet weak var descreption: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var taskName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorFunc.circlView(selectedColorView: categoryColour)
    }

    func setTaskData (taskNode: Tasks){
            taskName.text = taskNode.taskName ?? ""
            descreption.text = taskNode.descreption
            categoryName.text = taskNode.categoryName ?? ""
            date.text = taskNode.completedDate ?? ""
            categoryColour.backgroundColor = colorFunc.uiColorFromHex(rgbValue: Int(taskNode.categoryColour))
            if taskNode.completed == false{
                CompletedTask.isHidden = true
            }
        }


}
