//
//  WinePairingViewController.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/15/21.
//

import UIKit
import Combine

class WinePairingViewController: UIViewController, UISearchBarDelegate {
    let searchController = UISearchController()
    
    @IBOutlet weak var winePairingDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productMatchesTableView: UITableView!
    @IBOutlet weak var searchText: UILabel!
    @IBOutlet weak var pairedWinesLabel: UILabel!
    @IBOutlet weak var ourOpinionLabel: UILabel!
    @IBOutlet weak var chooseYourWineLabel: UILabel!
    
    var winePairingApi: WinePairingAPI? = nil
    private var cancelables = [AnyCancellable]()
    private var winePairing: WinePairingResponseModel? = nil {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.handleLoadedWinePairingResponse()
                if let winePairing = self?.winePairing {
                    self?.populateProductMatches(with: winePairing.productMatches)
                }
            }
        }
    }
    private var matchingWineNames = [String]()
    private var productMatches = [ProductDisplayModel]()
    private var searchBarPreviousValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.placeholder = "Enter your dish, food ingredient or cuisine"
        searchController.searchBar.delegate = self
        navigationItem.title = "Wine Pairing"
        navigationItem.searchController = searchController
        tableView.delegate = self
        productMatchesTableView.delegate = self
        tableView.dataSource = self
        productMatchesTableView.dataSource = self
        tableView.isHidden = tableView.numberOfRows(inSection: 0) == 0 ? true : false
        productMatchesTableView.isHidden = productMatchesTableView.numberOfRows(inSection: 0) == 0 ? true : false
        pairedWinesLabel.isHidden = true
        ourOpinionLabel.isHidden = true
        chooseYourWineLabel.isHidden = true
        searchText.isHidden = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        if searchText != searchBarPreviousValue {
            searchBarPreviousValue = searchText
            self.searchText.text = searchText
        } else {
            return
        }
        
        matchingWineNames = [String]()
        productMatches = [ProductDisplayModel]()
        
        winePairingApi?.getWines(for: searchText).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                print("failed loadig the wine pairings \(error)")
            case .finished:
                print("finished loadig the wine pairings")
            }
        } receiveValue: { [weak self] response in
            self?.winePairing = response
            DispatchQueue.main.async {
                self?.pairedWinesLabel.isHidden = false
                self?.ourOpinionLabel.isHidden = false
                self?.chooseYourWineLabel.isHidden = false
                self?.searchText.isHidden = false
            }
        }
        .store(in: &cancelables)
    }
}


extension WinePairingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productMatchesTableView {
            return productMatches.count
        } else {
            return matchingWineNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productMatchesTableView {
            let item = productMatches[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "productMatchCell") as! ProductMatchTableViewCell
            cell.setItem(from: item)
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
            cell.productImage.addGestureRecognizer(recognizer)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pairedWine", for: indexPath)
            cell.textLabel!.text = matchingWineNames[indexPath.row]
            
            return cell
        }
    }
    
    // MARK: - private
    
    private func handleLoadedWinePairingResponse() {
        winePairingDescriptionLabel.text = winePairing?.pairingText
        matchingWineNames = winePairing?.pairedWines.map { $0.capitalizingFirstLetter() } ?? []
        tableView.reloadData()
        tableView.isHidden = tableView.numberOfRows(inSection: 0) == 0 ? true : false
    }
    
    private func populateProductMatches(with products: [ProductModel]) {
        for productMatch in products {
            self.loadImage(from: productMatch.imageUrl) { [weak self] imageData in
                guard let strongSelf = self else {
                    return
                }
                let productImage = strongSelf.presentedImage(from: imageData)
                let productDisplayModel = ProductDisplayModel(title: productMatch.title,
                                                              description: productMatch.description,
                                                              price: productMatch.price,
                                                              image: productImage,
                                                              link: productMatch.link)
                
                self?.productMatches.append(productDisplayModel)
                DispatchQueue.main.async {
                    self?.productMatchesTableView.reloadData()
                    self?.productMatchesTableView.isHidden = self?.productMatchesTableView.numberOfRows(inSection: 0) == 0 ? true : false
                }
            }
            
        }
        
    }
    
    private func loadImage(from imageURl: String, loadedHandler: @escaping (Data) -> Void) {
        guard let url = URL(string: imageURl) else {
            return
        }
        winePairingApi?.getImageData(from: url).sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
                print("failed loadig the image data \(error)")
            case .finished:
                print("finished loadig the image data")
            }
        } receiveValue: { response in
            loadedHandler(response)
        }
        .store(in: &cancelables)
    }
    
    private func presentedImage(from imageData: Data) -> UIImage {
        if let image = UIImage(data: imageData) {
            return image
        } else {
            return UIImage(#imageLiteral(resourceName: "winePlaceholder"))
        }
    }
    
    @objc private func imageTapped(_ gesture: UILongPressGestureRecognizer){
        let tapLocation = gesture.location(in: self.productMatchesTableView)
            if let tapIndexPath = self.productMatchesTableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.productMatchesTableView.cellForRow(at: tapIndexPath) as? ProductMatchTableViewCell {
                    guard let url = URL(string: tappedCell.productUrl) else { return }
                    UIApplication.shared.open(url)
                }
        }
    }
}
