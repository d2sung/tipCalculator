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
    
    
    
    @IBOutlet var tipperView: UIView!
    
    //Bill
    @IBOutlet weak var billView: CSAnimationView!
    @IBOutlet weak var billField: UITextField!
    
    //Tip
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    
    //Total
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var calculations: CSAnimationView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var plusSign: UILabel!
    
    //Splitter
    @IBOutlet weak var splitterView: UIView!
    @IBOutlet weak var checkSplitLabel1: UILabel!
    @IBOutlet weak var checkSplitLabel2: UILabel!
    @IBOutlet weak var checkSplitLabel3: UILabel!
    @IBOutlet weak var checkSplitLabel4: UILabel!
    @IBOutlet weak var userStepper: UIStepper!
    @IBOutlet weak var numUserLabel: UILabel!
    @IBOutlet var userIcons: [UIImageView]!
   
    //Boolean Flags
    var initial:Bool = true             //True if
    var startup:Bool = true             //True if
    var fromSettings:Bool = false       //True if view came from settings
    var firstInsert = true              //True if
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navbar to icon
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "Icon-App-29x29@3x.png")
        imageView.image = image
        
        navigationItem.titleView = imageView
        
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
        
        else {
            Style.lightTheme()
        }
        
        self.setTheme()
        
        //Animate billField
        //If view came from settings and the bill field is not empty, then bill field should be at the top of view
        if defaults.objectForKey("fromSettings") == nil {
            billView.center.y = 305
        }
        
        if defaults.boolForKey("fromSettings"){
            if let text = billField.text where !text.isEmpty {
                billView.center.y = 105
            }
        }
        //Else, bill field should be at the middle of view
        else {
            defaults.setObject(billView.center.y, forKey: "billViewLoc")
            billView.center.y = 305
        }
        
        self.calculateTip(self)
        startup = false
        
        
        defaults.synchronize()
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
        
        //NSDate
        let date = NSDate.init()
        
        
        if defaults.objectForKey("date") == nil{
            defaults.setObject(date, forKey: "date")
        }
            
        else {
            
            let oldDate = defaults.objectForKey("date") as! NSDate
            let timeChange = date.timeIntervalSinceDate(oldDate)
            
            if timeChange < 600 {
                billField.text = defaults.stringForKey("bill")
            }
            
            else {
                billField.text = nil
            }
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
        
        //Navigation bar
        UINavigationBar.appearance().barTintColor = Style.totalTextColor

        //Bill
        tipperView.backgroundColor = Style.viewBgColor
        billField.backgroundColor = Style.billBgColor
        billField.textColor = Style.billTextColor
        billField.attributedPlaceholder = NSAttributedString(string:"$0", attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        billField.setPlaceholderColor(Style.placeHolderColor)
        billField.tintColor = Style.facesTintColor
        
        //Faces
        tipControl.tintColor = Style.facesTintColor
        tipControl.backgroundColor = Style.facesBgColor
        //facesView.backgroundColor = Style.facesBgColor
        
        //Tip
        tipLabel.backgroundColor = Style.tipBgColor
        tipView.backgroundColor = Style.tipBgColor
        tipLabel.textColor = Style.tipTextColor
        
        //Total
        totalLabel.backgroundColor = Style.totalBgColor
        totalView.backgroundColor = Style.totalBgColor
        totalLabel.textColor = Style.totalTextColor
        plusSign.textColor = Style.facesTintColor
        
        
        //Set all userIcons to same color
        for userIcon in self.userIcons {
            userIcon.image = userIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            userIcon.tintColor = Style.icon
        }
        
        //Splitter
        splitterView.backgroundColor = Style.splitterColor
        checkSplitLabel1.textColor = Style.totalTextColor
        checkSplitLabel2.textColor = Style.totalTextColor
        checkSplitLabel3.textColor = Style.totalTextColor
        checkSplitLabel4.textColor = Style.totalTextColor
        
        numUserLabel.textColor = Style.facesTintColor
        userStepper.tintColor = Style.facesTintColor
    }
    
    
    /* animateCalcOnInsert()
     * When text is being inserted, slide/fade up billField, segment and the calculation totals
     */
    @IBAction func animateCalcOnInsert(sender: AnyObject) {
        //If billField is empty and this is the first insert
        if let text = billField.text where !text.isEmpty {
            if firstInsert {
                billView.duration = 0.30
                billView.delay = 0.05
                billView.type = CSAnimationTypeSlideUp
                billView.startCanvasAnimation()
                billView.center.y = 105
                firstInsert = false
            }
            
            //Hide calculations
            if initial == false {
                calculations.hidden = true
                initial = true
            }
            
            //If caulculations are hidden, then animate up on insert
            if (calculations.hidden == true){
                calculations.hidden = false
                calculations.type = CSAnimationTypeFadeInUp
                calculations.delay = 0.05
                calculations.duration = 0.30
                calculations.startCanvasAnimation()
            }
        }
    }
    
    
    /* animateCalcOnDelete:
     * When textfield is deleted to 0, slide down bill field, fade out calculations and segment
     */
    @IBAction func animateCalcOnDelete(sender: UITextField){
        if let text = billField.text where text.isEmpty {
            if (calculations.hidden == false){
                calculations.type = CSAnimationTypeFadeOut
                calculations.duration = 0.20
                calculations.startCanvasAnimation()
                
                billView.type = CSAnimationTypeSlideDown
                billView.duration = 0.40
                billView.delay = 0.15
                billView.center.y = 305
                billView.startCanvasAnimation()
                
                //Reset stepper for splitter
                userStepper.value = 0
                numUserLabel.text = "x5"
                firstInsert = true
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
    
    /* stepperValueChanged:
     * When + or - is pressed, change stepper value and results accordingly
     */
    @IBAction func stepperValueChanged(sender: UIStepper) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let total = defaults.doubleForKey("total")
        
        //Seperate tip and total by thousands and add currency format
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        //Divide total sum by number of users
        checkSplitLabel4.text = currencyFormatter.stringFromNumber(total / sender.value)
        numUserLabel.text = "x" + Int(sender.value).description
    }
    
    
    /*formatBillField:
     * TODO
     */
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
        
        //Save current bill value for if the view changes to settings
        billDefault.setValue(billField.text, forKey: "bill")
        
        //Get value of the sliders set in setting
        let sadValue = billDefault.integerForKey("sadSlider")
        let happyValue = billDefault.integerForKey("happySlider")
        let lolValue = billDefault.integerForKey("lolSlider")
        let tipPercentages = [Double(sadValue)/100, Double(happyValue)/100, Double(lolValue)/100, 0]
        
        //Get tip and total sum
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex])
        let total = tip + bill
        
        //Seperate tip and total by thousands and format to currency
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        
        billDefault.setValue(total, forKey: "total")
        
        //Set split values
        checkSplitLabel1.text = currencyFormatter.stringFromNumber(total/2)
        checkSplitLabel2.text = currencyFormatter.stringFromNumber(total/3)
        checkSplitLabel3.text = currencyFormatter.stringFromNumber(total/4)
        checkSplitLabel4.text = currencyFormatter.stringFromNumber(total/5)
        
        billDefault.synchronize()
    }
    
}

