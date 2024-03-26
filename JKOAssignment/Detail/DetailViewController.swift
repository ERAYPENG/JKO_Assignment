//
//  DetailViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/23.
//

import UIKit

protocol CartActionDelegate: AnyObject {
    func didAddToCart(item: ProductItem)
    func didDeleteFromCart(item: ProductItem)
}

class DetailViewController: UIViewController {
    private var item: ProductItem
    private var quantityCount: Int = 1
    weak var delegate: CartActionDelegate?
    
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
        t.isEditable = false
        t.isSelectable = false
        t.textContainer.lineFragmentPadding = 10
        return t
    }()
    private lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    private lazy var quantityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "數量 : 1"
        return lbl
    }()
    private lazy var quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 99
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        return stepper
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
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
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
        self.view.addSubview(quantityStepper)
        self.view.addSubview(quantityLabel)
        self.view.addSubview(addToCartButton)
        self.view.addSubview(buyNowButton)
        self.imageView.addSubview(activityIndicator)
        
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
            make.height.greaterThanOrEqualTo(100)
        }
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.descriptionTextView.snp.bottom).offset(10)
            make.height.greaterThanOrEqualTo(50)
            make.leading.trailing.equalToSuperview()
        }
        self.quantityStepper.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        self.quantityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.quantityStepper)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(self.quantityStepper)
        }
        self.addToCartButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.quantityStepper.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        self.buyNowButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.addToCartButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    func setupItem() {
        self.nameLabel.text = self.item.name
        self.priceLabel.text = String(self.item.price)
        
        let numberOfCopies = 5
        var finalDescription = ""
        for _ in 1 ... numberOfCopies {
            finalDescription += self.item.description + "\n"
        }
        
        self.descriptionTextView.text = finalDescription
        if let url = URL(string: self.item.imageUrlStr) {
            self.downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
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

// MARK: Action
extension DetailViewController {
    @objc func addToCartButtonTapped() {
        self.item.count = self.quantityCount
        self.delegate?.didAddToCart(item: self.item)
        self.showToast(message: "成功") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @objc func buyNowButtonTapped() {
        self.item.count = self.quantityCount
        let vc = CheckoutViewController(items: [self.item], isCheckoutDirectly: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func stepperValueChanged(sender: UIStepper) {
        let stepperValue = Int(sender.value)
        self.quantityCount = stepperValue
        self.quantityLabel.text = "數量 : \(stepperValue)"
    }
}
