//
//  ViewController.swift
//  GetBasis_swipeable
//
//  Created by TalentMicro on 21/04/20.
//  Copyright © 2020 GetBasis. All rights reserved.
//

import UIKit
import Koloda
class MySwipeableViewController: UIViewController {
@IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var lblCount: UILabel!
    var images = [UIImage]()
    var dataList:[MySwipableModelData]?
    var dataObj = MySwipableModel()
    var urlString = "https://gist.githubusercontent.com/anishbajpai014/d482191cb4fff429333c5ec64b38c197/raw/b11f56c3177a9ddc6649288c80a004e7df41e3b9/HiringTask.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        lblCount.alpha = 0
        kolodaView?.countOfVisibleCards = 1
        getData()
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Button Actions
    
    @IBAction func btnPre(_ sender: Any) {
       
        //kolodaView?.swipe(.left)
        kolodaView?.revertAction()
    }
    
    @IBAction func btnNext(_ sender: Any) {
         kolodaView?.swipe(.right)
    }
    
   // MARK:- ApiCall
    
    func getData(){
        APIClass.apiInstance.getApi(urlString: self.urlString,model:MySwipableModel.self){ result in
            switch result {
                case .success(let posts):
                    print(posts)
                    self.dataList = posts.data
                    DispatchQueue.main.async {
                        self.kolodaView.reloadData()
                        if self.dataList?.count ?? 0 > 0 {
                         self.lblCount.alpha = 1
                           
                        }
                    }
                   
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    


}

 // MARK:- KolodaView Delegate Methods

extension MySwipeableViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
    }
}
extension MySwipeableViewController: KolodaViewDataSource {

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return dataList?.count ?? 0
       
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
           return true
       }
       
       func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
           return false
       }
       
       func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
          
           return true
       }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
       
        return .moderate
    }
    
    

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cardView:UIView = UIView()
        cardView.backgroundColor = UIColor.white
        cardView.frame = kolodaView.frame
        cardView.dropShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0.5, height: 0.5), radius: 0.5, scale: false)
        
        let label = UILabel(frame: CGRect(x: 10, y: 20, width: cardView.frame.width-10, height: cardView.frame.height-10))
      //  label.center = CGPoint(x: 160, y: 285)
      //  label.textAlignment = .center
        label.text = dataList?[index].text ?? ""
        label.font = UIFont(name: "Muli-Light", size: 25)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.sizeToFit()
        cardView.addSubview(label)
         self.lblCount.text = "\(index+1) / \(kolodaView?.countOfCards ?? 0)"
        print("Index:::::\(index)")
        return cardView
    }

    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? CustomOverlayView
    }
}
