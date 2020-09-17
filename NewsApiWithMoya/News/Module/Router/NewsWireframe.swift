//
//  NewsWireframe.swift
//  NewsApiWithMoya
//
//  Created by Lawencon on 02/09/20.
//  Copyright © 2020 Lawencon. All rights reserved.
//

import Foundation
import UIKit

class NewsWireframe: NewsPresenterToWireframeProtocol {
    static func createModule(news: NewsViewController) {
        let presenter : NewsViewToPresenterProtocol & NewsInteractorToPresenterProtocol = NewsPresenter()
        news.presenter = presenter
        news.presenter?.router = NewsWireframe()
        news.presenter?.view = news
        news.presenter?.interactor = NewsInteractor()
        news.presenter?.interactor?.presenter = presenter
    }
    
}
