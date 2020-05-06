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

//: ## Introduction

/*:
 ### Definition
 
 The Combine framework provides a declarative approach for how your app processes events. Rather than potentially implementing multiple delegate, callbacks or completion handler closures, you can create a single processing chain for a given event source. Each part of the chain is a Combine operator that performs a distinct action on the elements received from the previous step. *By Apple*.
 
 ### Imperative vs Declarative
 
 With imperative programming, you express what you want to happen, step by step.
 
 &nbsp;
 
 ```
 let numbers = [1, 2, 3, 4, 5]
 var evens: [Int] = []
 
 for number in numbers {
    if number % 2 == 0 {
        evens.append(number)
    }
 }
 
 var dobled: [Int] = []
 
 for number in evens {
    dobled.append(number * 2)
 }
 ```
 
 \
 With declarative programming, on the other hand, you write code that describes what you want, but not necessarily how to get it (declare your desired results, but not the step-by-step).
 
 &nbsp;
 
 ````
 let numbers = [1, 2, 3, 4, 5]
 let doubled = numbers.filter { $0 % 2 == 0 }.map { $0 * 2 }
 ````
 
 \
 More information on [Stackoverflow](https://stackoverflow.com/questions/1784664/what-is-the-difference-between-declarative-and-imperative-programming)
 
 &nbsp;
 
 ## “Foundation and UIKit/AppKit”
 
 \
 We've got different mechanisms to handle asynchronous programming
 
 \
 ![Old Style](old_style.png)
 
 \
 The old way 👨🏻‍🦳:
 
 - NotificationCenter: Executes any piece of code at any moment.
 - Delegates: Send messages to your delegates at any moment.
 - GCD and Operations: Schedule code to be executed later.
 - Closures: Create detached code that can be invoked at any moment
 
 \
 Writing and app can be a mess due to different mechanisms interacting together for handling asynchronous code(Who doesn't need it ?).
 
 \
 ![](real_app.png)
 
 \
 Apple has integrated Combine's API deep into the Foundation framework, so **Timer**, **NotificationCenter** and core frameworks like **Core Data** already speak its language. Luckily, Combine is also very easy to integrate into your own code.
 
 \
 ![Hierarchy](hierarchy.png)
 
 &nbsp;
 
 ## Combine Basics
 
 \
 There are just 3 core components:
 
 &nbsp;
 
 ### Publishers
 ![](simple_publisher.png)
 
 &nbsp;
 
 ### Operators
 ![](simple_operator.png)
 
 &nbsp;
 
 ### Subcribers:
 ![](simple_subscriber.png)
 */

//: [Go to Components](@next)
