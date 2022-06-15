//
//  LaunchListVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 07/06/2022.
//

import UIKit

class LaunchListVC: BaseVC {
    private var viewModel: LaunchListVM!
    
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
        self.viewModel.tableDataChangedSubject.sink { _ in}
            receiveValue: { tableChanged in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    private func configureUI() {
        self.navigationItem.title = Constants.Strings.Launches.navbarTitle
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.viewModel.logoutButtonTapped()
    }
}

extension LaunchListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.viewModel.tableRows["temp"]?.count ?? 0
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
