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

    @IBOutlet weak var categoryColour: UIView!
    @IBOutlet weak var descreption: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var taskName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryColour.layer.cornerRadius = categoryColour.frame.width/2
        categoryColour.clipsToBounds = true
        categoryColour.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        categoryColour.layer.borderWidth = 2.0
    }

    func setTaskData (taskNode: Tasks,categoryNode: Categories){
        taskName.text = taskNode.taskName
        descreption.text = taskNode.descreption
        categoryName.text = categoryNode.categoryName ?? ""
        date.text = taskNode.completedDate ?? ""
        categoryColour.backgroundColor = uiColorFromHex(rgbValue: Int(categoryNode.categoryColour))
        }
    
    func uiColorFromHex(rgbValue: Int) -> UIColor {
        
        let red =   CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(rgbValue & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }


}
