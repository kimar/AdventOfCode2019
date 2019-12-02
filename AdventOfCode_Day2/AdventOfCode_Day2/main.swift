//
//  main.swift
//  AdventOfCode_Day2
//
//  Created by Marcus Kida on 02.12.19.
//  Copyright © 2019 Bearologics UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

typealias ProgramState = [Int]
typealias Operation = (Int, Int) -> Int

let initial = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,9,19,23,1,13,23,27,1,5,27,31,2,31,6,35,1,35,5,39,1,9,39,43,1,43,5,47,1,47,5,51,2,10,51,55,1,5,55,59,1,59,5,63,2,63,9,67,1,67,5,71,2,9,71,75,1,75,5,79,1,10,79,83,1,83,10,87,1,10,87,91,1,6,91,95,2,95,6,99,2,99,9,103,1,103,6,107,1,13,107,111,1,13,111,115,2,115,9,119,1,119,6,123,2,9,123,127,1,127,5,131,1,131,5,135,1,135,5,139,2,10,139,143,2,143,10,147,1,147,5,151,1,151,2,155,1,155,13,0,99,2,14,0,0]

var input = initial

var multiply: Operation  = (*)
var add: Operation = (+)

enum Opcode: Int {    
    case addition = 1
    case multiplication = 2
    case termination = 99
}

func operation(for opcode: Opcode) -> Operation {
    switch opcode {
    case .addition:
        return add
    case .multiplication:
        return multiply
    default:
        fatalError("Invalid Opcode for Operation")
    }
}

func run(_ input: ProgramState, _ position: Int = 0) -> ProgramState {
    var output = input
    
    guard let opcode = Opcode(rawValue: input[position]) else {
        fatalError("Invalid Opcode")
    }
    
    switch opcode {
    case .termination:
        return output
    case .addition, .multiplication:
        output[input[position + 3]]
            = operation(for: opcode)(
                input[input[position + 1]],
                input[input[position + 2]]
        )
        return run(output, position + 4)
    }
}

//input[1] = 12
//input[2] = 2

//let output = run(input)

//print("final program state", output)

//print("result part 1", output[0])

//
// Part 2
//

input = initial

input[1] = 12
input[2] = 2

//let outputPart2 = run(input)

//print("result part 2", outputPart2[0])

var noun = 76
var verb = 10

var flipNoun = false

while run(input)[0] <= 19690720 {
    let out = run(input)[0]
    
    print("output[0]", out)
    
    input[1] = noun
    input[2] = verb

    print("noun", noun)
    print("verb", verb)
    
    if flipNoun {
        noun += 1
    } else {
        verb += 1
    }
    
    flipNoun = !flipNoun
}

//
// Solution:
// var noun = 76
// var verb = 10

print("Solution: \(100 * noun * verb)")
