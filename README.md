# PDMacro

## What is PDMacro?
PDMacro is a swift Macro Foundation which includ all swift Macros make by team.

## How to contribute new swift macro?
1. Create new Macro implementation code in Sources/PDMacroMacros
2. Create macro interface in Sources/PDMacro/PDMacro.swift 
3. Create test code in Sources/PDMacroClient/main.swift
4. Create UT in Tests/PDMacroTests/PDMacroTests.swift

## Example Usage (CaseDetectionMacro)
```
import PDMacro

@CaseDetection
enum Animal {
  case dog
  case cat(curious: Bool)
}

print("\(Animal.dog.isDog)")
print("\(Animal.dog.isCat)")
print("\(Animal.cat(curious: true).isDog)")
print("\(Animal.cat(curious: false).isCat)")
```