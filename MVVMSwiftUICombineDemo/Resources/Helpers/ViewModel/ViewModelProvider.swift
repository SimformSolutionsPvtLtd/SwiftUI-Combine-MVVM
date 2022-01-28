//
//  ViewModelProvider.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation

class ViewModelProvider {
    
    private static var viewModelStore = [String:Any]()
    
    static func makeViewModel<ViewModel>(_ hash: ViewModelHash, usingBuilder builder: () -> ViewModel) -> ViewModel {
        if let vm = viewModelStore[hash.rawValue] as? ViewModel {
            return vm
        } else {
            let vm = builder()
            viewModelStore[hash.rawValue] = vm
            return vm
        }
    }
    
    static func removeViewModel(_ hash: ViewModelHash) {
        viewModelStore.removeValue(forKey: hash.rawValue)
    }
}
