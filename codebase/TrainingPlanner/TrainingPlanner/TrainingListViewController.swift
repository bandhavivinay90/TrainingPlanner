//
//  TrainingListViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-22.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class TrainingListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var trainingTableView:UITableView!
    let reuseIdentifier = "TrainingCell"
    var trainingDataSource:NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        trainingTableView.isEditing = true
        // Do any additional setup after loading the view.
        NetworkManager.sharedNetworkManager.makeGetRequest("")
        trainingTableView.allowsSelection = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    

    //MARK: UITableView Datasource & Delegates
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TrainingTableViewCell
                
        return cell
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .delete {
//            
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.hidesBottomBarWhenPushed = true;

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let trainingDetailsViewController = storyboard.instantiateViewController(withIdentifier:"TrainingDetail") as! TrainingDetailViewController
        self.navigationController?.pushViewController(trainingDetailsViewController, animated: true)

        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//        
//        
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
