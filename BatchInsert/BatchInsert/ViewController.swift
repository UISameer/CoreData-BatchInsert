import UIKit

class ViewController: UIViewController {

    var apis : Array<Api>? = nil
    private let apiViewmodel = ApiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiViewmodel.getApiRecords {[weak self] apiRecords in
            DispatchQueue.main.async {
                if(apiRecords != nil && apiRecords?.count != 0){
                    self?.apis = apiRecords
                }
            }
        }
    }


}

