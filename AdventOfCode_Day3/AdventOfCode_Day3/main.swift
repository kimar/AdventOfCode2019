//
//  main.swift
//  AdventOfCode_Day3
//
//  Created by Marcus Kida on 03.12.19.
//  Copyright © 2019 Bearologics UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

typealias Line = String
typealias Coordinate = [Int]
typealias Coordinates = [Coordinate]

typealias Map = [[Character]]

let input = """
R8,U5,L5,D3
U7,R6,D4,L4
"""

let lines = input.components(separatedBy: .newlines)

print("Number of lines: \(lines.count)")

enum Direction: Character {
    case right = "R"
    case left = "L"
    case up = "U"
    case down = "D"
}

func convertToPoints(line: Line) -> Coordinates {
    var lastPosition = [0, 0]
    return line.components(separatedBy: ",").map { piece in
        var x = lastPosition[0]
        var y = lastPosition[1]
        
        guard
            let first = piece.first,
            let last = piece.last,
            let direction = Direction(rawValue: first),
            let steps = Int("\(last)")
        else {
            fatalError("Invalid instruction at piece: \(piece)")
        }
        
        switch direction {
        case .right:
            x += steps
        case .left:
            x -= steps
        case .up:
            y += steps
        case .down:
            y -= steps
        }
        
        lastPosition = [x, y]
        return lastPosition
    }
}

func convertToMap(coordinates: Coordinates) -> Map {
    var map = Map()
    var mapWidth = 0
    var cursorPosition = [0, 0]
    
    for coordinate in coordinates {
        let x = coordinate[0]
        let y = coordinate[1]
                
        if x > mapWidth {
            mapWidth = x + 1
        }
        
        if map.count > y {
            var line = map[y]
                        
            if line[x] == "*" {
                line[x] = "X"
            } else {
                line[x] = "*"
            }
            
            map[y] = line
            
        } else {
            var line = [Character]()
            
            while line.count < mapWidth {
                line += "."
            }
            
            line[x] = "*"
            
            map.append(line)
        }
        
        print("loop", y)
        print("map", map)
        cursorPosition = [x, y]

    }
    
    return map
}

print("points:", convertToPoints(line: lines[0]))
print("map:", convertToMap(coordinates: convertToPoints(line: lines[0])))
