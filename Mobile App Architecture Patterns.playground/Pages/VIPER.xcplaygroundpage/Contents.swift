//: [Previous](@previous)

/*: 
 # VIPER
 ### View - Interactor - Presenter - Entity - Router
 
 VIPER has the coolest name of all the patterns demonstrated here but is also the most complex as each of the letters in the acronym represent an explicit layer within an app. It is also the only pattern to explicitly address navigation between screens within an app. The other patterns leave this as an exercise to the reader.
 
 ![VIPER diagram](viper.png)
 
 Each segment depicted here translates to at least one class and possibly a protocol.
 
 The example will appear visually in the assistant editor.
 
 If the assistant editor isn't already visible, open it by selecting View > Assistant Editor > Show Assistant Editor from Xcode's menu (or ⌥⌘↩︎).
 
 */

import Foundation
import UIKit

/*:
 ## ViewContract 
 Basic protocol that represents the interaction from the Presenter to the "View" to be implemented by the UIViewController.
 
 */
protocol VIPERQuoteViewContract: class {
    func setQoute(quote: String)
}

/*:
 ## UIViewController
 */
class VIPERQuoteViewController : UIViewController {
    var eventHandler: VIPERQuoteViewEventHandler?
    let showQuoteButton = UIButton(type: UIButtonType.system)
    let quoteLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler?.load()
        self.showQuoteButton.addTarget(self, action: #selector(VIPERQuoteViewController.didTapButton), for: .touchUpInside)
        
        // Call to helper function to handle layout of views
        layout(label: quoteLabel, button: showQuoteButton, inView: view)
    }
    
    func didTapButton(button: UIButton) {
        eventHandler?.didTapQuoteButton()
    }
}

extension VIPERQuoteViewController: VIPERQuoteViewContract {
    func setQoute(quote: String) {
        self.quoteLabel.text = quote
    }
}

/*:
 ## Provider Protocol 
 Protocol that represents the use cases implemented by the interactor.
 */
protocol VIPERQuoteProvider {
    func generateQuote()
    func load()
}

/*:
 ## Interactor
 Responsible for use case level behaviors.
 
 */
class VIPERQuoteInterator: VIPERQuoteProvider {
    var quotes: [Quote]?
    weak var output: VIPERQuoteOutput?
    
    func generateQuote() {
        guard let quotes = quotes else { return }
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let randomQuote = quotes[randomIndex]
        output?.updateQuote(quote: randomQuote)
    }

    func load() {
        // Call to helper function to load model objects
        quotes = loadQuotes()
    }
}

/*:
 ## EventHandler
 Protocol that represents the user actions and events that are implemented by the presenter.
 
 */

protocol VIPERQuoteViewEventHandler {
    func didTapQuoteButton()
    func load()
}

/*:
 ## Output
 Protocol that represents the delegate methods implemented by the UIViewController.
 
 */
protocol VIPERQuoteOutput: class {
    func updateQuote(quote: Quote)
}

/*:
 ## Presenter
 Handles the user actions and events. Delegates to the provider/interactor.
 */
class VIPERQuotePresenter {
    // Important: The viewContract should be a weak reference to avoid a retain cycle
    weak var viewContract: VIPERQuoteViewContract?
    var provider: VIPERQuoteProvider
    
    init(viewContract: VIPERQuoteViewContract, provider: VIPERQuoteProvider) {
        self.provider = provider
        self.viewContract = viewContract
    }
}

extension VIPERQuotePresenter: VIPERQuoteViewEventHandler {
    func didTapQuoteButton() {
        provider.generateQuote()
    }
    
    func load() {
        provider.load()
    }
}

extension VIPERQuotePresenter: VIPERQuoteOutput {
    func updateQuote(quote: Quote) {
        viewContract?.setQoute(quote: "\(quote.text) -\(quote.source)")
    }
}

/*:
 ## Router
 Handles the assembly and navigation logic in the applications.
 */
class VIPERQuoteRouter {
    var quoteViewController : UIViewController?
    
    func presentQuoteViewController(fromViewController parentViewController: UIViewController?) {
        let viewController = VIPERQuoteViewController()
        let interactor = VIPERQuoteInterator()
        let presenter = VIPERQuotePresenter(viewContract: viewController, provider: interactor)
        interactor.output = presenter
        viewController.eventHandler = presenter
        
        quoteViewController = viewController
        
        //Slight modification to the pattern to allow embedding in a playground.
        if let parent = parentViewController {
            parent.present(viewController, animated: true, completion: nil)
        } else {
            presentViewController(controller: viewController)
        }
    }
    
    func dismissQuoteViewController() {
        quoteViewController?.dismiss(animated: true, completion: nil)
    }
}

/*:
 ## VIPER Assembly
 */
let quoteRouter = VIPERQuoteRouter()

// Call to helper function to present the UIViewController in the live view.
quoteRouter.presentQuoteViewController(fromViewController: nil)

//: [Next](@next)
