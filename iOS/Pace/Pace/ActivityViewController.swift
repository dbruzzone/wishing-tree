//
//  ActivityViewController.swift
//  Pace
//
//  Created by Davide Bruzzone on 10/14/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // Picker view values
    var timePickerValues = [ Array(0..<25), Array(0..<61), Array(0..<61) ]
    var pacePickerValues = [ Array(0..<61), Array(0..<61) ]
    var distancePickerValues = [ Array(0..<101), Array(0..<11) ]

    var distanceUnitValues = [ "mile", "kilometer" ]
    var currentDistanceUnits: Int = 0

    // Current picker view values
    var currentTime: [Int] = [ 0, 0, 0 ]
    var currentPace: [Int] = [ 0, 0 ]
    var currentDistance: [Int] = [ 0, 0 ]

    var timePickerView: UIPickerView = UIPickerView()
    var pacePickerView: UIPickerView = UIPickerView()
    var distancePickerView: UIPickerView = UIPickerView()

    var currentPicker: UITextField?

    // MARK: - Outlets
    @IBOutlet weak var distanceUnits: UISegmentedControl!

    @IBOutlet weak var timePicker: UITextField!
    @IBOutlet weak var pacePicker: UITextField!
    @IBOutlet weak var distancePicker: UITextField!

    @IBAction func touchDown(sender: AnyObject) {
        self.currentPicker = sender as? UITextField
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        timePicker.text = timeText()
        pacePicker.text = paceText()
        distancePicker.text = distanceText()

        // Set up the category picker and its toolbar
        self.initPicker(timePicker, pickerView: timePickerView)
        self.initPicker(pacePicker, pickerView: pacePickerView)
        self.initPicker(distancePicker, pickerView: distancePickerView)
    }

    func initPicker(textField: UITextField, pickerView: UIPickerView) {
        pickerView.delegate = self
        
        let toolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.Default
        toolbar.translucent = true
        // TODO
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
        
        textField.inputView = pickerView
        textField.inputAccessoryView = toolbar
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
        var result: Int?

        if (pickerView == self.timePickerView) {
            result = self.timePickerValues.count
        } else if (pickerView == self.pacePickerView) {
            result = self.pacePickerValues.count
        } else if (pickerView == self.distancePickerView) {
            result = self.distancePickerValues.count
        }

        return result!
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var result: Int?

        if (pickerView == self.timePickerView) {
            result = self.timePickerValues[component].count
        } else if (pickerView == self.pacePickerView) {
            result = self.pacePickerValues[component].count
        } else if (pickerView == self.distancePickerView) {
            result = self.distancePickerValues[component].count
        }

        return result!
    }

    // MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result: String?

        if (pickerView == self.timePickerView) {
            let item = self.timePickerValues[component][row]

            result = addLeadingZero(item)
        } else if (pickerView == self.pacePickerView) {
            let item = self.pacePickerValues[component][row]
            
            result = addLeadingZero(item)
        } else if (pickerView == self.distancePickerView) {
            let item = self.distancePickerValues[component][row]
            
            result = component == 0 ? String(item) : addLeadingZero(item)
        }

        return result
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.timePickerView) {
            self.currentTime[component] = self.timePickerValues[component][row]

            self.timePicker.text = timeText()
        } else if (pickerView == self.pacePickerView) {
            self.currentPace[component] = self.pacePickerValues[component][row]
            
            self.pacePicker.text = paceText()
        }  else if (pickerView == self.distancePickerView) {
            self.currentDistance[component] = self.distancePickerValues[component][row]
            
            self.distancePicker.text = distanceText()
        }
    }

    // MARK: - Actions
    @IBAction func distanceUnitsChanged(sender: AnyObject) {
        switch distanceUnits.selectedSegmentIndex {
        case 0:
            self.currentDistanceUnits = 0
        case 1:
            self.currentDistanceUnits = 1
        default:
            break; 
        }

        pacePicker.text = paceText()
        distancePicker.text = distanceText()
    }

    func resetPicker() {
        if (self.currentPicker == self.timePicker) {
            self.currentTime = [ 0, 0, 0 ]

            resetFieldAndPicker(self.timePicker, textFieldValue: self.timeText(), pickerView: self.timePickerView, numberOfComponents: 3)
        } else if (self.currentPicker == self.pacePicker) {
            self.currentPace = [ 0, 0 ]

            resetFieldAndPicker(self.pacePicker, textFieldValue: self.paceText(), pickerView: self.pacePickerView, numberOfComponents: 2)
        } else if (self.currentPicker == self.distancePicker) {
            self.currentDistance = [ 0, 0 ]
            
            resetFieldAndPicker(self.distancePicker, textFieldValue: self.distanceText(), pickerView: self.distancePickerView, numberOfComponents: 2)
        }
    }

    func donePicker() {
        self.currentPicker!.resignFirstResponder()
    }

    func timeText() -> String {
        return "\(addLeadingZero(self.currentTime[0])):\(addLeadingZero(self.currentTime[1])):\(addLeadingZero(self.currentTime[2]))"
    }

    func paceText() -> String {
        return "\(addLeadingZero(self.currentPace[0])):\(addLeadingZero(self.currentPace[1])) per \(self.distanceUnitValues[self.currentDistanceUnits])"
    }

    func distanceText() -> String {
        
        return "\(self.currentDistance[0]).\(addLeadingZero(self.currentDistance[1])) \(self.distanceUnitValues[self.currentDistanceUnits])s"
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

    func resetFieldAndPicker(textField: UITextField, textFieldValue: String, pickerView: UIPickerView, numberOfComponents: Int) {
        textField.text = textFieldValue
        
        donePicker()
        
        resetPickerView(pickerView, range: 0..<numberOfComponents)
    }

    func resetPickerView(pickerView: UIPickerView, range: Range<Int>) {
        for component in range {
            pickerView.selectRow(0, inComponent: component, animated: false)
        }
    }

}
