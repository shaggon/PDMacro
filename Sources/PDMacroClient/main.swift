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
