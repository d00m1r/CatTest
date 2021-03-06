//
//  CatTVC.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 04.11.2021.
//

import UIKit

final class CatTVC: UITableViewCell {
    
    //MARK: - Properties
    private let service = CatNetworkService()
    public var catInfo: Cat? {
        didSet{
            configurate()
        }
    }
    
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Const.font
        label.backgroundColor = UIColor.tertiarySystemFill
        label.textAlignment = .center
        return label
    }()
    
    private var catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.secondarySystemFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [catImageView, titleLabel])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = Const.CatTVC.padding
        catImageView.setAnchor(height: Const.CatTVC.imageHeight)
        return stack
    }()
    
    private let loadImageQueue = DispatchQueue(label: "imageLoadQueue", qos: .userInitiated, attributes: .concurrent)
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(stackView)
        stackView.setAnchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            paddingRight: Const.CatTVC.padding
        )
    }
    
    private func configurate(){
        guard
            let catInfo = catInfo,
            let width = catInfo.width,
            let height = catInfo.height
        else {
            return
        }
        self.titleLabel.text = "\(width) x \(height)"
        self.catImageView.image = UIImage(named: "placeholder")!
        loadImageQueue.async { [weak self] in
            self?.loadImage()
        }
    }
    
    private func loadImage(){
        guard
            let catInfo = catInfo,
            let url = URL(string: catInfo.url)
        else {
            return
        }
        
        service.loadCatImage(url: url) { image in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                UIView.transition(with: strongSelf.catImageView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    strongSelf.catImageView.image = image
                }, completion: nil)
                
//                self?.catImageView.image = image
            }
        }
    }
}
