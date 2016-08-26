//
//  main.swift
//  OptionParseSample
//
//  Created by Steve Marquis on 8/5/16.
//  Copyright © 2016 Steve Marquis. All rights reserved.
//

import Foundation
import OptionParse

// Sample app. Takes in an unnamed argument that it will echo to stdout, or if '--file' is supplied, to the given file.
// If '--loud' is given, it prints it in all caps.

var parser = OptionParser(name: "OptionParseSample", usage: "A sample app!")
let file = parser.flag("file", valueName: "file-name", usage: "Write to the file specified instead of stdout")
let loud = parser.toggle("loud", usage: "Makes the message all caps")

let string = parser.required("string", usage: "The string to print")

do {
    try parser.parse()
} catch {
    exit(1)
}

var stringToPrint: String = string.value
if loud.value {
    stringToPrint = stringToPrint.uppercaseString
}

let fileHandle: NSFileHandle
if let fileName = file.value {
    let path = (NSFileManager.defaultManager().currentDirectoryPath as NSString).stringByAppendingPathComponent(fileName)
    NSFileManager.defaultManager().createFileAtPath(path, contents: stringToPrint.dataUsingEncoding(NSUTF8StringEncoding)!, attributes: nil)
} else {
    print(stringToPrint)
}
