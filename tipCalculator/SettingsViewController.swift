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
        
        defaults.synchronize()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTheme(){
        //Set Default
        setDefaultView.backgroundColor = Style.lightBar
        setDefaultLabel.textColor = Style.darkText
        
        //Set theme switch
        themeLabel.textColor = Style.darkText
        themeView.backgroundColor = Style.darkBar
        
        defaultGratuityText.textColor = Style.darkText
        defaultGratuityView.backgroundColor = Style.lightBar
        
        //Sad
        sadView.backgroundColor = Style.lightBar
        //sadIcon.tintColor =
        sadLabel.textColor = Style.darkText
        
        //Happy
        happyView.backgroundColor = Style.lightBar
        //happyIcon.tintColor =
        happyLabel.textColor = Style.darkText
        
        //LOL
        lolView.backgroundColor = Style.lightBar
        //lolIcon.tintColor =
        lolLabel.textColor = Style.darkText
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
