//
//  ViewController.swift
//  Combine Examples
//
//  Created by Eli Pacheco Hoyos on 9/04/20.
//  Copyright © 2020 Eli Pacheco Hoyos. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet private weak var throttleTitleLabel: UILabel!
    @IBOutlet private weak var debounceTitleLabel: UILabel!
    @IBOutlet private weak var throttleResultLabel: UILabel!
    @IBOutlet private weak var debounceResultLabel: UILabel!
    
    private var subscriptions: Set<AnyCancellable> = []
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindVM()
    }
    
}

private extension ViewController {
    
    func bindVM() {
        viewModel.throttlePublisher
            .throttle(for: .seconds(3), scheduler: DispatchQueue.main, latest: false)
            .assign(to: \.text, on: throttleResultLabel)
            .store(in: &subscriptions)
        
        viewModel.debouncePublisher
            .debounce(for: .seconds(3), scheduler: DispatchQueue.main)
            .assign(to: \.text, on: debounceResultLabel)
            .store(in: &subscriptions)
        
        viewModel.totalDebouncePressed
            .assign(to: \.text, on: debounceTitleLabel)
            .store(in: &subscriptions)
        
        viewModel.totalThrottlePressed
            .assign(to: \.text, on: throttleTitleLabel)
            .store(in: &subscriptions)
    }
    
    @IBAction func runThrottle(_ sender: Any) {
        viewModel.getThrottleValue()
    }
    
    @IBAction func runDebounce(_ sender: Any) {
        viewModel.getDebounceValue()
    }
    
    @IBAction func reset(_ sender: Any) {
        viewModel.reset()
    }
    
}

class ViewModel {
    private let throttleSubject = PassthroughSubject<String?, Never>()
    private let debounceSubject = PassthroughSubject<String?, Never>()
    private let totalThrottle = CurrentValueSubject<Int, Never>(0)
    private let totalDebounce = CurrentValueSubject<Int, Never>(0)
}

extension ViewModel {
    
    var throttlePublisher: AnyPublisher<String?, Never> {
        return throttleSubject.eraseToAnyPublisher()
    }

    var debouncePublisher: AnyPublisher<String?, Never> {
        return debounceSubject.eraseToAnyPublisher()
    }

    var totalThrottlePressed: AnyPublisher<String?, Never> {
        return totalThrottle.map { "Throttle - time pressed(\($0))" }
            .eraseToAnyPublisher()
    }

    var totalDebouncePressed: AnyPublisher<String?, Never> {
        return totalDebounce.map { "Debounce - time pressed(\($0))" }
        .eraseToAnyPublisher()
    }
    
    func getThrottleValue() {
        totalThrottle.value += 1
        throttleSubject.send("\(totalThrottle.value)")
    }
    
    func getDebounceValue() {
        totalDebounce.value += 1
        debounceSubject.send("\(totalDebounce.value)")
    }
    
    func reset() {
        totalDebounce.value = 0
        totalThrottle.value = 0
        debounceSubject.send("\(totalDebounce.value)")
        throttleSubject.send("\(totalThrottle.value)")
    }
    
}

