//
//  convertTOCharacter.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

enum Glyph: Equatable, CustomDebugStringConvertible {

    case add
    case digit(UnicodeScalar)
    case divide
    case multiply
    case subtractOrNegate
    case whitespace
    case module

    var debugDescription: String {
        switch self {
        case .add:               return "+"
        case .digit(let scalar): return String(scalar)
        case .divide:            return "/"
        case .multiply:          return "*"
        case .subtractOrNegate:  return "-"
        case .module:  return "%"
        case .whitespace:        return " "
        }
    }

}
