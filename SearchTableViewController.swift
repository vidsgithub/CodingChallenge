//
//  SearchTableViewController.swift
//  CodingChallenge
//
//  Created by DzuyAn Nguyen on 10/18/18.
//  Copyright © 2018 SmartThings. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchTableViewController: UIViewController {
    
    enum Constants {
        static let throttleLimit: Int = 1
        static let debounceLimit: Int = 3
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private let cellIdentifier = "CellIdentifier"
    private let minimumCharacterCount = 2
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureBinding()
    }
    
    fileprivate func configureUI() {
        title = "Github Search"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    fileprivate func configureBinding() {
        // Courtesy: https://www.youtube.com/watch?v=W3zGx4TUaCE
        // TODO: Candidates to implement binding here.
        
        /// Build HeaderView
        let headerView = UIView(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width, height: 44.0))
        headerView.backgroundColor = UIColor.lightGray
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Result - 0"
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        tableView.tableHeaderView = headerView
        
        /// Post Search Request
        let searchResults = searchController.searchBar.rx.text
            .orEmpty
            .throttle(.seconds(Constants.throttleLimit), scheduler: MainScheduler.instance)
            .filter { (searchQuery) -> Bool in
                let filterQuery = searchQuery.replacingOccurrences(of: " ", with: "")
                return filterQuery.count > self.minimumCharacterCount
            }.debounce(RxTimeInterval.seconds(Constants.debounceLimit), scheduler: MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (query) -> Observable<GitHubSearchResults> in
                let request = GitHubRequest(name: query)
                return (self.apiClient.send(apiRequest: request)
                    .catchError { error in
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error fetching API", message: error.localizedDescription)
                        }
                        return .empty()
                })
            }.share()
        
        // update the tableview header with search result count
        searchResults
            .map { (gitHubResults) -> String in
                return "Results - \(gitHubResults.totalCount)"
        }.bind(to: label.rx.text)
            .disposed(by: self.disposeBag)
        
        // Updating tableView
        searchResults
            .map { (gitHubResults) -> [GitHubRepo] in
                return gitHubResults.items
        }.bind(to: tableView.rx.items(cellIdentifier: self.cellIdentifier)) { (row, model, cell) in
            cell.textLabel?.text = model.name
        }.disposed(by: self.disposeBag)
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
 }
