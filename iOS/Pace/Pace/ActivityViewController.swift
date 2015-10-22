//
//  ActivityViewController.swift
//  Pace
//
//  Created by Davide Bruzzone on 10/14/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var distanceUnits = [ "Miles", "Kilometers" ]

    var timeItems = [ Array(0..<25), Array(0..<61), Array(0..<61) ]
    var currentTime = [ 0, 0, 0 ]

    var timePickerView: UIPickerView = UIPickerView()

    // MARK: - Outlets
    @IBOutlet weak var timePicker: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        timePicker.text = timeText()

        // Set up the category picker and its toolbar
        timePickerView.delegate = self

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
        let resetButton = UIBarButtonItem(title: "Reset",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "resetPicker")

        toolbar.setItems([resetButton, spaceButton, doneButton], animated: false)
        toolbar.userInteractionEnabled = true

        timePicker.inputView = timePickerView
        timePicker.inputAccessoryView = toolbar
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
        return timeItems.count
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeItems[component].count
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // TODO
        let item = timeItems[component][row]

        return addLeadingZero(item)
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentTime[component] = self.timeItems[component][row]

        timePicker.text = timeText()
    }

    // MARK: - Actions
    func resetPicker() {
        self.currentTime = [ 0, 0, 0 ]

        timePicker.text = timeText()

        donePicker()

        resetPickerView(timePickerView, range: 0..<3)
    }

    func donePicker() {
        timePicker.resignFirstResponder()
    }

    func timeText() -> String {
        return "\(addLeadingZero(self.currentTime[0])):\(addLeadingZero(self.currentTime[1])):\(addLeadingZero(self.currentTime[2]))"
    }

    func addLeadingZero(num: Int) -> String {
        let numString = String(num)

        var result = ""

        if (num < 10) {
            result = "0\(numString)"
        } else {
            result = numString
        }

        return result
    }

    func resetPickerView(pickerView: UIPickerView, range: Range<Int>) {
        for component in range {
            pickerView.selectRow(0, inComponent: component, animated: false)
        }
    }

}
