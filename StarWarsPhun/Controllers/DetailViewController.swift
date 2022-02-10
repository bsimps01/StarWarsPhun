//
//  DetailViewController.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/9/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Variables
    var details: StarWarsDetails?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let descripLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.9
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    //MARK: - Initializers
    init(details: StarWarsDetails) {
        super.init(nibName: nil, bundle: nil)
        self.details = details
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up.fill"), style: .done, target: self, action: #selector(shareButton))
        navigationController?.navigationBar.tintColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(descripLabel)
        scrollView.addSubview(backgroundImageView)
        
//        guard let sharedDetails = details else { return }
//        let title = "\(sharedDetails.title)"
//        self.title = title
    }
    
    override func viewDidLayoutSubviews() {
        
        setupDVCLayout()
        swDataDetails()

    }
    
    //MARK: - Helper
    
    private func setImageGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = backgroundImageView.frame
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 1.0]
        backgroundImageView.layer.mask = gradient
    }
    
    private func swDataDetails(){
        scrollView.backgroundColor = .black
        if let details = details {
            dateLabel.text = details.date
            titleLabel.text = details.title
            locationLabel.text = details.location
            descripLabel.text = details.description
            backgroundImageView.image = details.image
        }
    }
    
    @objc private func shareButton() {
        
        //create the details instance
        guard let sharedDetails = details else { return }
        
        //extrapolate each item
        let item = "\(sharedDetails.title), \(sharedDetails.location), \(sharedDetails.date), \(sharedDetails.description), \(sharedDetails.image)"
        
        //create and present activity controller
        let activityController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        activityController.excludedActivityTypes = [ .addToReadingList, .airDrop, .addToReadingList, .assignToContact, .postToTwitter, .postToVimeo, .copyToPasteboard, .markupAsPDF, .openInIBooks, .print, .postToWeibo, .postToFlickr, .postToFacebook, .postToTencentWeibo]
        self.present(activityController, animated: true)
    
    }
    
    //MARK: - Constraints
    private func setupDVCLayout() {
        
        //Constraints for Details
        
        //Initiates Scrollview in the frame
        scrollView.frame = view.frame
        
        //adds level of gradient to image
        setImageGradient()
        
        //date label
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24).isActive = true
        dateLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 212).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24).isActive = true
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        //location
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24).isActive = true
        locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //description
        descripLabel.translatesAutoresizingMaskIntoConstraints = false
        descripLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24).isActive = true
        descripLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24).isActive = true
        descripLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8).isActive = true
        descripLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        //background image
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant: view.bounds.height/2).isActive = true
            
    }
    
    
}
