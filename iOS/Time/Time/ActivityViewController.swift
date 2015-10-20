//
//  ActivityViewController.swift
//  Time
//
//  Created by Davide Bruzzone on 10/19/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var categories = [ "Add a category...", "One", "Two", "Three" ]

    // MARK: - Outlets
    @IBOutlet weak var categoryPicker: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "Activity"

        // Set up the category picker and its toolbar
        let categoryPickerView = UIPickerView()
        
        categoryPickerView.delegate = self

        let toolbar = UIToolbar()

        toolbar.barStyle = UIBarStyle.Default
        toolbar.translucent = true
        toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItemStyle.Plain,
                                         target: self,
                                         action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,
                                         target: nil,
                                         action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.Plain,
                                           target: self,
                                           action: "cancelPicker")
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.userInteractionEnabled = true
        
        categoryPicker.inputView = categoryPickerView
        categoryPicker.inputAccessoryView = toolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row != 0) {
            categoryPicker.text = categories[row]
        } else {
            categoryPicker.text = ""

            // TODO
        }
    }

    // MARK: - Actions
    func cancelPicker() {
        categoryPicker.text = ""

        donePicker()
    }

    func donePicker() {
        categoryPicker.resignFirstResponder()
    }

}
