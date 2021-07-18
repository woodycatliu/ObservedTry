//
//  OldViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit


/**
 MVVM 架構 - 命令式編成方式
 ViewModel: 作為 ViewController 與 Model 橋樑
 Model:  與 APIManager Model 溝通 處理 API Request
 
 API  Request 處理結束 透過 delegate 回傳更新畫面命令
 */
class OldViewController: UIViewController {
    
    private lazy var viewModel: OldViewModel = {
        let vm = OldViewModel()
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

extension OldViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

extension OldViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blogs.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NormalBoardCell.description(), for: indexPath) as! NormalBoardCell
        
        guard viewModel.blogs.indices.contains(indexPath.row) else { fatalError("Row is Out of range") }
        
        let blog = viewModel.blogs[indexPath.row]
        
        cell.indexPath = indexPath
        
        cell.titleLabel.text = blog.id
        
        cell.countLabel.text = String(blog.count)
        
        cell.toggleColor(blog.toggle)
        
        cell.delegate = self
        return cell
    }
    
}

// MARK: NormalBoardCellDelegate
extension OldViewController: NormalBoardCellDelegate {
    
    func add(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        viewModel.add(indexPath: indexPath)
    }
    
    func subtract(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        viewModel.subtract(indexPath: indexPath)
    }
    
    func toggle(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        viewModel.toggle(indexPath: indexPath)
    }
    
}

// MARK: TableViewModelDelegate
extension OldViewController: TableViewModelDelegate {
    
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
