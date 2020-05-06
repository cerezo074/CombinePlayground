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

//: [Previous - Introduction](@previous)
import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

/*:
 # Publisher & Subscriber
 */

//simpleSubscription(attachOn: &subscriptions)

/*:
 ### Just
 */

//runJust(attachOn: &subscriptions)

/*:
 ### Assign
 */

//runAssign(attachOn: &subscriptions)

/*:
 ### Cancel Subscription
 /
 When a subscriber is done and no longer wants to receive values from a publisher,
 it’s a good idea to cancel the subscription to free up resources and stop any
 corresponding activities from occurring, such as network calls.
 */

//runCancellable(attachOn: &subscriptions)

/*:
 ## What's going on 🤯
  
 &nbsp;
 
 ![](uml.png)
  
 &nbsp;
 
 ### Publisher Protocol
 ![](publisher.png)
  
 &nbsp;
 
 ### Subscriber Protocol
 ![](subscriber.png)
  
 &nbsp;
 
 ### Subscription Protocol
 ![](subscription.png)
 */

/*:
 ### Custom Subscriptor
*/

//runCustomSubscription()

/*:
 ### Future
*/

//runFuture(attachOn: &subscriptions)

/*:
 ### Subjects
*/

//runPassthroughSubject(attachOn: &subscriptions)
//runCurrentValueSubject(attachOn: &subscriptions)

/*:
 ### Dynamic Demand
*/

//runDynamicDemand(attachOn: &subscriptions)

/*:
 ### Type Erasure
*/

//runTypeErasure(attachOn: &subscriptions)
//: [Next](@next)
