//
//  CatDetailViewController.swift
//  CatTest
//
//  Created by Damir Miniakhmetov on 05.11.2021.
//

import UIKit

final class CatDetailViewController: UIViewController{
    //MARK: - Properties
    private let cat: Cat
    private var prettyJSON: String?
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.secondarySystemFill
        return imageView
    }()

    private var textView: UITextView = {
        let textView = UITextView()
        textView.font = Const.font
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.justified
        return textView
    }()

    
    //MARK: - Life cycle
    init(cat: Cat){
        self.cat = cat
        super.init(nibName: nil, bundle: nil)
        self.prettyJSON = encodeCat()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("Deinit detail")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textView.text = prettyJSON
        
        view.addSubview(imageView)
        view.addSubview(textView)
        
        imageView.setAnchor(
            top: view.safeTopAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Const.topBottomPadding,
            paddingLeft: Const.leadingTrailingPadding,
            paddingRight: Const.leadingTrailingPadding,
            height: Const.detailImageHeight
        )
        
        textView.setAnchor(
            top: imageView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeBottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Const.topBottomPadding,
            paddingLeft: Const.leadingTrailingPadding,
            paddingBottom: -Const.topBottomPadding,
            paddingRight: Const.leadingTrailingPadding
        )
        
        loadCatImage()
        
    }
    
    private func loadCatImage(){
        guard let url = URL(string: cat.url) else {
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(named: "placeholder")!
            }
            return
        }
        CatNetworkService.shared.loadCatImage(url: url) { image in
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }
    
    private func encodeCat() -> String{
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let jsonData = try encoder.encode(cat)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? "Encoding error"
            return jsonString
        } catch {
            return error.localizedDescription
        }
    }
    
}
