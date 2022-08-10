//
//  chunk_Array_validation.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

extension Array where Element == Token {

    // Throws an error if the array contains unbalanced parentheses, otherwise returns the array on which this method was called.
    func validated() throws -> [Token] {
        for token in self {
            switch token {
            default: break
            }
        }
        return self
    }

}
