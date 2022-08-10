//
//  tokenizer.swift
//  CommandLine_Calc
//
//  Created by Vivek's Mac on 13/03/20.
//  Copyright © 2020 Vivek's Mac. All rights reserved.
//

import Foundation

// Produces an array of tokens by concatenating and categorizing glyphs.
final class Tokenizer {

    static func createTokens(fromGlyphs glyphs: [Glyph]) -> CalcResult<[Token]> {
        do {
            let tokenizer = Tokenizer()
            let tokens = try tokenizer.tokenize(glyphs).validated()
            return .value(tokens)
        }
        catch let calcError as CalcError {
            return .error(calcError)
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }

    private init() {}

    private let decimalPointScalar: UnicodeScalar = "."
    private var tokens = [Token]()

    private enum Disposition {
        case anything
        case int([UnicodeScalar])
        case double([UnicodeScalar])
        case negation
    }

    private func tokenize(_ glyphs: [Glyph]) throws -> [Token] {
        let disposition = try glyphs.reduce(.anything, process(disposition:withGlyph:))
        switch disposition {
        case .anything:            break
        case .int(let scalars):    finishProcessingInt(with: scalars)
        case .double(let scalars): finishProcessingDouble(with: scalars)
        case .negation:            throw CalcError.malformedInput
        }
        return tokens
    }

    private func process(disposition: Disposition, withGlyph glyph: Glyph) throws -> Disposition {
        switch disposition {
        case .anything:            return     processAnything(with: glyph)
        case .int(let scalars):    return     processInt(with: glyph, scalars: scalars)
        case .double(let scalars): return try processDouble(with: glyph, scalars: scalars)
        case .negation:            return try processNegation(with: glyph)
        }
    }

    private func processAnything(with glyph: Glyph) -> Disposition {
        switch glyph {
        case .digit(let scalar):                                                 return .int([scalar])
        case .whitespace:                                                        return .anything
        case .add:              tokens.append(.add);                             return .anything
        case .divide:           tokens.append(.divide);                          return .anything
        case .multiply:         tokens.append(.multiply);                        return .anything
        case .module:     tokens.append(.module);
            return .anything
        case .subtractOrNegate:
            if tokens.isEmpty || tokens.last?.canPrecedeNegation == true {
                return .negation
            }
            else {
                tokens.append(.subtract)
                return .anything
            }
        }
    }

    private func processInt(with glyph: Glyph, scalars: [UnicodeScalar]) -> Disposition {
        switch glyph {
        case .digit(let scalar): return .int(scalars + [scalar])
        default:
            finishProcessingInt(with: scalars)
            return processAnything(with: glyph)
        }
    }

    private func processDouble(with glyph: Glyph, scalars: [UnicodeScalar]) throws -> Disposition {
        switch glyph {
        case .digit(let scalar): return .double(scalars + [scalar])
        default:
            finishProcessingDouble(with: scalars)
            return processAnything(with: glyph)
        }
    }

    private func processNegation(with glyph: Glyph) throws -> Disposition {
        switch glyph {
    
        case .digit(let scalar): return .int(["-", scalar])
        case .whitespace:        return .negation
        default:                 throw CalcError.malformedInput
        }
    }

    private func finishProcessingInt(with scalars: [UnicodeScalar]) {
        let stringValue = String.joining(unicodeScalars: scalars)
        guard let intValue = Int(stringValue) else { fatalError() }
        tokens.append(.number(.int(intValue)))
    }

    private func finishProcessingDouble(with scalars: [UnicodeScalar]) {
        let stringValue = String.joining(unicodeScalars: scalars)
        guard let doubleValue = Double(stringValue) else { fatalError() }
        tokens.append(.number(.double(doubleValue)))
    }

}

private extension Token {

    var canPrecedeNegation: Bool {
        switch self {
        case .add, .divide, .multiply, .subtract, .module , .parenthesisLeft: return true
        case .number, .parenthesisRight: return false
        }
    }

}

private extension String {

    static func joining(unicodeScalars: [UnicodeScalar]) -> String {
        return unicodeScalars.map(String.init(_:)).joined()
    }

}
