//: [Previous](@previous)

/*:
 # MVC
 ### Model - View - Controller 
 
 MVC looks simple and indeed it is simple to implement in a simple app.  In apps that must maintain more complicated state the pattern quickly becomes deficient. As for testability, MVC as traditionally implemented is nearly impossible.
 
  ![MVC Diagram](mvc.png)
 
 The example will appear visually in the assistant editor.
 
 If the assistant editor isn't already visible, open it by selecting View > Assistant Editor > Show Assistant Editor from Xcode's menu (or ⌥⌘↩︎).
 */

import Foundation
import UIKit

/*:
 ## UIViewController
 The UIViewController is responsibile for coordinating between the view and the model. MVC is intended to be presentation layer pattern but often takes on more responsibilites making it harder to maintain and test.
 */
class MVCQuoteViewController : UIViewController { // View + Controller
    var quotes = loadQuotes()
    let showQuoteButton = UIButton(type: UIButtonType.system)
    let quoteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showQuoteButton.addTarget(self, action: #selector(MVCQuoteViewController.didTapButton), for: .touchUpInside)
        
        // Call to helper function to handle layout of views
        layout(label: quoteLabel, button: showQuoteButton, inView: view)
        
        // Call to helper function to load model data
        quotes = loadQuotes()
    }
    
    func didTapButton(button: UIButton) {
        // BUSINESS LOGIC MIXED UP WITH UI CODE
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let randomQuote = quotes[randomIndex]
        
        // FORMATTING CODE IN VC
        self.quoteLabel.text = "\(randomQuote.text) -\(randomQuote.source)"
    }
}

/*:
 ## MVC Assembly
 */

let mvc = MVCQuoteViewController()

// Call to helper function to present the UIViewController in the live view.
presentViewController(controller: mvc)

//: [Next](@next)
