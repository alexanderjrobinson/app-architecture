//: [Previous](@previous)

/*: 
 # MVVM
 ### Model - View - ViewModel
 
 MVVM removes most of the responsibilities of the ViewController and forces it down one or more layers into the ViewModel. The ViewController beccomes part of the View and simply mediates between UIKit views and the ViewModel. The role of the ViewModel is to mediate interaction between the ViewController and other subsystems in an app and translate the results of those interactions into a format for the ViewController to display. Types such as dates and numbers to be displayed in labels are already formatted as strings with locale specific formatting already applied.
 
 
 ![MVVM Diagram](mvvm.png)
 
 MVVM works best with a method to bind values between the viewModel and view. This example uses the venerable technology KVO for demonstration purposes. In practice there are numerous 3rd party libraries that facilitate binding to properties such as RxSwift, ReactiveCocoa & ReactiveKit/Bond
 
 The example will appear visually in the assistant editor.
 
 If the assistant editor isn't already visible, open it by selecting View > Assistant Editor > Show Assistant Editor from Xcode's menu (or ⌥⌘↩︎).
 
 */

import Foundation
import UIKit

/*:
 ## UIViewController
 The UIViewController is consider to be part of the View layer and its responsibilites are limited to handling user interactions and layout.
 */

@objc class MVVMQuoteViewController : UIViewController {
    var viewModel: MVVMQuoteViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            // Setup observer to listen for model changes
            vm.addObserver(self, forKeyPath: "currentQuote", options: [.initial, .new], context: nil)
        }
    }
    var showQuoteButton = UIButton(type: UIButtonType.system)
    var quoteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showQuoteButton.addTarget(self, action: #selector(MVVMQuoteViewController.didTapButton), for: .touchUpInside)
        
        // Call to helper function to handle layout of views
        layout(label: quoteLabel, button: showQuoteButton, inView: view)
        
    }
    
    func didTapButton(button: UIButton) {
        // Delegate to the ViewModel for business logic and formatting content for presentation
        viewModel?.generateQuote()
    }
    
    // Handle KVO events to update UI when the model changes
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, let quote = change[NSKeyValueChangeKey.newKey] as? String, keyPath == "currentQuote" else {
            return }
        quoteLabel.text = quote
    }
}

/*:
 ## ViewModel
 Application and business logic is moved to the ViewModel to reduce the responsibilites of the UIViewController and to make it easier to test the the logic in isolation of the UI.
 */

@objc class MVVMQuoteViewModel: NSObject {
    var quotes: [Quote]
    dynamic var currentQuote: String
    
    override init() {
        currentQuote = ""
        quotes = loadQuotes()
    }
    
    func generateQuote() {
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let randomQuote = quotes[randomIndex]
        currentQuote = "\(randomQuote.text) -\(randomQuote.source)"
    }
}

/*:
 ## MVVM Assembly
 */

let mvvm = MVVMQuoteViewController()
mvvm.viewModel = MVVMQuoteViewModel()

// Call to helper function to present the UIViewController in the live view.
presentViewController(controller: mvvm)

//: [Next](@next)
