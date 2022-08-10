//
//  operation.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// A value represents either an operator or operand in a calculation.
indirect enum Operation: Equatable {

    case binaryOperator(BinaryOperator)
    enum BinaryOperator: Equatable {
        case add, divide, multiply, subtract,module
    }

    case operand(Operand)
    enum Operand: Equatable {
        case number(Number)
        case parenthesizedOperations([Operation], negated: Bool)
    }
    
}
