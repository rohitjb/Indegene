import UIKit

class PDFDetailViewController: UIViewController, UIWebViewDelegate {

    let closeButton = UIButton()
    private let webView = UIWebView()
    let pdfUrl: String
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    init(url: String) {
        pdfUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = UIColor.lightGray
        
        let image = UIImage(named: "close")
        closeButton.setImage(image, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(webView)
        
        activityIndicatorView.color = UIColor.black
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        
        webView.delegate = self

        applyConstraints()
        
        loadPdf()
    }
    
    func loadPdf() {
        guard let url = URL(string: pdfUrl) else {
            return
        }
        webView.loadRequest(URLRequest(url: url))
    }
    
    private func applyConstraints() {
        closeButton.pinToSuperviewTop(constant: 20)
        closeButton.pinToSuperviewLeading(constant: 8)
        closeButton.addWidthConstraint(constant: 40)
        closeButton.addHeightConstraint(constant: 40)
        
        webView.pinToSuperview(edges: [.leading, .trailing, .bottom])
        webView.pinToSuperviewTop(constant: 70)
        
        activityIndicatorView.pinCenterX(to: view)
        activityIndicatorView.pinCenterY(to: view)
        
        activityIndicatorView.addWidthConstraint(constant: 45)
        activityIndicatorView.addHeightConstraint(constant: 45)
    }
    
    @objc private func closeButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicatorView.stopAnimating()
    }
}
