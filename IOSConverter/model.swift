//
//  model.swift
//  IOSConverter
//
//  Created by Jeremy Gonzalez on 10/3/17.
//  Copyright © 2017 Team 4A. All rights reserved.
//

import Foundation

// A few units to get started with, I can't find all of the ones we need to support
enum Units {
    case Feet, Inches, Yards, Meters, Centimeters, Cups, Pints, Quarts
}

// For handling text / decimal operations with the same helper funcs
enum Field {
    case MainBox, Num, Denom
}

class IOSCOnverter {
    var mainText : String
    var convertFrom : Units
    var convertTo : Units
    var num: String
    var denom: String
    
    init(convertFrom: Units, convertTo: Units) {
        mainText = ""
        num = ""
        denom = ""
        self.convertFrom = convertFrom
        self.convertTo = convertTo
    }
    
    // Need to add checks that denom is not 0 / is entered and that we're unwrapping properly
    func inputNum() -> Double {
        if(decimalPresent()){
            return Double(mainText) ?? 0.0
        }else{
            return Double(mainText)! +  Double(Double(num)! / Double(denom)!)
        }
    }
    
    //UI setter only set
    func setConvertFrom(unit: Units){
        self.convertFrom = unit
    }
    
    //UI setter
    func setConvertTo(unit: Units){
        self.convertTo = unit
    }
    
    //UI uses this to enable / disable fraction UI elements
    func decimalPresent() -> Bool {
        if(mainText.contains(".")){
            return true
        }
        else{
            return false
        }
    }
    
    func appendDecimal() {
        
        guard !mainText.contains(".") else { return }
        
        if mainText.isEmpty {
            mainText += "0."
        } else {
            mainText += "."
        }
    }
    
    func append(digit: Int, field: Field) {
        if(field == Field.MainBox){
            mainText += String(digit)
        }else if(field == Field.Denom){
            denom += String(digit)
        }else{
            num += String(digit)
        }
    }
    
    func clearInput(field: Field) {
        if(field == Field.MainBox){
            mainText = ""
        }else if(field == Field.Denom){
            denom = ""
        }else{
            num = ""
        }
    }
}

//let model = IOSCOnverter(convertFrom: Units.Feet, convertTo: Units.Inches)
//model.append(digit: 1, field: .MainBox)
//model.append(digit: 0, field: .MainBox)
//model.append(digit: 9, field: .MainBox)
//model.append(digit: 5, field: .Num)
//model.append(digit: 6, field: .Denom)
//print(model.inputNum())

