//
//  operationizer.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// Creates nested arrays of operations by categorizing tokens.
final class Operationizer {

    static func createOperations(fromTokens tokens: [Token]) -> CalcResult<[Operation]> {
        let operationizer = Operationizer(tokenIterator: tokens.makeIterator())
        let operations = operationizer.createOperations()
        return .value(operations)
    }

    private init(tokenIterator: IndexingIterator<[Token]>) {
        self.tokenIterator = tokenIterator
    }

    private var tokenIterator: IndexingIterator<[Token]>

    private func createOperations() -> [Operation] {
        var operations = [Operation]()
        while let token = tokenIterator.next() {
            if let operation = createOperation(for: token) {
                operations.append(operation)
            }
            else {
                return operations
            }
        }
        return operations
    }

    private func createOperation(for token: Token) -> Operation? {
        switch token {
        case .add:                return .binaryOperator(.add)
        case .divide:             return .binaryOperator(.divide)
        case .multiply:           return .binaryOperator(.multiply)
        case .subtract:           return .binaryOperator(.subtract)
        case .module:               return .binaryOperator(.module)
        case .number(let number): return .operand(.number(number))
        case .parenthesisLeft(let negated):
            let operations = createOperations()
            return .operand(.parenthesizedOperations(operations, negated: negated))
        case .parenthesisRight:
            return nil
        }
    }

}
