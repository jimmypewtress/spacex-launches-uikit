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
    
    func didSelectRow(_ row: TableRow)
}

class LaunchDetailVMImpl: BaseVM, LaunchDetailVM {
    var tableDataChangedSubject = CurrentValueSubject<Bool, Error>(false)
    var tableRows: [TableRow] = []
    var selectedRocketName: String

    private var uc: LaunchDetailUC
    private var input: LaunchDetailVMInput
    private var externalUrlCoordintor: ExternalUrlCoordinator
    
    private var fetchedLaunch: CombinedLaunch? = nil
    
    init(uc: LaunchDetailUC,
         input: LaunchDetailVMInput,
         externalUrlCoordintor: ExternalUrlCoordinator) {
        self.uc = uc
        self.input = input
        self.selectedRocketName = input.rocketName
        self.externalUrlCoordintor = externalUrlCoordintor
        
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
        let buttonCellVM = ButtonCellVM(title: Constants.Strings.Launches.DetailCell.watchVideo,
                                        enabled: launch.youTubeId != nil)
        
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
            .text(textCellVM),
            .spacer(headingSpacerCellVM),
            .spacer(infoSpacerCellVM),
            .button(buttonCellVM)
        ]
        
        self.tableRows = detailRows
        self.fetchedLaunch = launch
        
        self.tableDataChangedSubject.send(true)
    }
    
    func didSelectRow(_ row: TableRow) {
        if let youTubeId = self.fetchedLaunch?.youTubeId {
            let youTubeUrl = Constants.Strings.YouTube.baseUrl + youTubeId
            self.externalUrlCoordintor.start(youTubeUrl)
        }
    }
}
