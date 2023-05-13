//
//  ViewController.swift
//  WBTravel
//
//  Created by Shalopay on 12.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let userDefault = UserDefaults.standard
    var downLoadManager = DownLoadManager()
    var flights = [Flight]()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.color = .black
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    public lazy var flightTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorInset.left = 16
        tableView.separatorInset.right = 16
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicatorView.startAnimating()
        downLoadManager.getTravel { travel in
            guard let travel = travel else {return print("OPS")}
            self.flights = travel.flights
            DispatchQueue.main.async {
                self.flightTableView.reloadData()
                self.indicatorView.stopAnimating()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubviews([
            flightTableView, indicatorView
        ])
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            flightTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flightTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            flightTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            flightTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func changeLike(sender: CustomButton) {
        print("SENDER:\(sender.tag)")
        if sender.isSelected == false {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.isSelected = true
        } else {
            sender.isSelected = false
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        userDefault.set(sender.isSelected, forKey: "\(sender.tag)")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FlightCell.identifier, for: indexPath) as? FlightCell else {return UITableViewCell(frame: .zero)}
        let flight = flights[indexPath.row]
        cell.configureCell(flight)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        cell.likeButton.isSelected = userDefault.bool(forKey: "\(cell.likeButton.tag)")
        cell.likeButton.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SECTION: \(indexPath.section) - ROW: \(indexPath.row)")
        let flightDetailVC = FlightDetailVC()
        let flight = flights[indexPath.row]
        flightDetailVC.title = "Детализация о полете"
        flightDetailVC.configureView(flight, buttonTag: indexPath.row)
        navigationController?.pushViewController(flightDetailVC, animated: true)
    }
    
    
}
