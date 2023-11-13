import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import PDMacroMacros
import PDMacro

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(PDMacroMacros)
import PDMacroMacros

let testMacros: [String: Macro.Type] = [
    "CaseDetection": CaseDetectionMacro.self,
]
#endif

final class PDMacroTests: XCTestCase {
    
    func testCaseDetectionSource() throws {
#if canImport(PDMacroMacros)
        assertMacroExpansion(
      """
      @CaseDetection
      enum Animal {
        case dog
        case cat(curious: Bool)
      }
      """,
      expandedSource: """
        enum Animal {
          case dog
          case cat(curious: Bool)
        
          var isDog: Bool {
            if case .dog = self {
              return true
            }
        
            return false
          }
        
          var isCat: Bool {
            if case .cat = self {
              return true
            }
        
            return false
          }
        }
        """,
      macros: testMacros,
      indentationWidth: .spaces(2)
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testCaseDetectionCoding() throws {
#if canImport(PDMacroMacros)
        @CaseDetection
        enum Animal {
            case dog
            case cat(curious: Bool)
        }

        XCTAssertEqual(Animal.dog.isDog, true)
        XCTAssertEqual(Animal.dog.isCat, false)
        XCTAssertEqual(Animal.cat(curious: true).isDog, false)
        XCTAssertEqual(Animal.cat(curious: false).isCat, true)
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
