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
    
    var tipDefaultTitle: Float?
    var tipPercentages = [Float](count: 3, repeatedValue: 0.00)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // These number values represent each slider position
    var numbers = [1...50]
    var oldIndex = 0
    
    
    /*func bubbleSort(tipUnsortedPercentage: Float?) {
        for var i = 0; i <= 2; i++ {
            if tipUnsortedPercentage <= tipPercentages[i] {
                if i != 0 { // i=1
                    tipPercentages[i-1] = tipPercentages[i]

                }
                tipPercentages[i] = tipUnsortedPercentage!
            }
            // Replace last (highest) tip if tipUnsortedPercentage is greater than all
            else if tipUnsortedPercentage > tipPercentages[2] {
                tipPercentages[0] = tipPercentages[1]
                tipPercentages[1] = tipPercentages[2]
                tipPercentages[2] = tipUnsortedPercentage!
                
            }
        }
    }
    
    func setTipDefault() {
        for var i = 0; i <= 2; i++ {
            tipDefaultControl.setTitle("\(tipPercentages[i])", forSegmentAtIndex: i)
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLowMinLabel.text  = "0.00"
        tipMidMinLabel.text  = "0.00"
        tipHighMinLabel.text = "0.00"
        tipLowMaxLabel.text  = "50.00"
        tipMidMaxLabel.text  = "50.00"
        tipHighMaxLabel.text = "50.00"
        tipLowSlider.value = defaults.floatForKey("tipLow")
        tipMidSlider.value = defaults.floatForKey("tipMid")
        tipHighSlider.value = defaults.floatForKey("tipHigh")
        tipDefaultControl.setTitle("\(tipLowSlider.value)", forSegmentAtIndex: 0)
        tipDefaultControl.setTitle("\(tipMidSlider.value)", forSegmentAtIndex: 1)
        tipDefaultControl.setTitle("\(tipHighSlider.value)", forSegmentAtIndex: 2)

        // Do any additional setup after loading the view.
        tipLowSlider.value = 15.0
        // tipLowSlider = UISlider(frame: self.view.bounds)
        // self.view.addSubview(tipLowSlider!) // ERROR here
            
        // slider values go from 0 to the number of values in your numbers array
        // let numberOfSteps = Float(numbers.count - 1)
        // tipLowSlider!.minimumValue = 10;
        // tipLowSlider!.maximumValue = numberOfSteps;
        
        
        
        // If true, valueChanged continously called as the slider moves. If false only when let go.
        tipLowSlider!.continuous = false
        tipMidSlider!.continuous = false
        tipHighSlider!.continuous = false
        // tipLowSlider!.addTarget(self, action: "tipLowSliderValueChanged:", forControlEvents: .ValueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        defaults.synchronize()
    }
    @IBAction func tipLowSliderValueChanged(sender: AnyObject) {
        defaults.setFloat(tipLowSlider.value, forKey: "tipLow")
        if tipLowSlider.value > tipMidSlider.value {
            tipMidSlider.minimumValue = tipLowSlider.value
            tipMidMinLabel.text   = "\(tipLowSlider.value)"
            tipMidMinLabel.text   = String(format: "%.2f", tipLowSlider.value)
        }
        if tipLowSlider.value > tipHighSlider.value {
            tipHighSlider.minimumValue = tipLowSlider.value
            tipHighMinLabel.text  = "\(tipLowSlider.value)"
            tipHighMinLabel.text  = String(format: "%.2f", tipLowSlider.value)
        }
        tipDefaultControl.setTitle("\(tipLowSlider.value)", forSegmentAtIndex: 0)
        // round the slider position to the nearest index of the numbers array
        /* let index = (Int)(tipLowSlider!.value + 0.5);
        tipLowSlider?.setValue(Float(index), animated: false)
        let number = numbers[index]; // <-- This numeric value you want
        if oldIndex != index {
            print("sliderIndex:\(index)")
            print("number: \(number)")
            oldIndex = index
        } */
    }
    
    @IBAction func tipMidSliderValueChanged(sender: AnyObject) {
        if tipMidSlider.value > tipHighSlider.value {
            tipHighSlider.minimumValue = tipMidSlider.value
            tipHighMinLabel.text  = "\(tipMidSlider.value)"
            tipHighMinLabel.text  = String(format: "%.2f", tipLowSlider.value)
        }
        tipDefaultControl.setTitle("\(tipMidSlider.value)", forSegmentAtIndex: 1)
        defaults.setFloat(tipMidSlider.value, forKey: "tipMid")
    }
    
    @IBAction func tipHighSliderValueChanged(sender: AnyObject) {
        defaults.setFloat(tipHighSlider.value, forKey: "tipHigh")
        // bubbleSort(tipHighSlider.value)
        // setTipDefault()
        tipDefaultControl.setTitle("\(tipHighSlider.value)", forSegmentAtIndex: 2)
    }
}
