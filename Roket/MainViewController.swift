//
//  MainViewController.swift
//  Roket
//
//  Created by Rock on 17/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import HealthKit

class MainViewController: UIViewController {
    
    //---------------ui feature--------------------
    @IBOutlet weak var profileButtonTap: UIButton!{
        didSet{
            profileButtonTap.addTarget(self, action: #selector(presentProfileViewController), for: .touchUpInside)
        }
    }
    @IBOutlet weak var historyButtonTap: UIButton!{
        didSet{
            historyButtonTap.addTarget(self, action: #selector(presentChartPage), for: .touchUpInside)
        }
    }
    @IBOutlet weak var rankingButtonTap: UIButton!
    
    @IBOutlet weak var friendImage1: UIImageView!{
        didSet{
            friendImage1.layer.cornerRadius = friendImage1.frame.size.width / 2
            friendImage1.clipsToBounds = true
            friendImage1.backgroundColor = UIColor.green
        }
    }
    @IBOutlet weak var friendImage2: UIImageView!{
        didSet {
            friendImage2.layer.cornerRadius = friendImage2.frame.size.width / 2
            friendImage2.clipsToBounds = true
            friendImage2.backgroundColor = UIColor.blue
        }
    }
    @IBOutlet weak var friendImage3: UIImageView!{
        didSet{
            friendImage3.layer.cornerRadius = friendImage3.frame.size.width / 2
            friendImage3.clipsToBounds = true
            friendImage3.backgroundColor = UIColor.cyan
        }
    }
    @IBOutlet weak var challengeButtonTap: UIButton!{
        didSet{
            challengeButtonTap.addTarget(self, action: #selector(presentChallengePage), for: .touchUpInside)
        }
    }
    @IBOutlet weak var rankingDisplay: UILabel!{
        didSet{
            rankingDisplay.layer.cornerRadius = rankingDisplay.frame.size.width / 2
            rankingDisplay.clipsToBounds = true
        }
    }
    @IBOutlet weak var timeZoneInHealthKit: UILabel!
    @IBOutlet weak var caloriesInHealthKit: UILabel!
    @IBOutlet weak var stepsInHealthKit: UILabel!
    
    //-----------------properties-------------------
    
    
    let healthKitStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //-----------------function section=------------------
    
    func checkAvailability(){
        if HKHealthStore.isHealthDataAvailable(){
            
            let stepsCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning))
            
            let caloriesCount = NSSet(object: HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned))
            
            healthKitStore.requestAuthorization(toShare:caloriesCount as! Set<HKSampleType>, read: stepsCount as! Set<HKObjectType>, completion: { (success, error) in
                if success == false {
                    print("display not allowed")
                }
            })
        }
    }
    
    func presentChartPage() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ChartViewController")
        
        present(controller!, animated: true, completion: nil)
    }
    
    func presentProfileViewController() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
        
        present(controller!, animated: true, completion: nil)
    }
    
    func presentChallengePage() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ChallengeViewController")
        
        present(controller!, animated: true, completion: nil)
    }
}
