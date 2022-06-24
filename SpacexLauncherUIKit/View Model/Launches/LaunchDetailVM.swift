//
//  LaunchDetailVM.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import Foundation
import Combine

protocol LaunchDetailVM {
    var tableDataChangedSubject: CurrentValueSubject<Bool, Error> { get }
    var tableRows: [TableRow] { get }
    var selectedRocketName: String { get set }
}

class LaunchDetailVMImpl: BaseVM, LaunchDetailVM {
    var tableDataChangedSubject = CurrentValueSubject<Bool, Error>(false)
    var tableRows: [TableRow] = []
    var selectedRocketName: String

    private var uc: LaunchDetailUC
    private var input: LaunchDetailVMInput
    
    init(uc: LaunchDetailUC,
         input: LaunchDetailVMInput) {
        self.uc = uc
        self.input = input
        self.selectedRocketName = input.rocketName
        
        super.init()
        
        self.getLaunchDetails(id: input.id)
    }
    
    override func subscribe() {
        self.uc.combinedLaunchPublisher.sink { combinedLaunch in
            if let combinedLaunch = combinedLaunch {
                self.populateTable(launch: combinedLaunch)
                self.selectedRocketName = combinedLaunch.rocketName
            }
        }.store(in: &cancellables)
    }
    
    private func getLaunchDetails(id: String) {
        self.uc.fetchLaunchDeatails(launchId: id)
    }
    
    private func populateTable(launch: CombinedLaunch) {
        let imageCellVM = ImageCellVM(url: launch.imageUrl)
        let rocketHeadingCellVM = HeadingCellVM(heading: launch.rocketName)
        let infoSpacerCellVM = SpacerCellVM(height: Constants.MagicNumbers.launchDetailCellInfoSpacing)
        let headingSpacerCellVM = SpacerCellVM(height: Constants.MagicNumbers.launchDetailCellHeadingSpacing)
        let dateInfoCellVM = InfoCellVM(heading: Constants.Strings.Launches.DetailCell.date,
                                        text: DateFormatter.dayMonthYear.string(from: launch.date) + ":")
        let launchpadInfoCellVM = InfoCellVM(heading: Constants.Strings.Launches.DetailCell.launchpad + ":",
                                             text: launch.launchpadName)
        let descriptionHeadingCellVM = HeadingCellVM(heading: Constants.Strings.Launches.DetailCell.description)
        let textCellVM = TextCellVM(text: launch.description)
        
        let detailRows: [DetailRow] = [
            .image(imageCellVM),
            .heading(rocketHeadingCellVM),
            .spacer(infoSpacerCellVM),
            .info(dateInfoCellVM),
            .spacer(infoSpacerCellVM),
            .info(launchpadInfoCellVM),
            .spacer(headingSpacerCellVM),
            .heading(descriptionHeadingCellVM),
            .spacer(infoSpacerCellVM),
            .text(textCellVM)
        ]
        
        self.tableRows = detailRows
        
        self.tableDataChangedSubject.send(true)
    }
}
