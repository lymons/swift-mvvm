//
//  Mvvm+UIViewController.swift
//  mvvm-demo
//
//  Created by NGUYEN KHANH DUY on 6/14/16.
//  Copyright © 2016 NGUYEN KHANH DUY. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension MvvmViewCommonDelegate where Self: MvvmUIViewController {
    func injectViewModel(viewModel: MvvmCommonViewModel) -> MvvmCommonViewModel {
        viewModel.viewStateStream.subscribeNext { (state) in
            let newViewState = state.0
        
            if state.1 is MvvmViewStateNull {
                self.onMvvmViewStateInit(newViewState)
                self.onMvvmViewStateUpdated(newViewState)
            } else {
                self.onMvvmViewStateChanged(newViewState, oldViewState: state.1 as MvvmViewState)
                self.onMvvmViewStateUpdated(newViewState)
            }
        }
        .addDisposableTo(viewModel.disposeBag)
        self.viewModel = viewModel
        return viewModel
    }
}

class MvvmUIViewController: UIViewController {
    var viewModel:MvvmCommonViewModel? = nil
}