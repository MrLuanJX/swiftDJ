//
//  LJX_WebViewController.swift
//  JJDS
//
//  Created by a on 2019/5/28.
//  Copyright © 2019 a. All rights reserved.
//

import UIKit
import WebKit

class LJX_WebViewController: UIViewController {

    var webView : WKWebView!
    var configure: WKWebViewConfiguration?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //设置导航栏背景透明
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        JANALYTICSService.startLogPageView(WebPage)
        MobClick.beginLogPageView(WebPage)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        MobClick.endLogPageView(WebPage)
        JANALYTICSService.stopLogPageView(WebPage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        createUI()
    }
    
    func createUI()  {
        configure = WKWebViewConfiguration()
        
        configure?.preferences = WKPreferences()
        configure?.preferences.javaScriptEnabled = true
        
        webView =  WKWebView(frame: self.view.bounds, configuration: self.configure!)
        self.view.addSubview(webView!)
        
        webView.navigationDelegate =  self
        webView.uiDelegate = self
        //设置访问的url
        let url = URL(string: "https://www.taobao.com")
        //根据url创建请求
        let urlRequest = URLRequest(url: url!)
        //加载请求
        webView.load(urlRequest)
        self.view.addSubview(webView)
    }
}

extension LJX_WebViewController: WKNavigationDelegate , WKUIDelegate {
    
    // 监听网页加载进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
    }
    
    func webView(webView: WKWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebView.NavigationType) -> Void {
        print("webView")
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载...")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        print("当内容开始返回...")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        print("页面加载完成...")
        /// 获取网页title
        self.title = self.webView.title
        
        UIView.animate(withDuration: 0.5) {
            // 隐藏进度条
        }
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        print("页面加载失败...")
        UIView.animate(withDuration: 0.5) {
           // 隐藏进度条
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    // 拦截URL
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print("hello world")
        
        // 包含进制跳转
        if navigationAction.request.url?.scheme?.contains(find: "itmss://itunes.apple.com") ?? false {
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
