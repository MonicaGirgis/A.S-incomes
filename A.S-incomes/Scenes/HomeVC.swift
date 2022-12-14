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
    
    private var expenses: [Expense] = []
    private lazy var loader: UIView = {
       return createActivityIndicator()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
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
        loader.isHidden = false
        APIRoute.shared.fetchRequest(clientRequest: .getExpenses, decodingModel: Response<Expense>.self) { [weak self] result in
            guard let strongSelf = self else { return}
            strongSelf.loader.isHidden = true
            switch result {
            case .success(let data):
                strongSelf.expenses = data.data
                strongSelf.tableView.reloadData()
            case .failure(let error):
                windows?.make(toast: error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? EnterExpensesVC, let expense = sender as? Expense else { return}
        vc.expense = expense
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeVC: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IncomeTableCell.identifier, for: indexPath) as! IncomeTableCell
        cell.setData(expense: expenses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = UserManager.shared.getUserData().type, type == "admin" else { return}
        performSegue(withIdentifier: "show" + EnterExpensesVC.identifier , sender: expenses[indexPath.row])
    }
}
