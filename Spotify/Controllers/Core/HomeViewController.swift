//
//  ViewController.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action:#selector(didTapSettings))
        fetchData()
    }
    
    private func fetchData() {
        ApiCaller.shared.getRecomendedGenres { result in
           
                switch result {
                case .success(let model):
                    let genres = model.genres
                    var seeds = Set<String>()
                    while seeds.count < 5 {
                        if let random = genres.randomElement() {
                            seeds.insert(random)
                        }
                    }
                    
                    ApiCaller.shared.getRecomendations(genres: seeds) { _ in
                        
                    }
                    self.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                    self.errorFetchData()
                }
            
        }
    }
    
    private func updateUI() {
        
    }
    
    private func errorFetchData() {
        let label = UILabel()
        label.text = "Error loading"
        label.tintColor = .label
        label.sizeToFit()
        view.addSubview(label)
        label.center = view.center
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

