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
    var refreshingEndedSubject: CurrentValueSubject<Bool, Error> { get }
    var tableSections: [Date] { get }
    var tableRows: [Date: [LaunchRow]] { get }
    
    func logoutButtonTapped()
    func fetchData(isRefresh: Bool)
}

enum LaunchRow: Equatable {
    case cell(_ cell: LaunchCellVM)
    case spinner
}

class LaunchListVMImpl: BaseVM, LaunchListVM, ObservableObject {
    var tableDataChangedSubject = CurrentValueSubject<Bool, Error>(false)
    var refreshingEndedSubject = CurrentValueSubject<Bool, Error>(false)
    
    var tableSections: [Date] = []
    var tableRows: [Date : [LaunchRow]] = [:]
    
    private let uc: LaunchListUC
    private let logoutUC: LogoutUC
    
    private var isRefreshingList = false
    private var isEndOfTheList = false
    private var isFetching = false {
        willSet(newValue) {
            if newValue == false {
                self.refreshingEndedSubject.send(true)
            }
        }
    }
    
    private var currentIndex = Constants.MagicNumbers.launchesFirstIndex
    private var pageSize = Constants.MagicNumbers.launchesPageSize
    
    init(uc: LaunchListUC,
         logoutUC: LogoutUC) {
        self.uc = uc
        self.logoutUC = logoutUC
        
        super.init()
        
        self.getLaunches()
    }
    
    override func subscribe() {
        self.uc.launchesOutputPublisher.sink { launchesOutput in
            self.isFetching = false
            
            guard let launchesOutput = launchesOutput else { return }
            
            self.isEndOfTheList = launchesOutput.launches.count < self.pageSize
            
            if self.isRefreshingList {
                self.isRefreshingList = false
                self.tableSections.removeAll()
                self.tableRows.removeAll()
            }
            
            if !self.tableRows.isEmpty,
               !self.tableSections.isEmpty,
               let lastLoadedSection = self.tableSections.last,
               let lastLoadedRows = self.tableRows[lastLoadedSection],
               lastLoadedRows.last == .spinner {
                self.tableRows[lastLoadedSection]?.removeLast()
            }
                
            let launchCellModels = launchesOutput.launches
                .sorted { $0.date > $1.date }
                .map { return LaunchCellVM($0) }
            
            let groupDictionary = Dictionary(grouping: launchCellModels) { (launchVM) -> Date in
                return launchVM.date.monthOnlyDate
            }
            
            let newMonths = groupDictionary.keys
            self.tableSections = (self.tableSections + newMonths).sorted { $0 > $1 }.unique
            
            launchCellModels.forEach { cellModel in
                if let _ = self.tableRows[cellModel.date.monthOnlyDate] {
                    self.tableRows[cellModel.date.monthOnlyDate]?.append(.cell(cellModel))
                } else {
                    self.tableRows[cellModel.date.monthOnlyDate] = [.cell(cellModel)]
                }
            }

            self.tableDataChangedSubject.send(true)

        }.store(in: &cancellables)
    }
    
    func fetchData(isRefresh: Bool) {
        if self.isFetching {
            return
        }
        
        self.isRefreshingList = isRefresh
        self.isFetching = true
        
        if isRefresh {
            self.isEndOfTheList = false
            self.currentIndex = 1
        } else {
            self.currentIndex += pageSize
            self.currentIndex += 1
            
            if let lastSection = self.tableSections.last {
                self.tableRows[lastSection]?.append(.spinner)
            }
            
            self.tableDataChangedSubject.send(true)
        }
        
        if !self.isEndOfTheList {
            self.getLaunches()
        } else {
            self.isFetching = false
        }
    }
    
    func logoutButtonTapped() {
        self.logoutUC.logout()
    }
    
    private func getLaunches() {
        self.uc.fetchLaunches(currentIndex: self.currentIndex, pageSize: self.pageSize)
    }
}
