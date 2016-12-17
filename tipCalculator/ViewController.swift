//
//  ViewController.swift
//  tipCalculator
//
//  Created by Daniel Sung on 12/14/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

import UIKit
import Canvas

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var calculations: CSAnimationView!
    @IBOutlet weak var facesView: CSAnimationView!
    @IBOutlet weak var billView: CSAnimationView!
    @IBOutlet var tipperView: UIView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var totalView: UIView!

    var initial:Bool = true
    var startup:Bool = true
    var fromSettings:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Bool Flags
        self.calculations.hidden = true
        billField.delegate = self
        
    }
    
    
    
    /* viewWillAppear():
     * - Set default segment
     * - Set theme
     */
    override func viewWillAppear(animated: Bool) {
        //Setting default segment
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tipDefault")
        
        //Set theme and color
        if defaults.stringForKey("theme") == "dark"{
            Style.darkTheme()
        }
        else {Style.lightTheme()}
        self.setTheme()
        
        self.calculateTip(self)
        startup = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* viewDidAppear():
     * Allow users to edit text field without having to press on it
     */
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey("fromSettings"){
            billField.text = defaults.stringForKey("bill")
            defaults.setBool(false, forKey: "fromSettings")
            defaults.synchronize()
        }
        
        billField.becomeFirstResponder()
    }
    
    
    /* onTap():
     * Removes keyboards when tapped out of the text field
     */
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    /* setTheme():
     * Based on the theme selected, set the colors of the view
     */
    func setTheme(){
        //Bill
        tipperView.backgroundColor = Style.viewBgColor
        billField.backgroundColor = Style.billBgColor
        billField.textColor = Style.billTextColor
        billField.attributedPlaceholder = NSAttributedString(string:"$0", attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        //Faces
        tipControl.tintColor = Style.facesTintColor
        tipControl.backgroundColor = Style.facesBgColor
        facesView.backgroundColor = Style.facesBgColor
        
        //Tip
        tipLabel.backgroundColor = Style.tipBgColor
        tipView.backgroundColor = Style.tipBgColor
        tipLabel.textColor = Style.tipTextColor
        
        //Total
        totalLabel.backgroundColor = Style.totalBgColor
        totalView.backgroundColor = Style.totalBgColor
        totalLabel.textColor = Style.totalTextColor
        
        
    }
    
    
    /* animateCalcOnInsert()
     * When text is being inserted, fade up the calculation totals
     */
    @IBAction func animateCalcOnInsert(sender: AnyObject) {
        if let text = billField.text where !text.isEmpty {
            
            if initial == false {
                calculations.hidden = true
                initial = true
            }
            
            if (calculations.hidden == true){
                calculations.hidden = false
                calculations.type = CSAnimationTypeFadeInUp
                calculations.duration = 0.3
                calculations.startCanvasAnimation()
                
            }
        }
    }
    
    
    /* animateCalcOnDelete:
     * When textfield is deleted to 0, fade out calculation results
     */
    @IBAction func animateCalcOnDelete(sender: UITextField){
        if let text = billField.text where text.isEmpty {
            if (calculations.hidden == false){
                calculations.type = CSAnimationTypeFadeOut
                calculations.duration = 0.30
                calculations.startCanvasAnimation()
                initial = false
            }
        }
    }
    
    
    /* textFieldShouldClear:
     * When text field is cleared, run shake animation on bill field
     */
    func textFieldShouldClear(textField: UITextField) -> Bool {
        if !startup {
            billView.type = CSAnimationTypeShake
            billView.duration = 0.5
            billView.startCanvasAnimation()
        }
        startup = false
        return true;
    }
    
 
    
    /* calculateTip:
     * Calculate the tip and the total based on selected segment
     */
    @IBAction func calculateTip(sender: AnyObject) {
        let billDefault = NSUserDefaults.standardUserDefaults()
        
        let bill = Double(billField.text!) ?? 0
        
        //Save current bill value
        billDefault.setValue(billField.text, forKey: "bill")
        
        let tipPercentages = [0.10, 0.15, 0.20]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = tip + bill
        
        
        //Seperate tip and total by thousands
        let thousandsSeperator = NSNumberFormatter()
        thousandsSeperator.numberStyle = .DecimalStyle
        thousandsSeperator.minimumFractionDigits = 2
        
        tipLabel.text = thousandsSeperator.stringFromNumber(tip)
        totalLabel.text = thousandsSeperator.stringFromNumber(total)
        
        billDefault.synchronize()
        

    
    }
    
}

