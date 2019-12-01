//
//  main.swift
//  AdventOfCode2019_Day1
//
//  Created by Marcus Kida on 01.12.19.
//  Copyright © 2019 Bearologics UG (haftungsbeschränkt). All rights reserved.
//

import Foundation

var input = """
88093
102524
75875
62024
86072
106670
105440
51371
148951
123704
92364
50848
117125
95022
131085
129886
145084
123077
69219
84366
51344
65604
140383
53606
132685
83550
76648
120937
137498
84167
94438
54178
106306
80802
98524
70214
114108
118782
75444
76449
144233
56747
93663
137969
99981
110442
106873
93708
114085
53655
78096
137640
50775
72563
135043
146136
147244
105601
106293
63048
104864
93044
118222
107110
92725
57424
94602
87898
51668
137651
55070
67255
103823
83059
61150
82029
56060
56702
85486
114522
94121
104870
53014
111776
63615
78378
113830
80059
123427
73545
93688
122410
93174
131464
137014
114304
138703
54128
111698
84299
"""

func computeFuelRequirement(_ mass: Int) -> Int {
    let fuelRequired = Int(floor(Double(mass / 3)) - 2)
    guard fuelRequired >= 0 else {
        return 0
    }
    return fuelRequired
}

let modules = input.components(separatedBy: "\n").compactMap { Int($0) }

var masses = [Int]()

modules.forEach { module in
    let fuel = computeFuelRequirement(module)
    var totalFuel = fuel
    var lastFuel = fuel
    var computeFuel = true
    while computeFuel {
        let computed = computeFuelRequirement(lastFuel)
        if computed == 0 {
            computeFuel = false
        } else {
            totalFuel += computed
            lastFuel = computed
        }
    }
    masses.append(totalFuel)
}

print(masses)

let totalFuel: Int = masses.reduce(0) { $0 + $1 }

print(totalFuel)

