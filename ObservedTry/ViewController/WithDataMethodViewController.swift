//
//  WithDataMethodViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit

/**
 MVC 架構 - 命令式編成方式
 model: 處理 Data 相關處理 ，直接與VC 溝通
 DataModel: 自帶部分 API Request 處理Method
 API  Request 處理結束 透過 delegate 回傳更新畫面命令
 */
class WithDataMethodViewController: UIViewController {
    
    private lazy var model: WithDataMethodModel = {
        let vm = WithDataMethodModel()
        vm.delegate = self
        return vm
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(NormalBoardCell.self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "OldViewController"
    }

}

extension WithDataMethodViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

extension WithDataMethodViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.blogs.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalBoardCell.description(), for: indexPath) as! NormalBoardCell
        
        guard model.blogs.indices.contains(indexPath.row) else { fatalError("Row is Out of range") }
        
        let blog = model.blogs[indexPath.row]
        
        cell.indexPath = indexPath
        
        cell.titleLabel.text = blog.id
        
        cell.countLabel.text = String(blog.count)
        
        cell.toggleColor(blog.toggle)
        
        cell.delegate = self
        return cell
    }
    
}

// MARK: NormalBoardCellDelegate
extension WithDataMethodViewController: NormalBoardCellDelegate {
    
    func add(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        model.add(indexPath: indexPath)
    }
    
    func subtract(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        model.subtract(indexPath: indexPath)
    }
    
    func toggle(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        model.toggle(indexPath: indexPath)
    }
    
}

// MARK: TableViewModelDelegate
extension WithDataMethodViewController: TableViewModelDelegate {
    
    func reload(indexPaths: [IndexPath]?, isReloadAll: Bool) {
        if let indexPaths = indexPaths {
            tableView.reloadRows(at: indexPaths, with: .automatic)
            return
        }
        
        if isReloadAll {
            tableView.reloadData()
        }
    }
    
}
