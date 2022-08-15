//
//  DetailsViewController.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    private let presenter: DetailsPresenter
    private lazy var tableView = UITableView(frame: view.bounds, style: .plain)
    private var isEdit = false
    private let index: Int

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground()
        setupView()
    }

    init(presenter: DetailsPresenter, index: Int) {
        self.presenter = presenter
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        title = presenter.user.name
        setupTableView()
    }

    private func setupTableView() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.reuseId)
    }

    private func getData() {
        presenter.getData()
        reload()
    }

    private func reload() {
        self.presenter.reload = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.reuseId,
                                                 for: indexPath) as? DetailsCell
        else { return UITableViewCell() }
        cell.configure(from: presenter.user)
        cell.presenter = presenter
        cell.index = index
        return cell
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 685
    }
}
