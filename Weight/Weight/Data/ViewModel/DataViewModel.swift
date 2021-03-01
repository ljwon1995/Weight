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
    
    func setDummyData() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 80, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 81, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 82, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 83, date: Date()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.allWeights.append(Weight(amount: 84, date: Date()))
        }
        
    }
    
    func totalDataNumber() -> Int {
        return allWeights.count
    }
    
    func setWeightInfo(withDataIndex index: Int, callback: (Weight) -> Void) {
        callback(allWeights[index])
    }
}
