//
//  LaunchListVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import Foundation
import Combine

protocol LaunchListVM {
    var tableDataChangedSubject: CurrentValueSubject<Bool, Error> { get }
    var tableSections: [String] { get }
    var tableRows: [String: [LaunchRow]] { get }
    
    func logoutButtonTapped()
}

enum LaunchRow {
    case cell(_ cell: LaunchCellVM)
    case spinner
}

class LaunchListVMImpl: BaseVM, LaunchListVM, ObservableObject {
    var tableDataChangedSubject = CurrentValueSubject<Bool, Error>(false)
    
    var tableSections: [String] = []
    var tableRows: [String : [LaunchRow]] = [:]
    
    private let uc: LaunchListUC
    private let logoutUC: LogoutUC
    
    init(uc: LaunchListUC,
         logoutUC: LogoutUC) {
        self.uc = uc
        self.logoutUC = logoutUC
        
        super.init()
        
        self.fetchData()
    }
    
    override func subscribe() {
        self.uc.launchesOutputPublisher.sink { launchesOutput in
            if let launchesOutput = launchesOutput {
                let fetchedLaunches = launchesOutput.launches
                    .sorted { $0.date > $1.date }
                    .map { return LaunchCellVM($0) }
                
                let rows = fetchedLaunches.map { return LaunchRow.cell($0) }
                
                self.tableSections = ["temp"]
                self.tableRows = ["temp": rows]
                
                self.tableDataChangedSubject.send(true)
            }
        }.store(in: &cancellables)
    }
    
    private func fetchData() {
        self.uc.fetchLaunches()
    }
    
    func logoutButtonTapped() {
        self.logoutUC.logout()
    }
}
