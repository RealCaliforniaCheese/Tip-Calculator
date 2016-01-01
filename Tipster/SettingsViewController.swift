//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Che Chao Hsu on 12/6/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipLowSlider:    UISlider!
    @IBOutlet weak var tipMidSlider:    UISlider!
    @IBOutlet weak var tipHighSlider:   UISlider!
    
    @IBOutlet weak var tipLowMinLabel:  UILabel!
    @IBOutlet weak var tipLowMaxLabel:  UILabel!
    @IBOutlet weak var tipMidMinLabel:  UILabel!
    @IBOutlet weak var tipMidMaxLabel:  UILabel!
    @IBOutlet weak var tipHighMinLabel: UILabel!
    @IBOutlet weak var tipHighMaxLabel: UILabel!
    
    @IBOutlet weak var tipDefaultControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // These number values represent each slider position
    var stepValue:Float32 = 1.00
    var newStep:Float32 = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLowMinLabel.text  = "10.0"
        tipMidMinLabel.text  = "15.0"
        tipHighMinLabel.text = "20.0"
        tipLowMaxLabel.text  = "20.0"
        tipMidMaxLabel.text  = "25.0"
        tipHighMaxLabel.text = "30.0"
        
        tipLowSlider!.continuous = false
        tipMidSlider!.continuous = false
        tipHighSlider!.continuous = false
        tipLowSlider.value = 15.0
        tipMidSlider.value = 20.0
        tipHighSlider.value = 25.0
    }
    
    
    override func viewDidAppear(animated: Bool) {
        tipLowSlider.value   = defaults.floatForKey("tipLow")
        tipMidSlider.value   = defaults.floatForKey("tipMid")
        tipHighSlider.value  = defaults.floatForKey("tipHigh")
        tipLowMinLabel.text  = "10.0"
        tipMidMinLabel.text  = "\(tipLowSlider.value+1)"
        tipHighMinLabel.text = "\(tipMidSlider.value+1)"
        tipLowMaxLabel.text  = "\(tipMidSlider.value-1)"
        tipMidMaxLabel.text  = "\(tipHighSlider.value-1)"
        tipHighMaxLabel.text = "30.0"
        tipMidSlider.minimumValue = tipLowSlider.value+1
        tipHighSlider.minimumValue = tipMidSlider.value+1
        tipLowSlider.maximumValue  = tipMidSlider.value-1
        tipMidSlider.maximumValue  = tipHighSlider.value-1
        tipDefaultControl.setTitle("\(tipLowSlider.value)", forSegmentAtIndex: 0)
        tipDefaultControl.setTitle("\(tipMidSlider.value)", forSegmentAtIndex: 1)
        tipDefaultControl.setTitle("\(tipHighSlider.value)", forSegmentAtIndex: 2)
        tipDefaultControl.selectedSegmentIndex = defaults.integerForKey("tipDefault")

    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        defaults.synchronize()
    }
    
    @IBAction func tipLowSliderValueChanged(sender: AnyObject) {
        // Round to nearest whole integer
        newStep = roundf((tipLowSlider.value) / stepValue)
        tipLowSlider.value = newStep * stepValue
        
        defaults.setFloat(tipLowSlider.value, forKey: "tipLow")
        tipMidSlider.minimumValue = tipLowSlider.value+1
        tipMidMinLabel.text = "\(tipLowSlider.value+1)"
        tipMidMinLabel.text = String(format: "%.1f", tipLowSlider.value+1)
        if tipLowSlider.maximumValue >= tipMidSlider.minimumValue {
            
        }
        tipDefaultControl.setTitle("\(tipLowSlider.value)", forSegmentAtIndex: 0)
    }
    
    @IBAction func tipMidSliderValueChanged(sender: AnyObject) {
        newStep = roundf((tipMidSlider.value) / stepValue)
        tipMidSlider.value = newStep * stepValue
        
        defaults.setFloat(tipMidSlider.value, forKey: "tipMid")
        tipLowSlider.maximumValue = tipMidSlider.value-1
        tipLowMaxLabel.text  = "\(tipMidSlider.value-1)"
        tipLowMaxLabel.text  = String(format: "%.1f", tipMidSlider.value-1)
        tipHighSlider.minimumValue = tipMidSlider.value + 1
        tipHighMinLabel.text  = "\(tipMidSlider.value+1)"
        tipHighMinLabel.text  = String(format: "%.1f", tipMidSlider.value+1)
        tipDefaultControl.setTitle("\(tipMidSlider.value)", forSegmentAtIndex: 1)
    }
    
    @IBAction func tipHighSliderValueChanged(sender: AnyObject) {
        newStep = roundf((tipHighSlider.value) / stepValue)
        tipHighSlider.value = newStep * stepValue
        
        defaults.setFloat(tipHighSlider.value, forKey: "tipHigh")
        tipMidSlider.maximumValue = tipHighSlider.value-1
        tipMidMaxLabel.text  = "\(tipHighSlider.value-1)"
        tipMidMaxLabel.text  = String(format: "%.1f", tipHighSlider.value-1)
        tipDefaultControl.setTitle("\(tipHighSlider.value)", forSegmentAtIndex: 2)
    }
    
    @IBAction func tipDefaultValueChanged(sender: AnyObject) {
        defaults.setInteger(tipDefaultControl.selectedSegmentIndex, forKey: "tipDefault")
    }
}
