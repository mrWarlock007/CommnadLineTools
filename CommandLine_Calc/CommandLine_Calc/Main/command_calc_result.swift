//
//  command_calc_result.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

/// The outcome of performing a step in the calculation pipeline.
enum CalcResult<Value: Equatable>: Equatable {

    case value(Value)
    case error(CalcError)

    func then<NextValue>(_ produceNextResult: (Value) -> CalcResult<NextValue>) -> CalcResult<NextValue> {
        switch self {
        case .value(let value): return produceNextResult(value)
        case .error(let error): return .error(error)
        }
    }
    
}
