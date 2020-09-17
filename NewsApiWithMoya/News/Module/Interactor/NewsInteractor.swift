//
//  NewsInteractor.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 02/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class NewsInteractor: NewsPresenterToInteractorProtocol {
    func fetchNews(q: String, from: String, sortBy: String, apiKey: String) {
        newsNetworkProvider.request(.news(q: q, from: from, sortBy: sortBy, apiKey: apiKey)) { (result) in
            
            switch result{
            case .success(let value):
                do{
                   
                    let newsData = try JSONDecoder().decode(NewsModel.self, from: value.data)
                    
                    self.presenter?.newsListFethedSucces(data: newsData.articles ?? [])
                    
                }catch (let error){
                    self.presenter?.newsListFetchedFailed(message: error.localizedDescription)
                    
                }
            case .failure(let error):
                self.presenter?.newsListFetchedFailed(message: error.localizedDescription)
                
            }
        }
    }
    
    var presenter: NewsInteractorToPresenterProtocol?
    
}
