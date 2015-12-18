//
//  ViewController.swift
//  Tipster
//
//  Created by Che Chao Hsu on 11/29/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tipLowSetting, tipMidSetting, tipHighSetting: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text   = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    override func viewDidAppear(animated: Bool) {
        tipLowSetting = defaults.floatForKey("tipLow")
        tipMidSetting = defaults.floatForKey("tipMid")
        tipHighSetting = defaults.floatForKey("tipHigh")
        
        tipControl.setTitle("\(tipLowSetting!)", forSegmentAtIndex: 0)
        tipControl.setTitle("\(tipMidSetting!)", forSegmentAtIndex: 1)
        tipControl.setTitle("\(tipHighSetting!)", forSegmentAtIndex: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [tipLowSetting, tipMidSetting, tipHighSetting]
        let tipPercentage  = tipPercentages[tipControl.selectedSegmentIndex]
    
        let billAmount = NSString(string: billField.text!).floatValue
        let tip = billAmount * tipPercentage! / 100
        let total = (billAmount + tip)
        
        tipLabel.text   = "$\(tip)"
        totalLabel.text = "$\(total)"
        tipLabel.text   = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
