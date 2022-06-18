//
//  Constants+Error.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 14/06/2022.
//

extension Constants {
    struct Error {
        enum Network: Equatable {
            case noHostForEndpoint
            case cannotCreateUrl
            case noHttpResponse
            case serializationIssue
            case jsonInvalidIssue
            case deserializationIssue
            case httpIssue
            case urlError(description: String)
            
            var appError: AppError {
                switch self {
                case .noHostForEndpoint:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.noHostForEndpoint)
                case .cannotCreateUrl:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.cannotCreateUrl)
                case .noHttpResponse:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.noHttpResponse)
                case .serializationIssue:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.serializationIssue)
                case .jsonInvalidIssue:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.jsonInvalidIssue)
                case .deserializationIssue:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.deserializationIssue)
                case .httpIssue:
                    return AppError(title: Constants.Strings.General.error,
                                    message: Constants.Strings.Error.httpIssue)
                case .urlError(let description):
                    return AppError(title: Constants.Strings.General.error,
                                    message: description)
                }
            }
        }
    }
}
