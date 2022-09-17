
import UIKit
import Foundation

private var bottomConstraint : NSLayoutConstraint?
private var imageCompletion : ((UIImage?)->())?
private var constraintValue : CGFloat = 0

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func alignText(subviews: [UIView]) {
    if subviews.count > 0 {
        for subView in subviews {
            
            if subView is UITextField && subView.tag <= 0{
                let textField = subView as! UITextField
                textField.textAlignment = (Language.getCurrentLanguage() == "ar") ? .right: .left
            }
            if subView is UITextView && subView.tag <= 0{
                let textView = subView as! UITextView
                textView.textAlignment = (Language.getCurrentLanguage() == "ar") ? .right: .left

            }
            if subView is UILabel && subView.tag <= 0 {
                let label = subView as! UILabel
                label.textAlignment = (Language.getCurrentLanguage() == "ar") ? .right: .left
            }
        }
      }
    }
    
    func presentAlertWithTitleAndMessage(title: String, message: String, options: [String], completion: @escaping (Int) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for (index, option) in options.enumerated() {
    alert.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
    completion(index)
    }))
        }
//    topMostViewController().present(alertController, animated: true, completion: nil)
         self.present(alert, animated: true)
    }
//    func displayAlertConformAction(_ message : String){
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            let ok = UIAlertAction(title: "Dismiss".localized, style: .default) { _ in
//                self.navigationController?.popViewController(animated: true)
//            }
//            alert.addAction(ok)
//            self.present(alert, animated: true)
//        }
//    }
    func displayAlertItem(){
//        let itemColor: UIColor = (sourceArray[collectionView.tag] as! Array<AnyObject>)[(indexPath as NSIndexPath).item] as! UIColor
        //@objc 
//            let alert = UIAlertController(title: "第\(collectionView.tag)行", message: "第\((indexPath as NSIndexPath).item)个元素", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//        let v: UIView = UIView(frame: CGRect(x: 10, y: 20, width: 50, height: 50))
//        v.backgroundColor = itemColor
//        alert.view.addSubview(v)
    }
//    func displayAlertAction(_ message : String){
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            let ok = UIAlertAction(title: "Dismiss".localized, style: .default) { _ in
//                self.navigationController?.popViewController(animated: true)
//            }
//            alert.addAction(ok)
//            self.present(alert, animated: true)
//        }
//    }
//    func displayAlertActionDismiss(_ message : String){
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            let ok = UIAlertAction(title: "Dismiss".localized, style: .default) { _ in
//                self.dismiss(animated: true, completion: nil)
//            }
//            alert.addAction(ok)
//            self.present(alert, animated: true)
//        }
//    }
//    func displayAlert(message: String)  {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
//            self.present(alert, animated: true)
//        }
//    }
    func displayAlertWithTimer(message: String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            let when = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    func displayAlertWithDismiss(message: String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            let when = DispatchTime.now() + 0.2
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
    func displayAlertWithPopup(message: String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            self.present(alert, animated: true)
            let when = DispatchTime.now() + 3.0
            DispatchQueue.main.asyncAfter(deadline: when){
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
//    func displayTitleAlert(title: String, message: String)  {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
//            self.present(alert, animated: true)
//        }
//    }
    
    func fromRight(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        //        self.dismiss(animated: false, completion: nil)
        
        func shareText (text: String){
            //            let text = "This is some text that I want to share."
            
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        }
    }
    
    func dissmissFromLeft(){
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
//    func setPresenter(){
//        if let view = self as? PostViewProtocol {
//            view.presenter = presenterObject
//            view.presenter?.controller = view
//            presenterObject = view.presenter
//        }
//    }
    func setBackgroundColor(){
        self.view.backgroundColor = .backgroundColor
    }
    //MARK:- Pop or dismiss View Controller
    func popOrDismiss(animation : Bool){
        DispatchQueue.main.async {
            if self.navigationController != nil {
                self.navigationController?.popViewController(animated: animation)
            } else {
                self.dismiss(animated: animation, completion: nil)
            }
        }
    }
//    //MARK:- Present
//    func present(id : String, animation : Bool, from storyboard : UIStoryboard = Router.storyboard){
//        let vc = storyboard.instantiateViewController(withIdentifier: id)
//        self.present(vc, animated: animation, completion: nil)
//    }
//    //MARK:- Push
//    func push(id : String, animation : Bool, from storyboard : UIStoryboard = Router.storyboard){
//        let vc = storyboard.instantiateViewController(withIdentifier: id)
////        self.navigationController?.pushViewController(vc, animated: animation)
//        self.navigationController?.show(vc, sender: self)
//    }
//    func push(vc : UIViewController, animation : Bool, from storyboard : UIStoryboard = Router.storyboard){
//        DispatchQueue.main.async {
//            self.navigationController?.pushViewController(vc, animated: animation)
////            self.navigationController?.show(vc, sender: self)
////            self.navigationController.prese
//        }
//    }
//    func replace(source : UIViewController, destnation : UIViewController, from storyboard : UIStoryboard = Router.storyboard){
//        weak var presentingViewController = self.presentingViewController
//        source.dismiss(animated: true, completion: {
//            presentingViewController?.present(destnation, animated: false, completion: nil)
//        })
//    }
    //MARK:- Push To Right
    func pushRight(toViewController viewController : UIViewController){
        self.makePush(transition: CATransitionSubtype.fromLeft.rawValue)
        navigationController?.pushViewController(viewController, animated: false)
    }
    private func makePush(transition type : String){
        let transition = CATransition()
        transition.duration = 0.45
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype(rawValue: type)
        navigationController?.view.layer.add(transition, forKey: nil)
    }
    func goBack(){
        navigationController?.popViewController(animated: true)
    }
    func popLeft() {
        self.makePush(transition: CATransitionSubtype.fromRight.rawValue)
        navigationController?.popViewController(animated: true)
    }
    //MARK:- Add observers
    func addKeyBoardObserver(with constraint : NSLayoutConstraint){
        bottomConstraint = constraint
        constraintValue = constraint.constant
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(info:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(info:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    //MARK:- Keyboard will show
    @objc private func keyboardWillShow(info : NSNotification){
        guard let keyboard = (info.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        bottomConstraint?.constant = -(keyboard.height)
        self.view.layoutIfNeeded()
    }
    //MARK:- Keyboard will hide
    @objc private func keyboardWillHide(info : NSNotification){
        bottomConstraint?.constant = constraintValue
        self.view.layoutIfNeeded()
    }
    //MARK:- Back Button Action
    @objc func backButtonClick() {
        self.popOrDismiss(animation: true)
    }
    //MARK:- Show Image Selection Action Sheet
    func showImage(with completion : @escaping ((UIImage?)->())){
        let alert = UIAlertController(title: "Constants.string.selectSource.localized", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Constants.string.camera.localized", style: .default, handler: { (Void) in
            self.chooseImage(with: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Constants.string.photoLibrary.localized", style: .default, handler: { (Void) in
            self.chooseImage(with: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Constants.string.cancel.localized", style: .cancel, handler:nil))
        alert.view.tintColor = UIColor.blue
        imageCompletion = completion
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- Show Image Picker
    private func chooseImage(with source : UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = source
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    //MARK:- Show Search Bar with self delegation
    @objc private func showSearchBar(){
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.delegate = self as? UISearchBarDelegate
        searchBar.hidesNavigationBarDuringPresentation = false

//        searchBar.dimsBackgroundDuringPresentation = false
        searchBar.searchBar.tintColor = .blue
        self.present(searchBar, animated: true, completion: nil)
    }
}
//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
                imageCompletion?(image)
            }
        }
    }
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
