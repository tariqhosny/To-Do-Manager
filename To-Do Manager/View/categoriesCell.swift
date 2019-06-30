//
//  categoriesCell.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/29/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit

class categoriesCell: UITableViewCell {

    let colorFunc = UIViewController()
    
    @IBOutlet weak var categoryColour: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorFunc.circlView(selectedColorView: categoryColour)
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCategoryData (categoryNode: Categories){
        categoryName.text = categoryNode.categoryName ?? ""
        categoryColour.backgroundColor = colorFunc.uiColorFromHex(rgbValue: Int(categoryNode.categoryColour))
    }
    
}
