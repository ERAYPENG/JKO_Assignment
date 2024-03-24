//
//  DetailViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/23.
//

import UIKit

protocol AddToCartDelegate: AnyObject {
    func didAddToCart(item: ProductItem)
}

class DetailViewController: UIViewController {
    private var item: ProductItem
    weak var delegate: AddToCartDelegate?
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    private lazy var descriptionTextView: UITextView = {
        let t = UITextView()
        return t
    }()
    private lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    private lazy var addToCartButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemOrange
        btn.setTitle("加入購物車", for: .normal)
        btn.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        return btn
    }()
    private lazy var buyNowButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("直接購買", for: .normal)
        btn.addTarget(self, action: #selector(buyNowButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    init(item: ProductItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItem()
        self.setupUI()
    }
}

// MARK: UI
private extension DetailViewController {
    func setupUI() {
        self.view.backgroundColor = .systemGroupedBackground
        self.title = "商品詳情"
        self.view.addSubview(nameLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(descriptionTextView)
        self.view.addSubview(imageView)
        self.view.addSubview(addToCartButton)
        self.view.addSubview(buyNowButton)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        self.priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }
        self.descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(30)
        }
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.addToCartButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        self.buyNowButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.addToCartButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    func setupItem() {
        self.nameLabel.text = self.item.name
        self.priceLabel.text = String(self.item.price)
        self.descriptionTextView.text = self.item.description
        if let url = URL(string: self.item.imageUrlStr) {
            self.downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Could not decode image")
                completion(nil)
            }
        }
        task.resume()
    }
}

extension DetailViewController {
    @objc func addToCartButtonTapped() {
        self.delegate?.didAddToCart(item: item)
        self.navigationController?.popViewController(animated: true)
    }
    @objc func buyNowButtonTapped() {
        let itemsDict: ItemsDict = [self.item: 1]
        let vc = CheckoutViewController(itemsDict: itemsDict)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
