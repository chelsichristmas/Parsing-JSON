//
//  ViewController.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Chelsi Christmas on 8/4/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit

class StationsViewController: UIViewController {
    
    
    // TODO: use the "region_id" to create multiple sections
    // create an enum to represent our table view sections
    // TODO: add a search bar to dind locations (include current location)
    // TODO: Add a map view to find the stations near you
    // TODO: Add the number of bikes available or stations empty to the annotation or some pop-up/ alert controller
    enum Section {
        case primary
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Station>!
    
    let apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Citi Bike Stations"
        fetchData()
        configureDataSource()
    }
    
    private func fetchData() {
        // Result type has two values
        // 1. .failure() or 2. .success
        apiClient.fetchData { [weak self](result) in
            switch result {
            case .failure(let appError):
                print(appError)
            case .success(let stations):
                DispatchQueue.main.async{ // update UI on the main thread
                    self?.updateSnapshot(with: stations)
                }
            }
        }
    }
    
    private func updateSnapshot(with stations: [Station])  {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(stations, toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, station) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = station.name
            cell?.detailTextLabel?.text = "Bike Capacity: \(station.capacity)"
            
            return cell
        })
        
        // set up initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
}


// place in its own file
//TODO: Continue to implement in order to show the section header titles
// subclass UITableViewDiffableDataSource
class DataSource:
UITableViewDiffableDataSource<StationsViewController.Section, Station> {}

