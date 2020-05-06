/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

//: [Previous](@previous)

import Foundation
import Combine

var subscriptions: Set<AnyCancellable> = []

//example(of: "Delay") {
//    let numbers = [1,2,3,4,5,6]
//
//    numbers.publisher
//        .delay(for: .seconds(3), scheduler: DispatchQueue.main)
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}
//
//example(of: "Collect") {
//    let numbersSubject = PassthroughSubject<Int, Never>()
//
//    numbersSubject
//        .collect(.byTime(DispatchQueue.main, .seconds(2)))
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//
//    numbersSubject.send(1)
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//        numbersSubject.send(4)
//        numbersSubject.send(5)
//    }
//
//    numbersSubject.send(2)
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        numbersSubject.send(6)
//        numbersSubject.send(7)
//    }
//
//    numbersSubject.send(3)
//}
//
//example(of: "Timeout") {
//    enum RequestError: Error {
//        case timeOut
//    }
//
//    let networkData = Future<String, RequestError>() { promise in
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            promise(.success("Data sent"))
//        }
//    }
//
//    networkData.timeout(.seconds(2),
//                        scheduler: DispatchQueue.main,
//                        customError: { .timeOut })
//        .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })
//        .store(in: &subscriptions)
//}

//: [Next](@next)
