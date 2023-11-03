//
//  CartTableViewController.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import UIKit

class CartTableViewController: UITableViewController {
    private var viewModel: CartTableViewModelProtocol! {
        didSet {
            viewModel.fetchPlants { [unowned self] in
                tableView.reloadData()
            }
        }
    }
    
    private let cartView = UIView()
    private let deliveryLabel = UILabel()
    private let totalSumLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartTableViewModel()
        view.backgroundColor = .backgroundGray
        setupNaviationBar()
        tableView.register(CartCell.self, forCellReuseIdentifier: "\(CartCell.self)")
        tableView.separatorStyle = .none
        configurCartView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlants { [unowned self] in
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CartCell.self)", for: indexPath) as? CartCell else { return UITableViewCell() }
        
        cell.viewModel = viewModel.getCartCellViewModel(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    private func setupNaviationBar() {
        navigationItem.titleView = createCustomTitelView(titel: "CART")
    }
    
    private func configurCartView() {
        cartView.translatesAutoresizingMaskIntoConstraints = false
        cartView.backgroundColor = .white
        
        view.addSubview(cartView)
        cartView.addSubview(deliveryLabel)
        cartView.addSubview(totalSumLabel)
        
        let viewHeight: CGFloat = 40
        cartView.frame = CGRect(
            x: 0,
            y: view.frame.height - viewHeight - (tabBarController?.tabBar.frame.height ?? 0),
            width: view.frame.width,
            height: viewHeight
        )
    }
}
