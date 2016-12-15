//
//  ViewController.swift
//  tipCalculator
//
//  Created by Daniel Sung on 12/14/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

import UIKit
import Canvas

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var calculations: CSAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    //Get default tip selection from settings view controller
    override func viewWillAppear(animated: Bool) {
        let tipDefault = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = tipDefault.integerForKey("tipDefault")
        self.calculateTip(self)
    }
    
    //Allows user to type without having to press the text field
    override func viewDidAppear(animated: Bool) {
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func animateCalculations(sender: AnyObject) {
        calculations.startCanvasAnimation()
    }
    
    
    //Calculate the tip based on selected tip percentage contol
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.10, 0.15, 0.20]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        

    
    }
    
}

