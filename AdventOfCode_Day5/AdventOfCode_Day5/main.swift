//
//  main.swift
//  AdventOfCode_Day5
//
//  Created by Marcus Kida on 05.12.19.
//  Copyright © 2019 Bearologics UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

typealias ProgramState = [Int]
typealias Operation = (Int, Int) -> Int

let initial = [1002,4,3,4,33]

var inputProgram = initial

var multiply: Operation  = (*)
var add: Operation = (+)
var terminate: Operation = { _, _ in
    exit(0)
}

var inputFunc: Operation = { _, _ in
    print("Input please:")
    guard let inp = readLine() else {
        return 0
    }
    return Int(inp) ?? 0
}

var outputFunc: Operation = { param, _ in
    print("Output please ->", param)
    return param
}

enum Opcode: Int {
    case addition = 1
    case multiplication = 2
    case input = 3
    case output = 4
    case termination = 99
    
    var operation: Operation {
        switch self {
        case .addition:
            return add
        case .multiplication:
            return multiply
        case .input:
            return inputFunc
        case .output:
            return outputFunc
        case .termination:
            return terminate
        }
    }
}

typealias OpcodeAndModes = (opcode: Opcode, modes: [Int])

func splitOpcodeAndParameterModes(opcode: Int) -> OpcodeAndModes {
    let opcodeString = String("\(opcode)")
    
    func opc() -> Int {
        let opc = opcodeString.dropFirst(opcodeString.count - 2)
        return Int("\(opc)") ?? 0
    }
    
    let modes = opcodeString.dropLast(2)/*.reversed()*/.compactMap { Int("\($0)") }
    
    guard
        let opcode = Opcode(rawValue: opc())
    else {
        fatalError("Could not determine opcode")
    }
    
    return (opcode: opcode, modes: modes)
    
}

func run(_ input: ProgramState, _ position: Int = 0) -> ProgramState {
    var output = input
    
    let opcodeAndModes = splitOpcodeAndParameterModes(opcode: input[position])
    
    let opcode = opcodeAndModes.opcode
    let opmodes = opcodeAndModes.modes
    
    switch opcode {
    case .termination:
        return output
    case .addition, .multiplication:
        let outputValue = opmodes[3] == 0 ?
        output[input[position + 3]]
            = opcode.operation(
                input[input[position + 1]],
                input[input[position + 2]]
        )
        return run(output, position + 4)
    case .input:
        output[input[position + 1]] = opcode.operation(0, 0)
        return run(output, position + 4)
    case .output:
        let _ = opcode.operation(output[input[position + 1]], 0)
        return run(output, position + 4)
    }
}



//input[1] = 12
//input[2] = 2

let output = run(inputProgram)

print("final program state", output)

//print("result part 1", output[0])

//
// Part 2
//

//inputProgram = initial
//
//inputProgram[1] = 12
//inputProgram[2] = 2

//let outputPart2 = run(input)

//print("result part 2", outputPart2[0])

//var noun = 76
//var verb = 10
//
//var flipNoun = false
//
//while run(inputProgram)[0] <= 19690720 {
//    let out = run(inputProgram)[0]
//
//    print("output[0]", out)
//
//    inputProgram[1] = noun
//    inputProgram[2] = verb
//
//    print("noun", noun)
//    print("verb", verb)
//
//    if flipNoun {
//        noun += 1
//    } else {
//        verb += 1
//    }
//
//    flipNoun = !flipNoun
//}

//
// Solution:
// var noun = 76
// var verb = 10

//print("Solution: \(100 * noun * verb)")
