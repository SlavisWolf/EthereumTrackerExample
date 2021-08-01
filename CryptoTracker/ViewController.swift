//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Zapp Antonio on 1/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data: CryptoCoinData?
    var viewModels = [CryptoTableViewCellViewModel]()
    
    static let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale =  Locale(identifier: "en_US")
        return formatter
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    static let dateISO8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CryptoCell.self, forCellReuseIdentifier: CryptoCell.identifier)
        
        title = "Ethereum tracker"
        fetchData()
    }

    private func createHeaderTable() {
        guard let price = data?.quote["USD"]?.price else {return}
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.width / 2)))
        header.clipsToBounds = true
        
        //Image
        let imageView = UIImageView(image: UIImage(named: "ethereum"))
        let size = view.frame.size.width / 2
        imageView.contentMode = .scaleAspectFit
        imageView.isOpaque = false
        imageView.frame = CGRect(x: (view.frame.width - size) / 2, y: 16, width: size, height: size / 2)
        header.addSubview(imageView)
        
        //Price label
        let label = UILabel()
        label.text =  Self.formatter.string(from: NSNumber(value: price))
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.frame = CGRect(x: 10, y: 8 + (size / 2), width: view.frame.width - 20, height: 120)
        header.addSubview(label)
        
        tableView.tableHeaderView = header
    }
    
    private func fetchData() {
        ApiManager.shared.getEthereumData({
                switch($0) {
                    case .success(let data):
                        self.data = data
                        DispatchQueue.main.async {self.setUpViewModels()}
                    case .failure(let error):
                        print(error)
            }
        })
    }
    
    private func setUpViewModels() {
        guard let data = data, let date = Self.dateISO8601Formatter.date(from: data.date_added) else {
            return
        }
        createHeaderTable()
        
        viewModels = [
            CryptoTableViewCellViewModel(title: "Name:", value: data.name),
            CryptoTableViewCellViewModel(title: "Symbol:", value: data.symbol),
            CryptoTableViewCellViewModel(title: "Identifier:", value: String(data.id) ),
            CryptoTableViewCellViewModel(title: "Date Added:", value: Self.dateFormatter.string(from: date)),
            CryptoTableViewCellViewModel(title: "Total supply:", value: String(data.total_supply) ),
        ]
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCell.identifier, for: indexPath) as? CryptoCell else {fatalError()}
        cell.configure(viewModels[indexPath.row])
        return cell
    }
}

