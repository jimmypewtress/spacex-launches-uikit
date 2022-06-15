//
//  Data+Decode.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 15/06/2022.
//

import Foundation

extension Data {
    func decode<Type>() -> Type? where Type: Decodable {
        let decoder = JSONDecoder()
        
        do {
            let decodedJson = try decoder.decode(Type.self, from: self)
            return decodedJson
        } catch {
            print(error)
        }
    
        return nil
    }
}
