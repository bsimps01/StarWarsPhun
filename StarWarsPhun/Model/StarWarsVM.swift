//
//  StarWarsVM.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/9/22.
//

import Foundation
import UIKit
import CoreData

class StarWarsVM {
    
    //MARK: - Variables
    let apiCall = APICall()
    var showStarWarsInfo: [StarWarsDetails] = []
    let dispatchGroup = DispatchGroup()
    let context = (UIApplication.shared.delegate as! AppDelegate).storeContainer.viewContext
    
    //MARK: - CoreData
    private func formatSWEData(swEData: StarWarsEventData) {
        
        let placeholderImage = UIImage(named: "placeholder_nomoon")
        let title = swEData.starWarsTitle ?? "No Title"
        let description = swEData.starWarsDescription ?? "No Description"
        let date = swEData.starWarsDate ?? "Date Unavailable"
        let image = UIImage(data: swEData.starWarsImage!) ?? placeholderImage
        let location = swEData.starWarsLocation ?? "Location Unavailable"
        let event = StarWarsDetails(title: title, description: description, date: date, location: location, image: image!)
        showStarWarsInfo.append(event)
    }
    
    func loadData(completion: ()->Void) {
        //Loads what is Stored in CD
        let request: NSFetchRequest<StarWarsEventData> = StarWarsEventData.fetchRequest()
        var events: [StarWarsEventData] = []
        
        do {
            events = try context.fetch(request)
            if !events.isEmpty {
                events.forEach { event in
                    formatSWEData(swEData: event)
                }
            }
        } catch {
            print("Error retrieving: \(error)")
        }
        completion()
    }
    
    func saveData() {
        //Saves data in CD
        var eventData: [StarWarsEventData] = []
        
        if !showStarWarsInfo.isEmpty {
            showStarWarsInfo.forEach { event in
                let item = StarWarsEventData(context: context)
                item.starWarsTitle = event.title
                item.starWarsDate = event.date
                item.starWarsLocation = event.location
                item.starWarsDescription = event.description
                item.starWarsImage = event.image.pngData()
                eventData.append(item)
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
        
    }
    
    //MARK: - APIFormatted
    private func starWarsFormattedInfo(swData: StarWarsData) {
        //Checks if info is missing or not
        let placeholderImage = UIImage(named: "placeholder_nomoon")
        let title = swData.title ?? "No Title"
        let description = swData.description ?? "No Description"
        let date = formatSWDates(dateString: swData.date)
        let image = getImageFromURLS(url: swData.image) ?? placeholderImage
        let location = "\(swData.locationline1 ?? "Missing Location"), \(swData.locationline2 ?? "Missing Location")"
        let event = StarWarsDetails(title: title, description: description, date: date, location: location, image: image!)
        showStarWarsInfo.append(event)
        
    }
    
    private func formatSWDates(dateString: String?) -> String {
        //Sets the time and date
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = dateFormatter.date(from: dateString!) else {
            return "Date Unavailable"
        }
    
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let formatDate = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "h:mm a"
        let formateTime = dateFormatter.string(from: date)
        
        return "\(formatDate) at \(formateTime)"
    }
    
    func getImageFromURLS(url: String?) -> UIImage? {
        //pulls Star Wars image
        guard let baseURL = url else { return nil }
        guard let imageURL = URL(string: baseURL) else { return nil }
        if let data = try? Data(contentsOf: imageURL) {
            return UIImage(data: data)!
        } else {
            return nil
        }
        
    }
    
    func fetchDetailsData(completion: @escaping () -> Void) {
        //Gets Star Wars Details
        apiCall.fetchStarWarsData { details, error in
            
            if let details = details {
                details.forEach { apiEvent in
                    self.dispatchGroup.enter()
                        self.starWarsFormattedInfo(swData: apiEvent)
                    self.dispatchGroup.leave()
                }
                self.dispatchGroup.notify(queue: .main) {
                    completion()
                }
            }
            if error != nil {
                completion()
            }
        }
    }
    
}
