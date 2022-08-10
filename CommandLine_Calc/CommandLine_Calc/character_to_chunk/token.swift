//
//  token.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

enum Token: Equatable {

    case add
    case divide
    case multiply
    case number(Number)
    case parenthesisLeft(negated: Bool)
    case parenthesisRight
    case subtract
    case module
    
}
