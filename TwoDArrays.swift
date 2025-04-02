//  TwoDArrays.swift
// The 2DArrays program reads from 2 files.
//  It scans the file and puts the content into an array of string .
//  Then calls the generate mark function.
//  Which fills a 2d array with random numbers as strings.
//  Then displays the 2d array.in a CSV file.

//  Version 1.0
//  Copyright (c) 2025 Val I. All rights reserved.

import Foundation

// Function to generate a 2D array of random numbers as strings
func generateMarks(_ rows: [String], _ columns: [String]) -> [[String]] {
    // get array length
    let rowsNum = rows.count
    let colsNum = columns.count 
    var marksArray = Array(repeating: Array(repeating: "", count: colsNum), count: rowsNum)

    // Fill the first row with column names
    for j in 1..<colsNum {
        marksArray[0][j] = columns[j]
    }
    // Fill the first column with row names
    for i in 0..<rowsNum {
        marksArray[i][0] = rows[i]
    }
    
    for i in 1..<rowsNum {
        for j in 1..<colsNum {
            let randNum = Int.random(in: 60...90) 
            marksArray[i][j] = String(randNum) 
        }
    }
    
    return marksArray
}

// Read the input files
let inputFilePath = "./students.txt"
let inputFilePath2 = "./assignments.txt"

guard let inputFile = FileHandle(forReadingAtPath: inputFilePath),
      let inputFile2 = FileHandle(forReadingAtPath: inputFilePath2) else {
    print("Error: Unable to open input files.")
    exit(1)
}

// Read the contents of the files
let inputData = inputFile.readDataToEndOfFile()
let inputData2 = inputFile2.readDataToEndOfFile()

guard let inputString = String(data: inputData, encoding: .utf8),
      let inputString2 = String(data: inputData2, encoding: .utf8) else {
    print("Error: Unable to read input files.")
    exit(1)
}

// Split the contents into lines
let nameList = inputString.components(separatedBy: .newlines)
let assignmentList = inputString2.components(separatedBy: .newlines)

// Convert the lists to arrays
let names = nameList
let assignments = assignmentList

// Call the generateMarks function
let marks = generateMarks(names, assignments)

// Write the 2D array to a CSV file
let outputFilePath = "./marks.csv"
guard let fileWriter = FileHandle(forWritingAtPath: outputFilePath) else {
    print("Error: Unable to open output file.")
    exit(1)
}

// Write the marks array to the file
for row in marks {
    let line = row.joined(separator: ",")
    if let data = (line + "\n").data(using: .utf8) {
        fileWriter.write(data)
    }
}

// Close the file handles
inputFile.closeFile()
inputFile2.closeFile()
fileWriter.closeFile()