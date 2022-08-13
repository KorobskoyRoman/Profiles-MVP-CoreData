//
//  UsersViewController.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import UIKit

final class UsersViewController: UIViewController {
    private let presenter: UsersPresenter
    private lazy var searchView = SearchView()
    private lazy var tableView = UITableView(frame: view.bounds, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground()
        setupView()
    }

    private func setupView() {
        title = TitleConstants.usersTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        getData()
        setupTableView()
        setConstraints()
        setupAction()
    }

    private func setupTableView() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    init(presenter: UsersPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        self.view.addSubview(searchView)
        view.addSubview(tableView)
        var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topbarHeight*1.5),
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: Insets.inset100),

            tableView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    private func setupAction() {
        searchView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }

    @objc private func createButtonTapped() {
        if !searchView.textField.hasText {
            print("empty")
        } else {
            print("filled")
            presenter.saveData(from: searchView.textField.text ?? "")
            searchView.textField.text = ""
            searchView.textField.isSelected = false
            getData()
        }
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

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.usersCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId,
                                                 for: indexPath) as? UserCell
        else { return UITableViewCell() }
        cell.configure(from: presenter.user(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.delete(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            reload()
        }
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseId,
                                                 for: indexPath) as? UserCell
        else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsPresenter = DetailsPresenter()
        detailsPresenter.user = presenter.user(at: indexPath.row)
        let detailsVC = DetailsViewController(presenter: detailsPresenter)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
