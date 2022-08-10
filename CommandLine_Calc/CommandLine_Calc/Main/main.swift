//
//  main.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation
import Darwin


print("|---------------------------------------------------------|")
print("|                                                         |")
print("|                                                         |")
print("|          Welcome to Command-line Calculetor             |")
print("|                                                         |")
print("|                                                         |")
print("|---------------------------------------------------------|")
print("                                                           ")

print("Please enter an input:- ")


let isTesting = true

func calculate(_ input: String) -> CalcResult<Number> {
    return InputParser.createGlyphs(from: input)
        .then(Tokenizer.createTokens(fromGlyphs:))
        .then(Operationizer.createOperations(fromTokens:))
        .then(Expressionizer.createExpression(fromOperations:))
        .then(Calculator.evaluate(expression:))
}

//Get Input from user
func input() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,encoding:String.Encoding.utf8.rawValue)! as String
    return
        result.trimmingCharacters(in: .whitespacesAndNewlines)
}

let inputValue = input()


//pass input to calculate the output
switch calculate(inputValue) {
case .value(let number):
    print("                                                           ")
    print("|---------------------------------------------------------|")
    print(" ")
    print(" your enter input is :      \(inputValue) ")
    print(" ")
    print(" And output Is :      \(number)")
    print(" ")
    print("|---------------------------------------------------------|")
    print("                                                           ")
case .error(let error):  print(error.message)
}

if isTesting {
    runUnitTests()
    print("Unit tests passed.")
    runIntegrationTests()
    print("Integration tests passed.")
}
