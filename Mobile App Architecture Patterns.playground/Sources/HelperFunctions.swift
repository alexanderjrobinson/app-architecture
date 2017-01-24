import UIKit
import PlaygroundSupport

/*:
 Helper function to load model objects.
 */
public func loadQuotes() -> [Quote] {
    var quotes: [Quote] = []
    quotes += [Quote(text: "It’s not my fault.", source: "Han Solo")]
    quotes += [Quote(text: "Your focus determines your reality.", source: "Qui-Gon Jinn")]
    quotes += [Quote(text: "Do. Or do not. There is no try.", source: "Yoda")]
    quotes += [Quote(text: "Somebody has to save our skins.", source: "Leia Organa")]
    quotes += [Quote(text: "In my experience there is no such thing as luck.", source: "Obi-Wan Kenobi")]
    quotes += [Quote(text: "I find your lack of faith disturbing.", source: "Darth Vader")]
    quotes += [Quote(text: "I’ve got a bad feeling about this.", source: "Luke Skywaler")]
    quotes += [Quote(text: "It’s a trap!", source: "Admiral Ackbar")]
    quotes += [Quote(text: "So this is how liberty dies…with thunderous applause.", source: "Padmé Amidala")]
    quotes += [Quote(text: "Your eyes can deceive you. Don’t trust them.", source: "Obi-Wan Kenobi")]
    quotes += [Quote(text: "Never tell me the odds.", source: "Han Solo")]
    quotes += [Quote(text: "Great, kid. Don’t get cocky.", source: "Han Solo")]
    quotes += [Quote(text: "Stay on target.", source: "Gold Five")]
    
    return quotes
}

/*:
 Helper function to layout quote label and button in supplied main view.
 */
public func layout(label: UILabel, button: UIButton, inView view: UIView) {
    view.backgroundColor = UIColor(red:0.37, green:0.49, blue:0.54, alpha:1.00)
    
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    label.numberOfLines = 0
    label.textAlignment = .center
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40.0).isActive = true
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
    label.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0).isActive = true
    
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0).isActive = true
    button.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    button.setTitle("Show Quotes", for: .normal)
}

/*:
 Helper function to apply a basic theme to the views.
 */
public func applyTheme() {
    UINavigationBar.appearance().barStyle = .black
    UINavigationBar.appearance().tintColor = UIColor(red:0.27, green:0.36, blue:0.39, alpha:1.00)
    UINavigationBar.appearance().barTintColor = UIColor(red:0.27, green:0.36, blue:0.39, alpha:1.00)
    UINavigationBar.appearance().isTranslucent = false
    
    UILabel.appearance().font = UIFont.preferredFont(forTextStyle: .title1)
    UILabel.appearance().textColor = .white
    
    UIButton.appearance().setTitleColor(UIColor(red:1.00, green:0.58, blue:0.16, alpha:1.00), for: .normal)
}

/*:
 Helper function to present the view controller as a live view in the Assistant Editor window.
 */
public func presentViewController(controller: UIViewController) {
    applyTheme()
        
    let navController = UINavigationController(rootViewController: controller)
    PlaygroundPage.current.needsIndefiniteExecution = true
    PlaygroundPage.current.liveView = navController
}
