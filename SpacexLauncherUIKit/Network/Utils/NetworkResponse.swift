//
//  NetworkResponse.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

enum NetworkResponse<T> {
    case success(_ response: T)
    case failure
}
