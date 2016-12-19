//
//  Style.swift
//  tipCalculator
//
//  Created by Daniel Sung on 12/15/16.
//  Copyright © 2016 Daniel Sung. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    //Light
    //UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
    //UIColor(red:1.00, green:0.93, blue:0.35, alpha:1.0)
    //UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
    //UIColor(red:1.00, green:0.96, blue:0.62, alpha:1.0)
    //UIColor(red:1.00, green:0.98, blue:0.77, alpha:1.0)
    
    
    
    
    //Dark
    //UIColor(red:0.47, green:0.56, blue:0.61, alpha:1.0)
    //UIColor(red:0.56, green:0.64, blue:0.68, alpha:1.0)
    //UIColor(red:0.69, green:0.75, blue:0.77, alpha:1.0)
    //UIColor(red:0.81, green:0.85, blue:0.86, alpha:1.0)
    //UIColor(red:1.00, green:0.99, blue:0.91, alpha:1.0)
    
    //Accent
    //UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
    
    //View
    static var viewBgColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
    
    //Bill
    static var billBgColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
    static var billTextColor = UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
    static var billTextDefaultColor = UIColor.grayColor()
    
    //Faces
    static var facesBgColor = UIColor(red:1.00, green:0.92, blue:0.23, alpha:1.0)
    static var facesTintColor = UIColor(red:0.25, green:0.77, blue:1.00, alpha:1.0)

    //Tip
    static var tipBgColor =  UIColor(red:1.00, green:0.93, blue:0.35, alpha:1.0)
    static var tipTextColor = UIColor(red:0.56, green:0.64, blue:0.68, alpha:1.0)

    //Total
    static var totalBgColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
    static var totalTextColor = UIColor(red:0.12, green:0.38, blue:0.38, alpha:1.0)
    
    static var splitterColor = UIColor(red:1.00, green:0.96, blue:0.62, alpha:1.0)
    
    //Settings
    static var darkBar = UIColor(red:0.71, green:0.95, blue:0.95, alpha:1.0)
    static var lightBar = UIColor(red:0.93, green:1.00, blue:0.98, alpha:1.0)
    
    static var darkText = UIColor(red:0.18, green:0.46, blue:0.50, alpha:1.0)
    static var lightText = UIColor.whiteColor()
    static var placeHolderColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
    
    static func lightTheme(){
        //View
        viewBgColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        
        //Bill
        billBgColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        billTextColor = UIColor(red:0.22, green:0.28, blue:0.31, alpha:1.0)
        billTextDefaultColor = UIColor.grayColor()
        
        //Faces
        facesBgColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        facesTintColor = UIColor(red:0.22, green:0.28, blue:0.31, alpha:1.0)
        
        //Tip
        tipBgColor =  UIColor(red:1.00, green:0.96, blue:0.62, alpha:1.0)
        tipTextColor = UIColor(red:0.18, green:0.46, blue:0.50, alpha:1.0)
        
        //Total
        totalBgColor = UIColor(red:1.00, green:0.98, blue:0.77, alpha:1.0)
        totalTextColor = UIColor(red:0.33, green:0.43, blue:0.48, alpha:1.0)
        
        splitterColor = UIColor(red:1.00, green:0.99, blue:0.91, alpha:1.0)
        
        //Settings
        darkBar = UIColor(red:1.00, green:0.96, blue:0.62, alpha:1.0)
        lightBar = UIColor(red:1.00, green:0.98, blue:0.77, alpha:1.0)
        
        darkText = UIColor(red:0.33, green:0.43, blue:0.48, alpha:1.0)
        
        lightText = UIColor.whiteColor()
        placeHolderColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0)
    }
    
    
    
    static func darkTheme(){
        
        //View
        viewBgColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        
        //Bill
        billBgColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        billTextColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        billTextDefaultColor = UIColor.grayColor()
        
        //Faces
        facesBgColor = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        facesTintColor = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        
        //Tip
        tipBgColor = UIColor(red:0.22, green:0.28, blue:0.31, alpha:1.0)
        tipTextColor = UIColor(red:0.56, green:0.64, blue:0.68, alpha:1.0)
        //Total
        totalBgColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        totalTextColor = UIColor.whiteColor()
        
        splitterColor = UIColor(red:0.33, green:0.43, blue:0.48, alpha:1.0)
        
        //Settings
        darkBar = UIColor(red:0.13, green:0.16, blue:0.19, alpha:1.0)
        lightBar = UIColor(red:0.22, green:0.28, blue:0.31, alpha:1.0)
        
        darkText = UIColor(red:1.00, green:0.95, blue:0.46, alpha:1.0)
        lightText = UIColor(red:0.22, green:0.28, blue:0.31, alpha:1.0)
        
        placeHolderColor = UIColor(red:1.00, green:0.99, blue:0.91, alpha:1.0)
    }

}
