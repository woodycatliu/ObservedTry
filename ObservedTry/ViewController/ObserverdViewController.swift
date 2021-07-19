//
//  ViewController.swift
//  ObservedTry
//
//  Created by Woody Liu on 2021/7/18.
//

import UIKit


/**
 MVC 架構: 反應式編成方式
 - 請參考[Wiki](https://zh.wikipedia.org/wiki/%E5%93%8D%E5%BA%94%E5%BC%8F%E7%BC%96%E7%A8%8B) 解釋
 
 
 
#### BoardViewModel:
 - ObservedBoardCell ViewModel
 - 利用 didSet 實現反應式編成，實現與 CurrentValueSubject 類似的觀察模式。
 - 參考文章 [30 天了解 Swift 的 Combine](https://developer.apple.com/documentation/combine/currentvaluesubject)
 - Apple SDK [CurrentValueSubject](https://developer.apple.com/documentation/combine/currentvaluesubject)
 
 */
class ObserverdViewController: UIViewController {
    
    private lazy var cellViewModels: [BoardViewModel] = {
        var arr: [BoardViewModel] = []
        for _ in 1...30 {
            arr.append(BoardViewModel())
        }
        return arr
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(ObservedBoardCell.self)
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
        title = "ObserverdViewController"
    }
}


extension ObserverdViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}

extension ObserverdViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ObservedBoardCell.description(), for: indexPath) as! ObservedBoardCell
        guard cellViewModels.indices.contains(indexPath.row) else { fatalError("Row is Out of range") }

        cell.viewModel = cellViewModels[indexPath.row]
        return cell
    }
    
}
