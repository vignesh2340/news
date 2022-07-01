//
//  HomeViewController.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var mostPapularNews: MostPapularNews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContent()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return mostPapularNews?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getMostPapularNews(to: tableView, at: indexPath)
        } else {
            return getOtherNews(to: tableView, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        if let news = mostPapularNews?.results?[indexPath.row] {
            redirectToWebView(with: news)
        }
    }
    
    func getMostPapularNews(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let mostPapularNews = mostPapularNews else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrontPageNewsTableViewCell", for: indexPath) as! FrontPageNewsTableViewCell
        cell.setViewContent(with: mostPapularNews)
        cell.delegate = self
        return cell
    }
    
    func getOtherNews(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        guard let news = mostPapularNews?.results?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherNewsTableViewCell", for: indexPath) as! OtherNewsTableViewCell
        cell.setViewContent(with: news)
        return cell
    }
}

extension HomeViewController: FrontPageNewsTableViewCellDelegate {
    
    func openWebView(with news: PapularNews) {
        redirectToWebView(with: news)
    }
    
}


extension HomeViewController {
    
    func fetchMostPapularNews() {
        ServiceAPI.getInstance().getMostPapularNews(url: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=KAAY7wAjsXKlTUpWlLpfs80BRs3dktnN") { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                UIUtils.showDefaultAlertView(withTitle: "ALERT", message: error.message)
            } else if let mostPapularNews = result {
                self.mostPapularNews = mostPapularNews
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
        }
    }
    
}

extension HomeViewController {
    
    func setViewContent() {
        title = "NEWS"
        setHomeTableView()
        fetchMostPapularNews()
    }
    
    func setHomeTableView() {
        newsTableView.register(UINib(nibName: "FrontPageNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "FrontPageNewsTableViewCell")
        newsTableView.register(UINib(nibName: "OtherNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherNewsTableViewCell")
        newsTableView.estimatedRowHeight = 300
        newsTableView.rowHeight = UITableView.automaticDimension
    }
    
    func redirectToWebView(with news: PapularNews) {
        let webView = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webView.news = news
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}

