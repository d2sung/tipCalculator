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
    @IBOutlet weak var checkSplitLabel1: UILabel!
    @IBOutlet weak var checkSplitLabel2: UILabel!
    @IBOutlet weak var checkSplitLabel3: UILabel!
    @IBOutlet weak var checkSplitLabel4: UILabel!
    
    @IBOutlet weak var userStepper: UIStepper!
    @IBOutlet weak var numUserLabel: UILabel!
    @IBOutlet weak var splitterView: UIView!
    
    @IBOutlet weak var equationSign: UILabel!
    @IBOutlet weak var plusSign: UILabel!
    
    
    @IBOutlet var userIcons: [UIImageView]!
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
        startup = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /* viewDidAppear():
     * Allow users to edit text field without having to press on it
     */
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //If coming back from settings, display the existing value in billField
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
        
        
        for userIcon in self.userIcons {
        
            userIcon.image = userIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
            userIcon.tintColor = Style.facesTintColor
        }
        
        splitterView.backgroundColor = Style.splitterColor
        
        checkSplitLabel1.textColor = Style.totalTextColor
        checkSplitLabel2.textColor = Style.totalTextColor
        checkSplitLabel3.textColor = Style.totalTextColor
        checkSplitLabel4.textColor = Style.totalTextColor
        numUserLabel.textColor = Style.facesTintColor
        
        userStepper.tintColor = Style.facesTintColor
        plusSign.textColor = Style.facesTintColor
        equationSign.textColor = Style.facesTintColor
        
        billField.setPlaceholderColor(UIColor(red:0.81, green:0.85, blue:0.86, alpha:0.30))
        billField.tintColor = Style.facesTintColor
        
        UINavigationBar.appearance().barTintColor = Style.totalTextColor
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
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let total = defaults.doubleForKey("total")
        
        //Seperate tip and total by thousands
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        checkSplitLabel4.text = currencyFormatter.stringFromNumber(total / sender.value)
        
        //let numberOfUsers = String(format: "%d", sender.value)
        
        numUserLabel.text = "x" + Int(sender.value).description
    }
    
    
    @IBAction func formatBillField(sender: AnyObject) {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        billField.text = currencyFormatter.stringFromNumber(0)
    }
 
    
    /* calculateTip:
     * Calculate the tip and the total based on selected segment
     */
    @IBAction func calculateTip(sender: AnyObject) {
        let billDefault = NSUserDefaults.standardUserDefaults()
        
        let bill = Double(billField.text!) ?? 0
        
        //Save current bill value
        billDefault.setValue(billField.text, forKey: "bill")
        
        let sadValue = billDefault.integerForKey("sadSlider")
    
        let happyValue = billDefault.integerForKey("happySlider")
        
        let lolValue = billDefault.integerForKey("lolSlider")
        
        let tipPercentages = [Double(sadValue)/100, Double(happyValue)/100, Double(lolValue)/100, 0]
        
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex])
        
        let total = tip + bill
        
        
        //Seperate tip and total by thousands
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
        billDefault.setValue(total, forKey: "total")
        
        
        
        checkSplitLabel1.text = currencyFormatter.stringFromNumber(total/2)
        checkSplitLabel2.text = currencyFormatter.stringFromNumber(total/3)
        checkSplitLabel3.text = currencyFormatter.stringFromNumber(total/4)
        checkSplitLabel4.text = currencyFormatter.stringFromNumber(total/5)
        
        billDefault.synchronize()
        

    
    }
    
}

