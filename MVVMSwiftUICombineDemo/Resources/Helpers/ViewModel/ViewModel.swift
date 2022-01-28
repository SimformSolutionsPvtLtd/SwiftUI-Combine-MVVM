//
//  ViewModel.swift
//  MVVMSwiftUICombineDemo
//
//  Created by Simform Solutions on 28/01/22.
//

import Foundation
import Combine

protocol ViewModel: ObservableObject {
    associatedtype Input
    
    func trigger(_ input: Input)
}

extension ViewModel {
    func trigger(_ input: Input) {}
}

