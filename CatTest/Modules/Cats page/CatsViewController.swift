//
//  CatsViewController.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import UIKit

final class CatsViewController: UIViewController {
    
    //MARK: - Properties
    private let viewModel: CatsViewModel
    private let tableView = UITableView()
    private var dataSource: TableViewDataSource<Cat, CatTVC>?

    //MARK: - Life cycle
    init(viewModel: CatsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIUpdate()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchCats()
    }
    
    private func bindUIUpdate(){
        viewModel.bindViewModelToController = { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.dataSource = TableViewDataSource(
                    models: strongSelf.viewModel.getCats(),
                    reuseIdentifier: CatTVC.typeName
                ) { cat, cell in
                    cell.catInfo = cat
                }
                
                strongSelf.tableView.dataSource = strongSelf.dataSource
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(tableView)
    
        tableView.register(CatTVC.self, forCellReuseIdentifier: CatTVC.typeName)
        tableView.delegate = self
        
        tableView.setAnchor(
            top: view.safeTopAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeBottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Const.topBottomPadding,
            paddingLeft: Const.leadingTrailingPadding,
            paddingRight: Const.leadingTrailingPadding
        )
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//      let isReachingEnd = scrollView.contentOffset.y >= 0
//          && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
//        print("END")
//    }


}

//MARK: - UITableViewDelegate
extension CatsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cat = viewModel.getCats()[indexPath.row]
//        if cat.breeds.isEmpty{
//            return
//        }
        let vc = CatDetailViewController(cat: cat)
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == viewModel.getCats().count {
            viewModel.fetchCats()
        }
    }
}
