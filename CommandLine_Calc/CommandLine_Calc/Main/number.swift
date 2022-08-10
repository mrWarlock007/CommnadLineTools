//
//  number.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// A numeric value with a whole or fractional value.
enum Number: Equatable, CustomDebugStringConvertible {

    case int(Int)
    case double(Double)

    var debugDescription: String {
        switch self {
        case .int(let intValue):
            return String(intValue)
        case .double(let doubleValue):
            // Avoid printing decimal places for a whole number.
            if doubleValue.rounded() == doubleValue {
                let intValue = Int(doubleValue)
                return Number.int(intValue).debugDescription
            }
            else {
                return String(doubleValue)
            }
        }
    }
    
}
