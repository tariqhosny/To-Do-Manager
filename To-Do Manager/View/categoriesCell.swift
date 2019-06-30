//
//  categoriesCell.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/29/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit

class categoriesCell: UITableViewCell {

    @IBOutlet weak var categoryColour: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCategoryData (categoryNode: Categories){
        categoryName.text = categoryNode.categoryName ?? ""
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
