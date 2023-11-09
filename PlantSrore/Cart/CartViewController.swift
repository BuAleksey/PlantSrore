//
//  CartViewController.swift
//  PlantSrore
//
//  Created by Buba on 02.11.2023.
//

import UIKit
import SnapKit

final class CartViewController: UIViewController {
    private var viewModel: CartTableViewModelProtocol! {
        didSet {
            viewModel.fetchPlants { [unowned self] in
                tableView.reloadData()
                setupUI()
            }
        }
    }
    
    private let empryCartLabel = UILabel()
    private let imageView: UIImageView = {
        let imageView = UIImageView.fromGif(frame: .zero, resourceName: "plant")
        guard let imageView = imageView else { return UIImageView() }
        return imageView
    }()
    private let tableView = UITableView()
    private let orderBtn = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartTableViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPlants { [unowned self] in
            tableView.reloadData()
            setupUI()
        }
    }
}

// MARK: - TableView
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(CartCell.self)",
            for: indexPath
        ) as? CartCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.getCartCellViewModel(at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let fotteView = UIView()
        orderBtn.frame = CGRect(
            x: tableView.frame.width / 2 - 100,
            y: 0,
            width: 200,
            height: 60
        )
        fotteView.addSubview(orderBtn)
        return fotteView
    }
}

// MARK: - Private metods
extension CartViewController {
    private func setupUI() {
        configurateNaviationBar()
        
        view.backgroundColor = .backgroundGray
        
        empryCartLabel.text = "Cart is empty.."
        empryCartLabel.font = .systemFont(ofSize: 16, weight: .regular)
        
        imageView.animationDuration = 5
        imageView.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "\(CartCell.self)")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundGray
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)

        orderBtn.backgroundColor = .tabbarGreenItem
        orderBtn.layer.cornerRadius = 10
        orderBtn.setTitle("Order", for: .normal)
        orderBtn.setTitleColor(.white, for: .normal)
        orderBtn.addTarget(self, action: #selector(orderBtnTapped), for: .touchUpInside)
        
        updateUI()
        setupConstraints()
    }
    
    private func configurateNaviationBar() {
        navigationItem.titleView = createCustomTitelView(titel: "CART")
        
        let trashBtn = UIBarButtonItem()
        trashBtn.image = UIImage(systemName: "trash")
        trashBtn.tintColor = .black
        trashBtn.target = self
        trashBtn.action = #selector(epmptyTheTrash)
        
        navigationItem.rightBarButtonItem = trashBtn
    }
    
    private func setupConstraints() {
        view.addSubview(empryCartLabel)
        view.addSubview(imageView)
        view.addSubview(tableView)
        
        empryCartLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(200)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(186)
            make.height.equalTo(330)
            make.centerX.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.trailing.equalTo(view.snp.trailing)
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func updateUI() {
        imageView.isHidden = !viewModel.cartIsEmpty
        tableView.isHidden = viewModel.cartIsEmpty
    }
    
    @objc private func orderBtnTapped() {
        viewModel.makeOrder()
        present(OrderViewController(), animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [unowned self] in
            viewModel.fetchPlants { [unowned self] in
                tableView.reloadData()
                setupUI()
            }
        }
    }
    
    @objc private func epmptyTheTrash() {
        viewModel.emptyTheTrash()
        viewModel.fetchPlants { [unowned self] in
            tableView.reloadData()
            setupUI()
        }
    }
}
