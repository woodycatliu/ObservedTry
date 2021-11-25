//
//  MultiObservedViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/11/24.
//

import UIKit

class MultiObservedViewController: UIViewController {
    
    private let identifier: String = UUID().uuidString
    
    private var anyCancelable = Set<ObservableCancellable>()
    
    var number: Int = 0 {
        didSet {
            self.title = "\(number)"
        }
    }
    
    var cellCount: Int = 0 {
        didSet {
            if oldValue != cellCount {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(MultiObservedBoardCell.self, forCellReuseIdentifier: MultiObservedBoardCell.description())
        tv.dataSource = self
        tv.delegate = self
        tv.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.setImage(.init(systemName: "staroflife.fill"), for: .normal)
        btn.addTarget(self, action: #selector(pushNewOne), for: .touchUpInside)
        btn.backgroundColor = .white
        btn.layer.borderColor = UIColor.brown.cgColor
        btn.layer.borderWidth = 2
        return btn
    }()
    
    convenience init(_ number: Int) {
        self.init()
        self.number = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observed()
    }
    
    deinit {
        cancell()
        print("MultiObservedViewController is deinit, id: \(identifier)")
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: view.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 55),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    

}

extension MultiObservedViewController {
    
    private func observed() {
        MultiObservedManager.shared.$blogs
            .observe(identifier, queue: .global()) {
                [weak self] bs in
                self?.cellCount = bs.count
            }.store(&anyCancelable)
    }
    
    private func cancell() {
        MultiObservedManager.shared.$blogs.cancel(identifier)
    }
}


extension MultiObservedViewController {
    
    @objc
    private func pushNewOne() {
        self.navigationController?.pushViewController(MultiObservedViewController(number + 1), animated: true)
    }
}

extension MultiObservedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

extension MultiObservedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MultiObservedBoardCell.description(), for: indexPath) as! MultiObservedBoardCell
        let blog = MultiObservedManager.shared.getBlog(indexPath.row)
        cell.configureID(blog?.id)
        return cell
    }
    
}
