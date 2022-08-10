//
//  expression_combining.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

extension Expression {

    // Arranges the expressions into a tree honoring arithemtic's order of operations.
    static func combine(_ expressions: [Expression]) throws -> Expression {
        return try expressions.reduce(.empty, combine(current:withNext:))
    }

    private static func combine(current: Expression, withNext next: Expression) throws -> Expression {
        if case .empty = current { return next }
        guard
            let currentRightExpression = current.rightExpression,
            let currentPrecedence      = current.precedence,
            let nextPrecedence         = next.precedence
            else { throw CalcError.malformedInput }
        if currentPrecedence < nextPrecedence {
            let splicedRight = next.replacingLeftExpression(with: currentRightExpression)
            return current.replacingRightExpression(with: splicedRight)
        }
        else {
            return next.replacingLeftExpression(with: current)
        }
    }

    private var rightExpression: Expression? {
        switch self {
        case let .add(_,      right): return right
        case let .divide(_,   right): return right
        case let .multiply(_, right): return right
        case let .subtract(_, right): return right
        case .empty, .number:         return nil
        case let .module(_, right):return right
        }
    }

    private func replacingLeftExpression(with left: Expression) -> Expression {
        switch self {
        case .add(     _, let right): return .add(     left, right)
        case .divide(  _, let right): return .divide(  left, right)
        case .multiply(_, let right): return .multiply(left, right)
        case .subtract(_, let right): return .subtract(left, right)
        case .empty, .number:         fatalError()
        case .module(_, let right):
            return .module(left, right)
        }
    }

    private func replacingRightExpression(with right: Expression) -> Expression {
        switch self {
        case .add(     let left, _): return .add(     left, right)
        case .divide(  let left, _): return .divide(  left, right)
        case .multiply(let left, _): return .multiply(left, right)
        case .subtract(let left, _): return .subtract(left, right)
        case .empty, .number:        fatalError()
        case .module(let left, _): return .module(left, right)
        }
    }

    private var precedence: Precedence? {
        switch self {
        case .add, .subtract:    return .addOrSubtract
        case .multiply, .divide: return .multiplyOrDivide
        case .empty, .number:    return nil
        case .module: return .module
        }
    }

    private enum Precedence: Int, Comparable {
        case addOrSubtract, multiplyOrDivide,module
        static func < (lhs: Precedence, rhs: Precedence) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }

}
