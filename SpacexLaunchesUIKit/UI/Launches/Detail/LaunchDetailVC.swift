//
//  LaunchDetailVC.swift
//  SpacexLauncherUIKit
//
//  Created by Jimmy Pewtress on 18/06/2022.
//

import UIKit

class LaunchDetailVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: LaunchDetailVM!
    
    // MARK: - Constructor
    class func createVC(viewModel: LaunchDetailVM) -> LaunchDetailVC {
        return Utils.createVC(storyboard: .launchDetail) { vc in
            vc.viewModel = viewModel
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.configureUI()
        self.setupTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func subscribe() {
        self.viewModel.tableDataChangedSubject.sink { _ in }
            receiveValue: { tableChanged in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.title = self.viewModel.selectedRocketName
                }
            }.store(in: &cancellables)
    }
    
    private func configureUI() {
        self.tapDismissesKeyboard = false
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = self.viewModel.selectedRocketName
    }
    
    private func setupTable() {
        tableView.tableFooterView = UIView()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        ImageCell.register(with: self.tableView)
        HeadingCell.register(with: self.tableView)
        InfoCell.register(with: self.tableView)
        TextCell.register(with: self.tableView)
        SpacerCell.register(with: self.tableView)
        ButtonCell.register(with: self.tableView)
    }
}

extension LaunchDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.viewModel.tableRows[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        cell.selectionStyle = row.selectionStyle
        
        (cell as? CustomCell)?.configure(with: row, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        let selectedRow = self.viewModel.tableRows[indexPath.row]
        self.viewModel.didSelectRow(selectedRow)
    }
}
