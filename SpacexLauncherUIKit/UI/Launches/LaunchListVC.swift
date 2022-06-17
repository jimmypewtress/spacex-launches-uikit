//
//  LaunchListVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

class LaunchListVC: BaseVC {
    private var viewModel: LaunchListVM!
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constructor
    class func createVC(viewModel: LaunchListVM) -> LaunchListVC {
        return Utils.createVC(storyboard: .launchList) { vc in
            vc.viewModel = viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
    }
    
    override func subscribe() {
        self.viewModel.tableDataChangedSubject.sink { _ in }
            receiveValue: { tableChanged in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.store(in: &cancellables)
        
        self.viewModel.refreshingEndedSubject.sink { _ in }
            receiveValue: { refreshEnded in
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }.store(in: &cancellables)
    }
    
    private func configureUI() {
        self.navigationItem.title = Constants.Strings.Launches.navbarTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.Strings.General.logout,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(logoutButtonTapped))
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = Constants.MagicNumbers.defaultLaunchCellHeight.cgFloat
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc private func logoutButtonTapped(_ sender: UIButton) {
        self.viewModel.logoutButtonTapped()
    }
    
    @objc private func fetchData() {
        self.viewModel.fetchData(isRefresh: true)
    }
}

extension LaunchListVC: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last else { return }
        
        let key = self.viewModel.tableSections[indexPath.section]
        
        if let rows = self.viewModel.tableRows[key]?.count, key == self.viewModel.tableSections.last {
            if indexPath.row >= max(0, rows - Constants.MagicNumbers.launchesPrefetchOffset) {
                self.viewModel.fetchData(isRefresh: false)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.tableSections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.viewModel.tableRows[self.viewModel.tableSections[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let month = DateFormatter.monthOnlyThreeLetters.string(from: self.viewModel.tableSections[section])
        let year = DateFormatter.yearOnly.string(from: self.viewModel.tableSections[section])
        
        let headerView = LaunchSectionHeader.createVC(month: month, year: year).view
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return Constants.MagicNumbers.launchesHeaderHeight.cgFloat
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.MagicNumbers.launchesHeaderHeight.cgFloat
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = self.viewModel.tableSections[indexPath.section]
        let rows = self.viewModel.tableRows[sectionKey]
        let row = rows?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row?.reuseIdentifier ?? "", for: indexPath)
        
        if let row = row {
            (cell as? LaunchCell)?.configure(with: row, indexPath: indexPath)
        }
        
        return cell
    }
}
