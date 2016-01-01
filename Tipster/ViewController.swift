//
//  ViewController.swift
//  Tipster
//
//  Created by Che Chao Hsu on 11/29/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField:  UITextField!
    @IBOutlet weak var tipLabel:   UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tabStepper: UIStepper!
    @IBOutlet weak var tabQtyField: UITextField!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tipLowSetting:Float32   = 15.0
    var tipMidSetting:Float32   = 20.0
    var tipHighSetting:Float32  = 25.0
    var billAmount:Float32      = 0.00
    var tip:Float32             = 0.00
    var total:Float32           = 0.00
    var tab:Float32             = 0.00
    var tipPercentages          = [Float](count: 3, repeatedValue: 0.0)
    var tipPercentage:Float32   = 0.00
    
    let imgArray                = ["low", "mid", "high"]
    
    func setLabelTotals () {
        tipPercentages = [tipLowSetting, tipMidSetting, tipHighSetting]
        tipPercentage  = tipPercentages[tipControl.selectedSegmentIndex]
        
        billAmount = NSString(string: billField.text!).floatValue
        tip = billAmount * (tipPercentage/100)
        total = billAmount + tip
        tab = total / (Float32)(tabStepper.value)
        
        tipLabel.text    = "$\(tip)"
        totalLabel.text  = "$\(total)"
        tabLabel.text    = "$\(tab)"
        tabQtyField.text = "\((Int)(tabStepper.value))"
        tipLabel.text    = String(format: "$%.2f", tip)
        totalLabel.text  = String(format: "$%.2f", total)
        tabLabel.text    = String(format: "$%.2f", tab)
    }
    
    func setTipDefaultControl () {
        tipLowSetting  = defaults.floatForKey("tipLow")
        tipMidSetting  = defaults.floatForKey("tipMid")
        tipHighSetting = defaults.floatForKey("tipHigh")
        
        tipControl.setTitle("\(tipLowSetting)", forSegmentAtIndex: 0)
        tipControl.setTitle("\(tipMidSetting)", forSegmentAtIndex: 1)
        tipControl.setTitle("\(tipHighSetting)", forSegmentAtIndex: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text    = "$0.00"
        totalLabel.text  = "$0.00"
        tabQtyField.text = "\((Int)(tabStepper.value))"
        tabLabel.text    = "$0.00"
        
        defaults.setFloat(tipLowSetting, forKey: "tipLow")
        defaults.setFloat(tipMidSetting, forKey: "tipMid")
        defaults.setFloat(tipHighSetting, forKey: "tipHigh")
        
        setTipDefaultControl()
    }
    
    override func viewDidAppear(animated: Bool) {
        tipControl.selectedSegmentIndex = defaults.integerForKey("tipDefault")
        
        setLabelTotals()
        setTipDefaultControl()
        billField.becomeFirstResponder()
        imgView.image = UIImage(named: imgArray[tipControl.selectedSegmentIndex])
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        setLabelTotals()
    }

    @IBAction func onSegmentedContChanged(sender: AnyObject) {
        imgView.image = UIImage(named: imgArray[tipControl.selectedSegmentIndex])
    }
    
    @IBAction func onTabStepChanged(sender: AnyObject) {
        setLabelTotals()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
