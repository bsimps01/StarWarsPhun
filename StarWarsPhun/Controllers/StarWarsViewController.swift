//
//  ViewController.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/8/22.
//

import UIKit

class StarWarsViewController: UIViewController {
    
    //MARK: - Variables
    
    var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cv.register(StarWarsCollectionViewCell.self, forCellWithReuseIdentifier: "StarWarsCollectionCell")
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    let starWarsVM = StarWarsVM()
    let device = UIDevice.current
    let apiCall = APICall()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        self.navigationItem.title = "Star Wars Phun"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        
        //collectionViewSetup()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        
        //invalidate layout on orientation change
        collectionView.collectionViewLayout.invalidateLayout()
        
        //contraints
        collectionViewSetup()
        
    }
    
    //MARK: - Helper
    func collectionViewSetup(){
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if let navbar = self.navigationController {
            collectionView.topAnchor.constraint(equalTo: navbar.navigationBar.bottomAnchor).isActive = true
        } else {
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
        
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func fetchData() {
        starWarsVM.loadData {
            if starWarsVM.showStarWarsInfo.isEmpty {
                starWarsVM.fetchDetailsData {
                    DispatchQueue.main.async {
                        self.starWarsVM.saveData()
                        self.collectionView.reloadData()
                    }
                }
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    
    func phoneOrientationType() -> CGFloat {
        
        var phoneOrientation: CGFloat {
            if device.orientation.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
                }
            }
            if device.userInterfaceIdiom == .pad {
                return phoneOrientation * 0.4
            } else {
                return phoneOrientation * 0.9
            }
        }
    
    
    //MARK: - APICalls

}

//MARK: - Extension
extension StarWarsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starWarsVM.showStarWarsInfo.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarWarsCollectionCell", for: indexPath) as! StarWarsCollectionViewCell
        let details = starWarsVM.showStarWarsInfo[indexPath.item]
        cell.configureCell(swDetails: details)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = phoneOrientationType()
        let itemSize = CGSize(width: width, height: 212)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //transitions to new view controller
        let details = starWarsVM.showStarWarsInfo[indexPath.item]
        let detailVC = DetailViewController(details: details)
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //checks edges of the screen
        let screenWidth = UIScreen.main.bounds.width
        let left = screenWidth * 0.05
        let right = screenWidth * 0.05
        let inset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        
        return inset
    }
    
}

