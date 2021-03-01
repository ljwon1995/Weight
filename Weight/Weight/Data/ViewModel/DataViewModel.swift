//
//  DataViewModel.swift
//  Weight
//
//  Created by USER on 2021/03/01.
//
import Foundation

class DataViewModel {
    typealias Listener = () -> Void
    var weightDataListener: Listener?

    var allWeights: [Weight] = [Weight]() {
        didSet {
            weightDataListener?()
        }
    }
    
    func setListenerToWeightData(listener: Listener?) {
        self.weightDataListener = listener
    }
    
    //TODO: Test Code
    func fetchAllData() {
        setDummyData()
    }
    
    func setDummyData() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 80, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allWeights.append(Weight(amount: 81, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.allWeights.append(Weight(amount: 82, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.allWeights.append(Weight(amount: 83, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.allWeights.append(Weight(amount: 84, date: Date()))
        }
        
    }
    
    func totalDataNumber() -> Int {
        return allWeights.count
    }
    
    func setWeightInfo(withDataIndex index: Int, callback: (String, String) -> Void) {
        let amount = String(allWeights[index].amount)
        let date = convertDateToString(date: allWeights[index].date)
        
        callback(amount, date)
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
