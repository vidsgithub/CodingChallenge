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
        // TODO: Candidates to implement binding here.
    }
 }
