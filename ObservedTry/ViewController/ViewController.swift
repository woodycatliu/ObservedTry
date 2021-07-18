//
//  ViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

class ViewController: UIViewController {
    
    enum RowType: Int, CaseIterable, CustomStringConvertible {
        
        case old, withDataMethod, observed
        
        var viewController: UIViewController {
            switch self {
            case .old:
                return OldViewController()
            case .withDataMethod:
                return WithDataMethodViewController()
            case .observed:
                return ObserverdViewController()
            }
        }
        
        var description: String {
            switch self {
            case .old:
                return "old"
            case .withDataMethod:
                return "withDataMethod"
            case .observed:
                return "observed"
            }
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(UITableViewCell.self)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = RowType.init(rawValue: indexPath.row) else { return }
        navigationController?.pushViewController(type.viewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowType.allCases.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        guard let type = RowType.init(rawValue: indexPath.row) else { fatalError("Row is Our of range") }
        cell.textLabel?.text = type.description
        cell.textLabel?.font = .systemFont(ofSize: 25)
        cell.textLabel?.textColor = .blue
        return cell
    }
    
}
