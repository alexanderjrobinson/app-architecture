//: [Previous](@previous)

/*: 
 # MVP
 ### Model - View - Presenter
 
 MVP is a blend between a forms & controls model with MVC. The view and view controller become passive items that only display data and relay user interactions back to the Presenter. The Presenter decides how to react to an event and relay modifications of a model back to the the view.
 
 ![MVP Diagram](mvp.png)
 
 The example will appear visually in the assistant editor.
 
 If the assistant editor isn't already visible, open it by selecting View > Assistant Editor > Show Assistant Editor from Xcode's menu (or ⌥⌘↩︎).
 
 */

import Foundation
import UIKit

/*:
 ## ViewContract
 Basic protocol that represents the interaction from the Presenter to the "View" to be implemented by the UIViewController.
 */
protocol MVPQuoteViewContract: class {
    func setQoute(quote: String)
}

/*:
 ## UIViewController
 */
class MVPQuoteViewController : UIViewController {
    var presenter: MVPQuotePresenter?
    let showQuoteButton = UIButton(type: UIButtonType.system)
    let quoteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showQuoteButton.addTarget(self, action: #selector(MVPQuoteViewController.didTapButton), for: .touchUpInside)
        
        // Call to helper function to handle layout of views
        layout(label: quoteLabel, button: showQuoteButton, inView: view)
    }
    
    func didTapButton(button: UIButton) {
        presenter?.generateQuote()
    }
}

extension MVPQuoteViewController: MVPQuoteViewContract {
    func setQoute(quote: String) {
        self.quoteLabel.text = quote
    }
}

/*:
 ## Presenter
 Handles the user actions and events.
 */
class MVPQuotePresenter {
    // Important: The viewContract should be a weak reference to avoid a retain cycle
    weak var viewContract: MVPQuoteViewContract?
    var quotes: [Quote]
    
    init(viewContract: MVPQuoteViewContract) {
        self.viewContract = viewContract
        
        // Call to helper function to load model objects
        quotes = loadQuotes()
    }
    
    func generateQuote() {
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let randomQuote = quotes[randomIndex]
        viewContract?.setQoute(quote: "\(randomQuote.text) -\(randomQuote.source)")
    }

}

/*:
 ## MVP Assembly
 */
let mvp = MVPQuoteViewController()
let presenter = MVPQuotePresenter(viewContract: mvp)
mvp.presenter = presenter

// Call to helper function to present the UIViewController in the live view.
presentViewController(controller: mvp)

//: [Next](@next)
