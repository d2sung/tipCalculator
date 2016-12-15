//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Daniel Sung on 12/14/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

   
    @IBOutlet weak var defaultControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tipDefault = NSUserDefaults.standardUserDefaults()
        
        defaultControl.selectedSegmentIndex = tipDefault.integerForKey("tipDefault")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
