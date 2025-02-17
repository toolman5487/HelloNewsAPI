//
//  ViewController.swift
//  HelloNewsAPI
//
//  Created by Willy Hsu on 2025/1/13.
//

import UIKit
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titlePicture: UIImageView!
    // 儲存新聞資料的陣列
    var articles = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        titlePicture.layer.cornerRadius = 10
        titlePicture.clipsToBounds = true
        
        fetchNews() // 呼叫 API 抓取新聞資料
    }
    
    func fetchNews() {
        APIModel.share.queryHeadlinesNews { data, error in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            if data != nil {
                // 使用 SwiftyJSON 解析資料
                let json = JSON(data!)
                let allArticles = json["articles"].arrayValue
                
                if allArticles.count > 0 {
                    // 顯示第一篇文章
                    let firstArticle = allArticles[0]
                    DispatchQueue.main.async {
                        self.titleLabel.text = firstArticle["title"].stringValue
                        self.contentLabel.text = firstArticle["content"].stringValue
                        // 設定圖片
                        if let imageUrl = firstArticle["urlToImage"].string, let url = URL(string: imageUrl) {
                            self.titlePicture.sd_setImage(with: url, completed: nil)
                        } else {
                            self.titlePicture.image = UIImage(named: "placeholder") // 設定預設圖片
                        }
                    }
                    
                    // 儲存其餘的文章
                    for i in 1..<allArticles.count {
                        self.articles.append(allArticles[i])
                    }
                    
                    // 更新表格
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("No articles found.")
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count // 返回其餘新聞數量
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        
        // 獲取對應的文章
        let article = articles[indexPath.row]
        
        // 設定 cell 的文字 (顯示文章的描述)
        cell.textLabel?.text = article["description"].stringValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "每日新聞"
    }
}
