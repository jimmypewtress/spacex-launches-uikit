//
//  APITests.swift
//  SpacexLauncherUIKitTests
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import XCTest
@testable import SpacexLauncherUIKit

class APITests: TestCase {

    struct SerializationFailure: RequestAndResponse {
        typealias Request = Int
        typealias Headers = Payload.Empty
        typealias Response = Int
        
        static func toRawRequest(_ request: Int, headers: Headers) -> RawRequest? {
            return nil
        }
    }
    
    func testSerializationFailure() {
        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.serializationIssue.appError)
                }
            }.store(in: &cancellables)

        
        let request: ApiRequest<SerializationFailure> = r.api.request()
        
        // type of Int is not encodable to JSON
        request.fetch(10, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    struct Dummy: RequestAndResponse {
        typealias Request = [String: String]
        typealias Headers = Payload.Empty
        typealias Response = [String: String]
        
        static func toRawRequest(_ request: [String: String], headers: Headers) -> RawRequest? {
            return RawRequest(request, endpoint: .launches)
        }
    }
    
    let dummyInput = ["sample": "input"]
    let dummyOutput = ["sample": "output"]

    func testInvalidJson() {
        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.jsonInvalidIssue.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        // there is nothing in MockedRawNetwork.response so deserializing [String: String] should fail
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testDeserializationFailure() {
        self.network.launchesResponse.data = try? JSONEncoder().encode(["2": 1])
        
        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.deserializationIssue.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        // [String: Int] is not [String: String]
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testNoHostErrorHandled() {
        self.network.launchesResponse.networkingError = .noHostForEndpoint
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)
        
        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.noHostForEndpoint.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testCannotCreateUrlErroHandled() {
        self.network.launchesResponse.networkingError = .cannotCreateUrl
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)

        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.cannotCreateUrl.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testNoHttpResponseErrorHandled() {
        self.network.launchesResponse.networkingError = .noHttpResponse
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)

        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.noHttpResponse.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testHttpIssueErrorHandled() {
        self.network.launchesResponse.httpStatusCode = 500
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)

        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.httpIssue.appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }

    let dummyUrlError = NSError(domain: NSURLErrorCannotConnectToHost.description, code: 123)
    
    func testUrlErrorDomainFailure() {
        self.network.launchesResponse.urlErrorCode = dummyUrlError.code
        self.network.launchesResponse.urlErrorLocalizedDescription = dummyUrlError.localizedDescription
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)
        
        let failExpectation = expectation(description: "request should fail")
        let errorExpectation = expectation(description: "error should be generated")
        
        r.errorHandler.uc.errorSubject.sink { _ in }
            receiveValue: { error in
                if let error = error {
                    errorExpectation.fulfill()
                    XCTAssertEqual(error, Constants.Error.Network.urlError(description: self.dummyUrlError.localizedDescription).appError)
                }
            }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
                failExpectation.fulfill()
            } receiveValue: { response in
                XCTFail("Should not succeed")
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSuccessfullResponse() {
        self.network.launchesResponse.data = try? JSONEncoder().encode(dummyOutput)
        
        let successExpectation = expectation(description: "request should succeed")
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in
    
            } receiveValue: { response in
                successExpectation.fulfill()
            }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSpinnerIsShown() {
        let spinnerExpectation = expectation(description: "spinner is shown")
        
        r.activityIndicator.uc.isShownPublisher.sink { isShown in
            if isShown {
                spinnerExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init()).sink { _ in } receiveValue: { _ in }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSpinnerIsNotShown() {
        let spinnerExpectation = expectation(description: "spinner is shown")
        spinnerExpectation.isInverted = true
        
        r.activityIndicator.uc.isShownPublisher.sink { isShown in
            if isShown {
                spinnerExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        let request: ApiRequest<Dummy> = r.api.request()
        
        request.fetch(dummyInput, headers: .init(), showSpinner: false).sink { _ in } receiveValue: { _ in }.store(in: &cancellables)

        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
