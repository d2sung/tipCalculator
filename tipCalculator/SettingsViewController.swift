//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Daniel Sung on 12/14/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //Default Elements
    @IBOutlet weak var setDefaultView: UIView!
    @IBOutlet weak var setDefaultLabel: UILabel!
    @IBOutlet weak var defaultControl: UISegmentedControl!
    
    //Theme Elements
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeView: UIView!
    
    @IBOutlet weak var defaultGratuityView: UIView!
    @IBOutlet weak var defaultGratuityText: UILabel!
    //Sad
    @IBOutlet weak var sadIcon: UIImageView!
    @IBOutlet weak var sadSlider: UISlider!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var sadView: UIView!
    
    //Happy
    @IBOutlet weak var happyIcon: UIImageView!
    @IBOutlet weak var happySlider: UISlider!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var happyView: UIView!
    
    //LOL
    @IBOutlet weak var lolIcon: UIImageView!
    @IBOutlet weak var lolLabel: UILabel!
    @IBOutlet weak var lolSlider: UISlider!
    @IBOutlet weak var lolView: UIView!
    
    //Reset
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //Load current state at which the segment control is at
        defaultControl.selectedSegmentIndex = defaults.integerForKey("tipDefault")
        
        //Save fromSettings
        defaults.setBool(true, forKey: "fromSettings")
        
        //Load current state at which the switch is at
        let switchBool = defaults.boolForKey("switch")
        themeSwitch.setOn(switchBool, animated: false)
    
        //Set theme and color
        if defaults.stringForKey("theme") == "dark"{
            Style.darkTheme()
        }
        else {Style.lightTheme()}
        self.setTheme()
        
        //Set Sliders: If first time, then set defaults
        if defaults.objectForKey("sadSlider") == nil {
            sadSlider.setValue(10, animated: false)
            sadLabel.text = "10%"
            
            happySlider.setValue(15, animated: false)
            happyLabel.text = "15%"
            
            lolSlider.setValue(20, animated: false)
            lolLabel.text = "20%"
        }
        
        //Else, load the saved slider values
        else {
            let sadValue = defaults.integerForKey("sadSlider")
            sadSlider.setValue(Float(sadValue), animated: false)
            sadLabel.text = String(sadValue) + "%"
            
            let happyValue = defaults.integerForKey("happySlider")
            happySlider.setValue(Float(happyValue), animated: false)
            happyLabel.text = String(happyValue) + "%"
            
            let lolValue = defaults.integerForKey("lolSlider")
            lolSlider.setValue(Float(lolValue), animated: false)
            lolLabel.text = String(lolValue) + "%"
        }
        defaults.synchronize()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*setTheme:
     *Set the colors of the setting page
     */
    func setTheme(){
        //Set Default
        setDefaultView.backgroundColor = Style.darkBar
        setDefaultLabel.textColor = Style.darkText
        defaultControl.tintColor = Style.darkText
        defaultControl.backgroundColor = Style.lightBar

        //Set theme switch
        themeLabel.textColor = Style.darkText
        themeView.backgroundColor = Style.lightBar
        themeSwitch.onTintColor = Style.darkText
        
        defaultGratuityText.textColor = Style.darkText
        defaultGratuityView.backgroundColor = Style.darkBar
        
        //Sad
        sadView.backgroundColor = Style.lightBar
        sadLabel.textColor = Style.darkText
        sadIcon.image = sadIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
         sadIcon.tintColor = Style.darkText
        
        //Happy
        happyView.backgroundColor = Style.lightBar
        happyLabel.textColor = Style.darkText
        happyIcon.image = happyIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        happyIcon.tintColor = Style.darkText
        
        //LOL
        lolView.backgroundColor = Style.lightBar
        lolLabel.textColor = Style.darkText
        lolIcon.image = lolIcon.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        lolIcon.tintColor = Style.darkText
        
        //Reset
        resetView.backgroundColor = Style.darkBar
        resetButton.tintColor = Style.darkText
        
        //Slider
        sadSlider.minimumTrackTintColor = Style.darkText
        happySlider.minimumTrackTintColor = Style.darkText
        lolSlider.minimumTrackTintColor = Style.darkText
    }
    
    /* resetGratuity:
     * On button press, reset gratuity sliders to default
     */
    @IBAction func resetGratuity(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        sadSlider.setValue(10, animated: false)
        defaults.setInteger(10, forKey: "sadSlider")
        sadLabel.text = "10%"
        
        happySlider.setValue(15, animated: false)
        defaults.setInteger(15, forKey: "happySlider")
        happyLabel.text = "15%"
        
        lolSlider.setValue(20, animated: false)
        defaults.setInteger(20, forKey: "lolSlider")
        lolLabel.text = "20%"
    }
    
    //Allow user to set the default index for the segment control (faces)
    @IBAction func setDefault(sender: UISegmentedControl) {
        let tipDefault = NSUserDefaults.standardUserDefaults()
        
        switch defaultControl.selectedSegmentIndex{
            
        case 0:
            tipDefault.setValue(0, forKey: "tipDefault")
            
        case 1:
            tipDefault.setValue(1, forKey: "tipDefault")
            
        case 2:
            tipDefault.setValue(2, forKey: "tipDefault")
            
        default:
            break
        }
        
        tipDefault.synchronize()
    }

    
    //Allow user to set the theme switch
    @IBAction func toggleTheme(switchState: UISwitch) {
        let themeDefaults = NSUserDefaults.standardUserDefaults()
        
        if themeSwitch.on {
            themeDefaults.setValue("dark", forKey:"theme")
            themeDefaults.setValue(true, forKey:"switch")
        }
        
        else {
            
            themeDefaults.setValue("light", forKey:"theme")
            themeDefaults.setValue(false, forKey: "switch")
        }
        
        themeDefaults.synchronize()
        
        if themeDefaults.stringForKey("theme") == "dark"{
            Style.darkTheme()
        }
        else {Style.lightTheme()}
        self.setTheme()

    }
    
    /*
     *
     */
    @IBAction func sadSliderValueChanged(sender: UISlider) {
        sadLabel.text = "\(Int(sender.value))%"
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(Int(sender.value), forKey: "sadSlider")
        defaults.synchronize()
    }
    
    @IBAction func happySliderValueChanged(sender: UISlider) {
        happyLabel.text = "\(Int(sender.value))%"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(sender.value), forKey: "happySlider")
        defaults.synchronize()
    }
    
   
    @IBAction func lolSliderValueChanged(sender: UISlider) {
        lolLabel.text = "\(Int(sender.value))%"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(sender.value), forKey: "lolSlider")
        defaults.synchronize()
        
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
