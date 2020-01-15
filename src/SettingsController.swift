//
//  SettingsController.swift
//  FinalProgcat0050Su19
//
//  Created by Christopher Tillery on 7/17/19.
//  Copyright © 2019 Christopher Tillery. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerData: [String] = [String]()
    var valueSelected = 0
    var currentVolume = 0
    var unbeatableMode = false
    var difficulty = "Medium"
    
    @IBOutlet weak var boardSizePicker: UIPickerView!
    @IBOutlet weak var difficultyMode: UISegmentedControl!
    @IBOutlet weak var unbeatable: UISwitch!
    @IBOutlet weak var currentVolumeSelection: UILabel!
    @IBOutlet weak var currentVolumeMeter: UISlider!
    
    @IBAction func difficultySetting(_ sender: UISegmentedControl) {
        if difficultyMode.selectedSegmentIndex == 0 {
            difficulty = "Easy"
        }
        else if difficultyMode.selectedSegmentIndex == 1 {
            difficulty = "Medium"
        }
        else {
            difficulty = "Hard"
        }
        UserDefaults.standard.set(difficulty, forKey: "difficulty")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func unbeatableToggle(_ sender: UISwitch) {
        if unbeatable.isOn {
            unbeatableMode = true
        }
        else {
            unbeatableMode = false
        }
        UserDefaults.standard.set(unbeatableMode, forKey: "unbeatableMode")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func volumeMeter(_ sender: UISlider) {
        currentVolume = Int(sender.value)
        currentVolumeSelection.text = "\(currentVolume)"
        UserDefaults.standard.set(currentVolume, forKey: "currentVolume")
        UserDefaults.standard.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardSizePicker.delegate = self
        self.boardSizePicker.dataSource = self
    
        pickerData = ["X vs. O", "Plus vs. Minus", "Dot vs. Circle"]
        if UserDefaults.standard.string(forKey: "difficulty") != nil {
            difficulty = UserDefaults.standard.string(forKey: "difficulty")!
        }
        else {
            UserDefaults.standard.set(difficulty, forKey: "difficulty")
            UserDefaults.standard.synchronize()
        }
        
        if UserDefaults.standard.string(forKey: "currentVolume") != nil {
            currentVolume = UserDefaults.standard.integer(forKey: "currentVolume")
        }
        else {
            UserDefaults.standard.set(currentVolume, forKey: "currentVolume")
            UserDefaults.standard.synchronize()
        }

        if UserDefaults.standard.string(forKey: "unbeatableMode") != nil {
            unbeatableMode = UserDefaults.standard.bool(forKey: "unbeatableMode")
        }
        else {
            UserDefaults.standard.set(unbeatableMode, forKey: "unbeatableMode")
            UserDefaults.standard.synchronize()
        }
        
        if UserDefaults.standard.string(forKey: "pickerRow") != nil {
            valueSelected = UserDefaults.standard.integer(forKey: "pickerRow")
        }
        else {
            UserDefaults.standard.set(valueSelected, forKey: "pickerRow]")
            UserDefaults.standard.synchronize()
        }

        boardSizePicker.selectRow(valueSelected, inComponent: 0, animated: true)
        if unbeatableMode {
            unbeatable.setOn(true, animated: true)
        }
        if difficulty == "Easy" {
            difficultyMode.selectedSegmentIndex = 0
        }
        else if  difficulty == "Medium" {
            difficultyMode.selectedSegmentIndex = 1
        }
        else {
            difficultyMode.selectedSegmentIndex = 2
        }
        
        currentVolumeMeter.value = Float(currentVolume)
        currentVolumeSelection.text = String(currentVolume)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueSelected = row
        UserDefaults.standard.set(valueSelected, forKey: "pickerRow")
        UserDefaults.standard.synchronize()
    }
}
