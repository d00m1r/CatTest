//
//  TableViewDataSource.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import UIKit

final class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {

    typealias CellConfigurator = (Model, Cell) -> Void

    var models: [Model]

    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model, cell as! Cell)
        
        return cell
    }

}


