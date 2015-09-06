//
//  ViewController.swift
//  PaceTimes
//
//  Created by Kyle Mills on 8/27/15.
//  Copyright (c) 2015 Kyle Mills Dev. All rights reserved.
//

import UIKit

class PaceTimeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var goalTimePicker: UIPickerView!
    @IBOutlet weak var lblGoalTime: UILabel!
    
    @IBOutlet weak var segIntensityZones: UISegmentedControl!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distancePicker: UIPickerView!
    
    @IBOutlet weak var lblPaceTime: UILabel!
    
    let pickerData = [["\(1000)", "\(500)", "\(200)", "\(100)", "\(50)"], ["\(1000)", "\(500)", "\(200)", "\(100)", "\(50)"]]
    var intensityZone = 1.0
    let goalTimePickerData = [[" ", "\(1)", "\(2)", "\(3)", "\(4)", "\(5)", "\(6)", "\(7)", "\(8)", "\(9)", "\(10)", "\(11)"], ["\(01)", "\(02)", "\(03)", "\(04)", "\(05)", "\(06)", "\(07)", "\(08)", "\(09)", "\(10)","\(11)", "\(12)", "\(13)", "\(14)", "\(15)", "\(16)", "\(17)", "\(18)", "\(19)", "\(20)", "\(21)", "\(22)", "\(23)", "\(24)", "\(25)", "\(26)", "\(27)", "\(28)", "\(29)", "\(30)", "\(31)", "\(32)", "\(33)", "\(34)", "\(35)", "\(36)", "\(37)", "\(38)", "\(39)", "\(40)","\(41)", "\(42)", "\(43)", "\(44)", "\(45)", "\(46)", "\(47)", "\(48)", "\(49)", "\(50)", "\(51)", "\(52)", "\(53)", "\(54)", "\(55)", "\(56)", "\(57)", "\(58)", "\(59)", "\(60)"], [".\(1)", ".\(2)", ".\(3)", ".\(4)", ".\(5)", ".\(6)", ".\(7)", ".\(8)", ".\(9)"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distancePicker.delegate = self
        distancePicker.dataSource = self
        
        goalTimePicker.delegate = self
        goalTimePicker.dataSource = self
        
        distanceLabel.textAlignment = .Center
        distanceLabel.numberOfLines = 2
    }
    
    //MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView == goalTimePicker {
            return goalTimePickerData.count
        } else if pickerView == distancePicker {
            return pickerData.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == goalTimePicker {
            return goalTimePickerData[component].count
        } else if pickerView == distancePicker {
            return pickerData[component].count
        }
        return 0
    }

    //MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        //return pickerData[component][row]
        if pickerView == goalTimePicker {
            return goalTimePickerData[component][row]
        } else if pickerView == distancePicker {
            return pickerData[component][row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //updateLabel()
        if pickerView == distancePicker {
            updateLabel()
        } else if pickerView == goalTimePicker {
            updateGoalTimeLabel()
        }
        
    }
    
    func updateLabel() {
        let paceDistance = pickerData[0][distancePicker.selectedRowInComponent(0)]
        let raceDistance = pickerData[1][distancePicker.selectedRowInComponent(1)]
        distanceLabel.text = "Practice Distance: " + paceDistance + " \nRace Distance: " + raceDistance
    }
    func updateGoalTimeLabel() {
        let minutes = goalTimePickerData[0][goalTimePicker.selectedRowInComponent(0)]
        let seconds = goalTimePickerData[1][goalTimePicker.selectedRowInComponent(1)]
        let tenths = goalTimePickerData[2][goalTimePicker.selectedRowInComponent(2)]
        lblGoalTime.text = "\(minutes):\(seconds)\(tenths)"
    }
  
    //MARK: SegmentedControlShit
    @IBAction func changeZone(sender: UISegmentedControl) {
        changeIntesityZones(segIntensityZones)
    }
    
    
    func changeIntesityZones(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            intensityZone = 0.8
        case 2:
            intensityZone = 0.65
        case 3:
            intensityZone = 0.5
        default:
            intensityZone = 0.95
        }
    }
    //MARK: Calculating the Pace Time
    
    @IBAction func calculate(sender: UIButton) {
        paceTimeCalculated()
    }
    func paceTimeCalculated(){
        
        let minutes = goalTimePickerData[0][goalTimePicker.selectedRowInComponent(0)]
        let seconds = goalTimePickerData[1][goalTimePicker.selectedRowInComponent(1)]
        let tenths = goalTimePickerData[2][goalTimePicker.selectedRowInComponent(2)]
        let minutesDouble = (minutes as NSString!).doubleValue
        let secondsDouble = (seconds as NSString!).doubleValue
        let tenthsDouble = (tenths as NSString!).doubleValue
        
        let paceDistance = pickerData[0][distancePicker.selectedRowInComponent(0)]
        let raceDistance = pickerData[1][distancePicker.selectedRowInComponent(1)]
        let paceDistanceInt = paceDistance.toInt()
        let raceDistanceInt = raceDistance.toInt()
        
        let paceTime: Double
        let x: Double
        let y: Double
        let z: Double
        z = (minutesDouble * 60) + secondsDouble + tenthsDouble
        x = Double(raceDistanceInt!) / Double(paceDistanceInt!)
        y = z / x
        paceTime = y / intensityZone

        let unformatted = paceTime
        let formatted = (NSString(format: "%.2f", unformatted))
        lblPaceTime.text = formatted as String
    }
}

