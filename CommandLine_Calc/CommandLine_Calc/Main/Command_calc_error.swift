//
//  Command_calc_error.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// All errors that can be thrown by the calculation pipeline.

enum CalcError: Error, Equatable {

    case cannotProcessEmptyExpression
    case cannotProcessSingleOperator
    case divideByZero
    case invalidOperationCount
    case malformedInput
    case missingLeftOperand
    case missingOperator
    case missingRightOperand
    case multipleDecimalSeparators
    case unexpectedCharacter(at: Int)

    var message: String {
        switch self {
        case .cannotProcessEmptyExpression:      return "Cannot process empty expression."
        case .cannotProcessSingleOperator:       return "Cannot process only an operator."
        case .divideByZero:                      return "Division by zero is not allowed."
        case .invalidOperationCount:             return "Insufficient number of operators/operands."
        case .malformedInput:                    return "Malformed input."
        case .missingLeftOperand:                return "Missing a left operand."
        case .missingOperator:                   return "Missing an operator."
        case .missingRightOperand:               return "Missing a right operand."

        case .multipleDecimalSeparators:         return "Number cannot have multiple decimal separators."
        case .unexpectedCharacter(let position): return "Unexpected character at position \(position)."
        }
    }
}
