//
//  settingsViewController.swift
//  To-Do Manager
//
//  Created by Tariq M.fathy on 6/29/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController {

    let colorArray = [ 0x000000, 0xfe0000, 0xff7900, 0xffb900, 0xffde00, 0xfcff00, 0xd2ff00, 0x05c000, 0x00c0a7, 0x0600ff, 0x6700bf, 0x9500c0, 0xbf0199, 0xffffff ]
    var ViewBackground = 0
    @IBAction func sliderChanged(sender: AnyObject){
        selectedColorView.backgroundColor = uiColorFromHex(rgbValue: colorArray[Int(slider.value)])
        self.ViewBackground = colorArray[Int(slider.value)]
    }
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var categoryName: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        circlView(selectedColorView: selectedColorView)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCategory(_ sender: UIButton) {
        let newCategory = Categories(context: context)
        newCategory.categoryName = categoryName.text
        newCategory.categoryColour = Int32(ViewBackground)
        do{
            ad.saveContext()
            print("Saved")
        }
    }
}
