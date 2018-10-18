//
//  WKWebViewController.swift
//  SwiftToolsKit
//
//  Created by PlutusCat on 2018/10/16.
//  Copyright © 2018 SwiftToolsKit. All rights reserved.
//

import UIKit
import WebKit

class BaseWebViewController: UIViewController {

    var webView: WKWebView!
    var bottomBar: BottomToolBar!

    private var bottomBarY: CGFloat!
    private var isToTop: Bool!
    private var bottomBarH = CGFloat(46.0)

    private lazy var navigationBar : NavigationBar = {
        let subview = NavigationBar()
        subview.backgroundColor = .white
        return subview
    }()

    var isShowMore : Bool {
        get {
            return navigationBar.isShowMore
        }
        set {
            navigationBar.isShowMore = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }

        view.backgroundColor = .background

        if NavigationLayout.getSafeArea().bottom > 0.0 {
            bottomBarH = bottomBarH + CGFloat(16)
        }

        createWebView()
        createBottomToolBar()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customNavigationBar(hidden: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        customNavigationBar(hidden: false)
    }

    private func customNavigationBar(hidden: Bool) {
        navigationController?.setNavigationBarHidden(hidden, animated: false)
        view.addSubview(navigationBar)
        navigationBar.closeCallBack = { [weak self] in
            self?.popAction()
        }
    }

    private func createWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.minimumFontSize = 10
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuration.userContentController = WKUserContentController()

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .background
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        view.addSubview(webView)

        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    private func createBottomToolBar() {
        bottomBar = BottomToolBar()
        bottomBar.isHidden = true
        view.addSubview(bottomBar)

        bottomBar.callBack = { [weak self] isGoBack in
            if isGoBack {
                self?.previousPage()
            }else {
                self?.nextPage()
            }
        }
    }

    public func load(_ request: URLRequest) {
        webView.load(request)
    }

    @objc func popAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc func previousPage() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc func nextPage() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let webY = NavigationLayout.getNavigationHeight(isFixed: true)
        webView.frame = CGRect(x: 0, y: webY, width: view.bounds.width, height: view.bounds.height-webY)

        bottomBarY = view.bounds.height-bottomBarH
        bottomBar.frame = CGRect(x: 0, y: bottomBarY, width: view.bounds.width, height: bottomBarH)

    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "loading":
            print("正在加载中。。。。")
        case "title":
            navigationBar.titleLabel.text = webView.title
        case "estimatedProgress":
            let float = Float(webView.estimatedProgress)
            navigationBar.progressView.setProgress(float, animated: true)
        default:
            break
        }

        guard webView.isLoading else {
            UIView.animate(withDuration: 0.55) { [weak self] in
                self?.navigationBar.progressView.alpha = 0.0
                self?.navigationBar.progressView.setProgress(0.0, animated: false)
            }
            return
        }
    }

    deinit {
        webView.removeObserver(self, forKeyPath: "loading")
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
        print("注销 ==", self)
    }

}

extension BaseWebViewController: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if bottomBar.isHidden { return }
        if isToTop {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.bottomBar.frame.origin.y = (self?.bottomBarY)!+(self?.bottomBarH)!
            }
        }else {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.bottomBar.frame.origin.y = (self?.bottomBarY)!
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if bottomBar.isHidden { return }
        let translatedPoint = scrollView.panGestureRecognizer.translation(in: scrollView)
        if translatedPoint.y < 0 {
            isToTop = true
        }else {
            isToTop = false
        }
    }
}

extension BaseWebViewController: WKNavigationDelegate, WKUIDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        navigationBar.progressView.alpha = 1.0
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            bottomBar.isHidden = false
            bottomBar.previousItem.isEnabled = true
        }else {
            bottomBar.isHidden = true
            bottomBar.previousItem.isEnabled = false
        }

        if webView.canGoForward {
            bottomBar.nextItem.isEnabled = true
        }else {
            bottomBar.nextItem.isEnabled = false
        }
    }

}

extension BaseWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
}


class BottomToolBar: UIView {

    var callBack: ((_ isGoBack: Bool)->Void)?

    var previousItem: UIButton!
    var nextItem: UIButton!

    private let itemH = CGFloat(46.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.background
        previousItem = createItem(image: "web_back", action: #selector(previousAction))
        addSubview(previousItem)
        nextItem = createItem(image: "web_next", action: #selector(nextAction))
        addSubview(nextItem)
    }

    @objc func previousAction() {
        if let call = callBack {
            call(true)
        }
    }

    @objc func nextAction() {
        if let call = callBack {
            call(false)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previousItem.frame = CGRect(x: 0, y: 0, width: bounds.width*0.5, height: itemH)
        nextItem.frame = CGRect(x: previousItem.frame.maxX, y: 0, width: previousItem.bounds.width, height: previousItem.bounds.height)
    }

    private func createItem(image: String, action: Selector) -> UIButton {
        let inset = CGFloat(14.0)
        let btn = UIButton(type: .custom)
        btn.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: image+"_disabled"), for: .disabled)
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }

}

class NavigationBar: UIView {

    var closeCallBack: (()->Void)?
    var moreCallBack: (()->Void)?

    var isShowMore : Bool {
        get {
            return moreItem.isHidden
        }
        set {
            moreItem.isHidden = !newValue
        }
    }

    lazy var progressView : UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .clear
        progressView.progressTintColor = .blue01
        return progressView
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return titleLabel
    }()

    private lazy var closeItem : UIButton = {
        let subview = UIButton(type: .custom)
        subview.backgroundColor = .white
        subview.setImage(UIImage(named: "web_close"), for: .normal)
        subview.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        subview.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return subview
    }()

    private lazy var moreItem : UIButton = {
        let subview = UIButton(type: .custom)
        subview.backgroundColor = .white
        subview.setImage(UIImage(named: "web_more"), for: .normal)
        subview.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        subview.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return subview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSubViews() {
        addSubview(progressView)
        addSubview(closeItem)
        addSubview(moreItem)
        addSubview(titleLabel)
    }

    @objc private func popAction() {
        if let cell = closeCallBack {
            cell()
        }
    }

    @objc private func moreAction() {
        if let cell = moreCallBack {
            cell()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let window = UIApplication.shared.keyWindow
        let H = NavigationLayout.getNavigationHeight(isFixed: true)
        self.frame = CGRect(x: 0, y: 0, width: window?.bounds.width ?? 0.0, height: H)

        let progressViewH = CGFloat(0.5)
        progressView.frame = CGRect(x: 0, y: self.frame.maxY-progressViewH, width: self.frame.width, height: 0.5)

        let itemY = NavigationLayout.getStatusBarFrame().maxY
        let itemW = NavigationLayout.getNavigationBarHeight()
        let itemX = NavigationLayout.getSafeArea().left + 8
        closeItem.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemW)

        moreItem.frame = CGRect(x: titleLabel.frame.maxX, y: itemY, width: itemW, height: itemW)

        let titlemaxX = closeItem.frame.maxX
        titleLabel.frame = CGRect(x: titlemaxX, y: itemY, width: self.frame.width-titlemaxX*2, height: itemW)
    }

}

