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
    
    func calculateConversion(convertFrom: Units, convertTo: Units) -> Double {
        // conversion rate variable
        var conversion: Double = 0.0
        
        var result: Double = 0.0
        
        // checking if they want to switch from inches to another unit
        if (convertFrom == .Inches && convertTo == .Feet){
            // 1 inch is 0.0833333 feet
            conversion = 0.0833333;
            result = inputNum() * conversion
        }
        else if (convertFrom == .Inches && convertTo == .Yards){
            // 1 inch is 0.0277778 yards
            conversion = 0.0277778;
            result = inputNum() * conversion
        }
        else if (convertFrom == .Inches && convertTo == .Meters){
            // 1 inch is 0.0254 meters
            conversion = 0.0254
            result = inputNum() * conversion
        }
        else if (convertFrom == .Inches && convertTo == .Centimeters){
            // 1 inch is 2.54 centimeters
            conversion = 2.54
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        
        // checking if they want to switch from Feet to another unit
        if (convertFrom == .Feet && convertTo == .Inches){
            // 1 foot is 12 inches
            conversion = 12.0
            result = inputNum() * conversion
        }
        else if (convertFrom == .Feet && convertTo == .Yards){
            // 1 foot is 0.333333 yards
            conversion = 0.333333
            result = inputNum() * conversion
        }
        else if (convertFrom == .Feet && convertTo == .Meters){
            // 1 foot is 0.3048 meters
            conversion = 0.3048
            result = inputNum() * conversion
        }
        else if (convertFrom == .Feet && convertTo == .Centimeters){
            // 1 foot is 30.48 centimeters
            conversion = 30.48
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // checking if they want to switch from Yards to another unit
        if (convertFrom == .Yards && convertTo == .Inches){
            // 1 yard is 36 inches
            conversion = 36.0
            result = inputNum() * conversion
        }
        else if (convertFrom == .Yards && convertTo == .Feet){
            // 1 yard is 3 feet
            conversion = 3.0
            result = inputNum() * conversion
        }
        else if (convertFrom == .Yards && convertTo == .Meters){
            // 1 yard is 0.9144 meters
            conversion = 0.9144
            result = inputNum() * conversion
        }
        else if (convertFrom == .Yards && convertTo == .Centimeters){
            // 1 yard is 91.44 centimeters
            conversion = 91.44
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // checking if they want to switch from centimeters to another unit
        if (convertFrom == .Centimeters && convertTo == .Inches){
            // 1 centimeter is 0.393701 inches
            conversion = 0.393701
            result = inputNum() * conversion
        }
        else if (convertFrom == .Centimeters && convertTo == .Feet){
            // 1 centimeter is 0.0328084 feet
            conversion = 0.0328084
            result = inputNum() * conversion
        }
        else if (convertFrom == .Centimeters && convertTo == .Meters){
            // 1 centimeter is 0.01 meters
            conversion = 0.01
            result = inputNum() * conversion
        }
        else if (convertFrom == .Centimeters && convertTo == .Yards){
            // 1 centimeter is 0.0109361 yards
            conversion = 0.0109361
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // checking if they want to switch from cups to another unit
        if (convertFrom == .Cups && convertTo == .Pints){
            // 1 cup is 0.5 pints
            conversion = 0.5
            result = inputNum() * conversion
        }
        else if (convertFrom == .Cups && convertTo == .Quarts){
            // 1 cup is 0.25 quarts
            conversion = 0.25
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // checking if they want to switch from pints to another unit
        if (convertFrom == .Pints && convertTo == .Cups){
            // 1 pint is 2 cups
            conversion = 2
            result = inputNum() * conversion
        }
        else if (convertFrom == .Cups && convertTo == .Quarts){
            // 1 pint is 0.5 quarts
            conversion = 0.5
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // checking if they want to switch from quarts to another unit
        if (convertFrom == .Quarts && convertTo == .Pints){
            // 1 quart is 2 pints
            conversion = 2
            result = inputNum() * conversion
        }
        else if (convertFrom == .Quarts && convertTo == .Cups){
            // 1 quart is 4 cups
            conversion = 4
            result = inputNum() * conversion
        }
        // invalid conversion
        else {
            return 0.0
        }
        
        // return the conversion
        return result
    }
}

//let model = IOSCOnverter(convertFrom: Units.Feet, convertTo: Units.Inches)
//model.append(digit: 1, field: .MainBox)
//model.append(digit: 0, field: .MainBox)
//model.append(digit: 9, field: .MainBox)
//model.append(digit: 5, field: .Num)
//model.append(digit: 6, field: .Denom)
//print(model.inputNum())

