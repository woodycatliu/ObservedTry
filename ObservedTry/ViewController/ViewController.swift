//
//  ViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

typealias TypeNeed = RowType & CustomStringConvertible
protocol RowType {
    var viewController: UIViewController { get }
    static var count: Int { get }
}

class ViewController: UIViewController {
    
    enum SectionType: Int, CaseIterable, CustomStringConvertible {

        case single, multitude
        
        var description: String {
            switch self {
            case .single:
                return "One To One"
            case .multitude:
                return "One To Many"
            }
        }
        
        func getRowType(_ row: Int)-> TypeNeed? {
            switch self {
            case .single:
                return SingleType.init(rawValue: row)
            case .multitude:
                return MultiType.init(rawValue: row)
            }
        }
        
        var rowCount: Int {
            switch self {
            case .single:
                return SingleType.allCases.count
            case .multitude:
                return MultiType.allCases.count
            }
        }
        
    }
    
    enum SingleType: Int, TypeNeed, CaseIterable {
        
        case old
//        case withDataMethod
        case observed
        
        var viewController: UIViewController {
            switch self {
            case .old:
                return OldViewController()
//            case .withDataMethod:
//                return WithDataMethodViewController()
            case .observed:
                return ObserverdViewController()
            }
        }
        
        var description: String {
            switch self {
            case .old:
                return "old"
//            case .withDataMethod:
//                return "withDataMethod"
            case .observed:
                return "observed"
            }
        }
        
        static var count: Int {
            return SingleType.allCases.count
        }
    }
    
    enum MultiType: Int, TypeNeed, CaseIterable {
    
        case multiObserved, objcObserved
        
        var viewController: UIViewController {
            switch self {
            case .multiObserved:
                return MultiObservedViewController()
            case .objcObserved:
                return ObjcObservedViewController()
            }
        }
        
        var description: String {
            switch self {
            case .multiObserved:
                return "MultiObserved"
            case .objcObserved:
                return "ObjcObserved"
            }
        }
        
        static var count: Int {
            return MultiType.allCases.count
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sectionType = SectionType.init(rawValue: indexPath.section),
              let type = sectionType.getRowType(indexPath.row) else { return }
        navigationController?.pushViewController(type.viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionType.init(rawValue: section)?.description
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType.init(rawValue: section) else {
            fatalError("Missing Section Type")
        }
        return sectionType.rowCount
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        guard let sectionType = SectionType.init(rawValue: indexPath.section),
              let type = sectionType.getRowType(indexPath.row) else {
                  fatalError("Missing Row Type / Section Type")
              }
        cell.textLabel?.text = type.description
        cell.textLabel?.font = .systemFont(ofSize: 25)
        cell.textLabel?.textColor = .blue
        return cell
    }
    
}
