//
//  unit_tests.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

func runUnitTests() {
    CalcUnitTest(
        input: "1 + 2 * 3",
        glyphs: [
            .digit("1"),
            .whitespace,
            .add,
            .whitespace,
            .digit("2"),
            .whitespace,
            .multiply,
            .whitespace,
            .digit("3")],
        tokens: [
            .number(.int(1)),
            .add,
            .number(.int(2)),
            .multiply,
            .number(.int(3))],
        operations: [
            .operand(.number(.int(1))),
            .binaryOperator(.add),
            .operand(.number(.int(2))),
            .binaryOperator(.multiply),
            .operand(.number(.int(3)))],
        expression:
        .add(
            .number(.int(1)),
            .multiply(.number(.int(2)),
                      .number(.int(3)))),
        result: .value(.int(7)))
        .runUnitTests()

}
