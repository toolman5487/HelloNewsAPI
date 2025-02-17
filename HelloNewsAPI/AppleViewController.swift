import UIKit
import SwiftyJSON

class AppleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var articles = [JSON]() // 儲存文章資料
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        fetchNews() // 抓取新聞
    }
    
    func fetchNews() {
        APIModel.share.queryAppleNews { data, error in
            if let error = error {
                let alert = UIAlertController(title: "錯誤", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .default))
                self.present(alert, animated: true)
                return
            }
            
            if let data = data {
                let json = JSON(data)
                self.articles = json["articles"].arrayValue
                DispatchQueue.main.async {
                    self.tableView.reloadData() // 重新載入 TableView
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension AppleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppleTableViewCell", for: indexPath) as? AppleTableViewCell else {
            fatalError("Unable to dequeue AppleTableViewCell")
        }
        
        let article = articles[indexPath.row]
        cell.appleNewsLabel?.text = article["description"].stringValue
        
        return cell
    }
}
