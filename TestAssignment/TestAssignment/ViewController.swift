//
//  ViewController.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, StoryboardInstantiable {
    
    var viewModel: ViewControllerViewModel!
    @IBOutlet weak var ib_tblViewUniversities: UITableView!

    static func create(with viewModel: ViewControllerToViewModel) -> ViewController {
        let controller = ViewController.instantiateViewController()
        controller.viewModel = (viewModel as! ViewControllerViewModel)
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        ib_tblViewUniversities.register(cell: UniversityCell.self)
        ib_tblViewUniversities.delegate = self
        ib_tblViewUniversities.dataSource = self
        ib_tblViewUniversities.rowHeight = UITableView.automaticDimension;
        ib_tblViewUniversities.estimatedRowHeight = 60.0;
        
        setUpViewModel()
    }
    
    func setUpViewModel() {
        viewModel.updateUI = { [weak self] in
            
            if self?.viewModel.error.clientError != nil {
                //TODO: show error
            } else if self?.viewModel.error.dataError != nil {
                //TODO: show error
            } else if self?.viewModel.universities != nil {
                self?.ib_tblViewUniversities.reloadData()
            }
        }
        viewModel.fetchUniversities(apiClient: APIClient())
    }
    
    // MARK: - UITableViewDataSource
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
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as UniversityCell
        
        if let university = viewModel!.fetchUniversity(index: indexPath.row) {
            cell.ib_lblTitle.text = university.name
            cell.ib_lblCountry.text = university.country
        }
        
        return cell
    }
}
