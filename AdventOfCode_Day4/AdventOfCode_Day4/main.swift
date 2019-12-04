//
//  main.swift
//  AdventOfCode_Day4
//
//  Created by Marcus Kida on 04.12.19.
//  Copyright © 2019 Bearologics UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

func findMatchingNumbers(in range: ClosedRange<Int>) -> [Int] {
    var validNumbers = [Int]()
    for number in range {
        var previousChar: Character?
        var foundDouble = false
        var decreases = false
        
        for char in String(number) {
            if
                !foundDouble,
                let prev = previousChar,
                char == prev
            {
                foundDouble = true
            }
            
            if
                let prev = previousChar,
                let prevInt = Int("\(prev)"),
                let charInt = Int("\(char)"),
                prevInt > charInt
            {
                decreases = true
                break
            }
            
            previousChar = char
        }
        
        if foundDouble && !decreases {
            validNumbers.append(number)
        }
        
    }
    return validNumbers
}

let numbers = findMatchingNumbers(in: 372304...847060)

print("numbers", numbers)
print("numbers count", numbers.count)
