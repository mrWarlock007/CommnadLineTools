//
//  InputParser.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// Scans a string to produce an array of glyphs.
enum InputParser  {

    static func createGlyphs(from string: String) -> CalcResult<[Glyph]> {
        var glyphs = [Glyph]()
        for scalarIndex in string.unicodeScalars.indices {
            if let glyph = parseGlyph(at: scalarIndex, in: string) {
                glyphs.append(glyph)
            }
            else {
                return .error(.unexpectedCharacter(at: scalarIndex.utf16Offset(in: string)))
            }
        }
        return .value(glyphs)
    }

    private static func parseGlyph(at index: String.UnicodeScalarIndex, in string: String) -> Glyph? {
        enum CharacterSets {
            static let add              = CharacterSet(charactersIn: "+")
            static let decimalSeparator = CharacterSet(charactersIn: ".")
            static let digit            = CharacterSet.decimalDigits
            static let divide           = CharacterSet(charactersIn: "/")
            static let module           = CharacterSet(charactersIn: "%")
            static let multiply         = CharacterSet(charactersIn: "*xX")
            static let subtractOrNegate = CharacterSet(charactersIn: "-")
            static let whitespace       = CharacterSet.whitespacesAndNewlines
        }
        let scalar = string.unicodeScalars[index]
        if CharacterSets.add.contains(scalar)              { return .add }
        if CharacterSets.digit.contains(scalar)            { return .digit(scalar) }
        if CharacterSets.divide.contains(scalar)           { return .divide }
        if CharacterSets.multiply.contains(scalar)         { return .multiply }
        if CharacterSets.module.contains(scalar)         { return .module }

        if CharacterSets.subtractOrNegate.contains(scalar) { return .subtractOrNegate }
        if CharacterSets.whitespace.contains(scalar)       { return .whitespace }
        return nil
    }

}
