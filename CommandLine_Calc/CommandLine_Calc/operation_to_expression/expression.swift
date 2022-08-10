//
//  expression.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation


indirect enum Expression: Equatable {

    // Initial value
    case empty

    // Leaf node
    case number(Number)

    // Branch nodes
    case add(Expression, Expression)
    case divide(Expression, Expression)
    case multiply(Expression, Expression)
    case subtract(Expression, Expression)
    case module(Expression, Expression)
    
}
