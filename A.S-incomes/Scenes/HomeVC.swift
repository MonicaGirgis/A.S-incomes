//
//  HomeVC.swift
//  A.S-incomes
//
//  Created by Monica Girgis Kamel on 17/09/2022.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl  = UIRefreshControl()
    private var isFirstRefresh: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

    private func setupUI() {
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handleRefresher), for: .valueChanged)
        
        tableView.register(IncomeTableCell.nib, forCellReuseIdentifier: IncomeTableCell.identifier)
    }
    
    @objc private func handleRefresher(){
        fetchData()
    }
    
    @objc private func handleRefreshControl(_ isRefreshing:Bool) {
        if isRefreshing {
            if isFirstRefresh{
                isFirstRefresh = !isFirstRefresh
                tableView.contentOffset = CGPoint(x:0, y:-self.refreshControl.frame.size.height)
            }
            refreshControl.beginRefreshing()
        } else {
            if refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }
        }
    }
    
    private func fetchData() {
        
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeVC: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IncomeTableCell.identifier, for: indexPath) as! IncomeTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
