//
//  ViewController.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import UIKit

class ViewController: BaseViewController, UITableViewDelegate, StoryboardInstantiable {
    
    var viewModel: ViewControllerViewModel!
    var tableViewUniversities: UITableView!

    static func create(with viewModel: ViewControllerToViewModel) -> ViewController {
        let controller = ViewController.instantiateViewController()
        controller.viewModel = (viewModel as! ViewControllerViewModel)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Universities"
        tableViewUniversities = UITableView()
                
        tableViewUniversities.register(UniversityCell.self)
        tableViewUniversities.delegate = self
        tableViewUniversities.dataSource = self
        tableViewUniversities.rowHeight = UITableView.automaticDimension;
        tableViewUniversities.estimatedRowHeight = 100.0;
        tableViewUniversities.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(tableViewUniversities)
        
        tableViewUniversities.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableViewUniversities.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableViewUniversities.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableViewUniversities.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        setUpViewModel()
    }
    
    func setUpViewModel() {
        viewModel.updateUI = { [weak self] in
            
            if self?.viewModel.error.clientError != nil {
                //TODO: show error
            } else if self?.viewModel.error.dataError != nil {
                //TODO: show error
            } else if self?.viewModel.universities != nil {
                self?.tableViewUniversities.reloadData()
            }
        }
        viewModel.fetchUniversities(apiClient: APIClient())
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRows(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel!.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getUniversityCell(tableView: tableView, indexPath: indexPath)
    }
    
    func getUniversityCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell: UniversityCell = tableView.dequeueReusableCell(for: indexPath)

        if let university = viewModel!.fetchUniversity(index: indexPath.row) {
            cell.lblTitle.text = university.name
            cell.lblCountry.text = university.country
        }
        
        return cell
    }
}
