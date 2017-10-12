//
//  model.swift
//  IOSConverter
//
//  Created by Jeremy Gonzalez on 10/3/17.
//  Copyright © 2017 Team 4A. All rights reserved.
//

import Foundation

// For handling text / decimal operations with the same helper funcs
enum Field {
    case MainBox, Num, Denom
}

struct InputConverter {
    var unit: String
    var conversion: (Double) -> Double
}

struct OutputConvertor {
    var unit: String
    var conversion: (Double) -> Double
}

class IOSCOnverter {
    var mainText : String
    var convertFrom : InputConverter
    var convertTo : OutputConvertor
    var num: String
    var denom: String
    
    let distanceToMeters: [InputConverter] = [
        InputConverter(unit: "feet", conversion: { (input) -> Double in
            return input * 0.3048
        }),
        InputConverter(unit: "inches", conversion: { (input) -> Double in
             return input * 0.0254
        }),
        InputConverter(unit: "yards", conversion: { (input) -> Double in
            return input * 0.9144
        }),
        InputConverter(unit: "centimeters", conversion: { (input) -> Double in
            return input * 0.01
        }),
        InputConverter(unit: "meters", conversion: { (input) -> Double in
            return input
        }) ]
    
    let metersToDistance: [OutputConvertor] = [
        OutputConvertor(unit: "feet", conversion: { (input) -> Double in
            return input / 0.3048
        }),
        OutputConvertor(unit: "inches", conversion: { (input) -> Double in
            return input / 0.0254
        }),
        OutputConvertor(unit: "yards", conversion: { (input) -> Double in
            return input / 0.9144
        }),
        OutputConvertor(unit: "centimeters", conversion: { (input) -> Double in
            return input / 0.01
        }),
        OutputConvertor(unit: "meters", conversion: { (input) -> Double in
            return input
        })
    ]
    
    let volumeToCups: [InputConverter] = [
        InputConverter(unit: "pints", conversion: { (input) -> Double in
            return input * 2
        }),
        InputConverter(unit: "quarts", conversion: { (input) -> Double in
            return input * 8
        }),
        InputConverter(unit: "cups", conversion: { (input) -> Double in
            return input
        })
    ]
    
    let cupsToVolume: [OutputConvertor] = [
        OutputConvertor(unit: "pints", conversion: { (input) -> Double in
            return input / 2
        }),
        OutputConvertor(unit: "quarts", conversion: { (input) -> Double in
            return input / 8
        }),
        OutputConvertor(unit: "cups", conversion: { (input) -> Double in
            return input
        })
    ]
    
    init(convertFrom: InputConverter, convertTo: OutputConvertor) {
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
    
    func negateInput() -> Double{
        return inputNum() * -1
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
    
    func calculateConversion(convertFrom input: InputConverter, convertTo output: OutputConvertor) -> Double {
        // conversion rate variable
        return output.conversion(input.conversion(self.inputNum()))
    }
 
}

//let model = IOSCOnverter(convertFrom: Units.Feet, convertTo: Units.Inches)
//model.append(digit: 1, field: .MainBox)
//model.append(digit: 0, field: .MainBox)
//model.append(digit: 9, field: .MainBox)
//model.append(digit: 5, field: .Num)
//model.append(digit: 6, field: .Denom)
//print(model.inputNum())

