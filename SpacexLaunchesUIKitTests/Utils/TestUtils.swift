//
//  TestUtils.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import Foundation

extension NSObject {
    func readFile(fileName: String,
                  ofType: String = "json",
                  encoding: String.Encoding = .utf8) -> String {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: fileName, ofType: ofType) else {
            fatalError("\(fileName).json not found")
        }

        guard let string = try? String(contentsOfFile: pathString, encoding: encoding) else {
            fatalError("Unable to convert \(fileName).json to String")
        }
        return string
    }
}
