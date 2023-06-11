//
//  DAOFloatingPanel.swift
//  DAOFloatingPanel
//
//  Created by DAO on 2021/1/21.
//  Copyright © 2021 LikeABossApp. All rights reserved.
//

import UIKit

public enum ScrollDirection {
  case up
  case down
  case none
}

public enum FloatingPanelType {
  case normal
  case extendable
}

public enum FloatingPanelMode {
  case shrink
  case extend
}

public protocol FloatingPanelDelegate: AnyObject {
  func setContentHeight() -> CGFloat?
  func setupFloatingPanelContentUI(panel: DAOFloatingPanelViewController)
}

public extension FloatingPanelDelegate {
  func setContentHeight() -> CGFloat? {
    return nil
  }
}

open class DAOFloatingPanelViewController: UIViewController {
  // MARK: - Properties
  // Public
  public weak var delegate: FloatingPanelDelegate?
  
  public var enableHapticFeedback = true
  
  public private(set) var panelMode: FloatingPanelMode {
    didSet {
      if panelMode == .shrink {
        if !enablePanGesture {
          enablePanGesture = true
        }
      }
    }
  }
  
  public private(set) var scrollDirection = ScrollDirection.none
  
  public lazy var maxHeight: CGFloat = UIScreen.main.bounds.size.height - topMarginToEdge - 50
  
  // Private
  private let panelType: FloatingPanelType
  
  private var enablePanGesture = true {
    didSet {
      if enablePanGesture {
        contentScrollView?.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
      } else {
        contentScrollView?.panGestureRecognizer.removeTarget(self, action: #selector(handlePan(_:)))
      }
    }
  }
  
  private var isPaning = false
  
  private var lastContentOffsetY: CGFloat = 0
  
  private var contentHeight: CGFloat = 0
  
  private lazy var shrinkContentHeight: CGFloat = {
    return contentHeight * 0.6
  }()
  
  private var topMarginToEdge: CGFloat {
    if #available(iOS 13.0, *) {
      return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? UIApplication.shared.statusBarFrame.height) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    } else {
      return UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0)
    }
  }
  
  private var headerTitle: String?
  
  // MARK: - UI
  open lazy var maskView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
    view.addGestureRecognizer(tap)
    view.alpha = 0
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  open lazy var panIndicator: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
    view.layer.cornerRadius = 2.5
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  open lazy var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.clipsToBounds = true
    
    let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    pan.maximumNumberOfTouches = 1
    view.addGestureRecognizer(pan)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  open lazy var headerView: DAOPanelHeader = {
    let view = DAOPanelHeader(title: headerTitle)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private lazy var contentViewHeightConstraint: NSLayoutConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
  private lazy var contentViewBottomConstraint: NSLayoutConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
  
  private weak var contentScrollView: UIScrollView?
  
  // MARK: - Init
  public init(type: FloatingPanelType = .normal, headerTitle: String? = nil) {
    panelType = type
    panelMode = type == .normal ? .extend : .shrink
    self.headerTitle = headerTitle
    
    super.init(nibName: nil, bundle: nil)
    
    modalTransitionStyle = .crossDissolve
    modalPresentationStyle = .overFullScreen
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if isBeingPresented {
      if enableHapticFeedback {
        impactHapticFeedback()
      }
      
      animatePanel(show: true)
    }
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.addSubview(maskView)
    view.addSubview(contentView)
    view.addSubview(panIndicator)
    
    NSLayoutConstraint.activate([
      maskView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      maskView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      maskView.topAnchor.constraint(equalTo: view.topAnchor),
      maskView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentViewBottomConstraint,
      contentViewHeightConstraint
    ])
    
    NSLayoutConstraint.activate([
      panIndicator.widthAnchor.constraint(equalToConstant: 40),
      panIndicator.heightAnchor.constraint(equalToConstant: 5),
      panIndicator.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -7),
      panIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
    
    if headerTitle != nil {
      contentView.addSubview(headerView)
      
      NSLayoutConstraint.activate([
        headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
        headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        headerView.heightAnchor.constraint(equalToConstant: 40)
      ])
    }
    
    delegate?.setupFloatingPanelContentUI(panel: self)
    updateContentHeight(height: delegate?.setContentHeight())
    
    contentViewBottomConstraint.constant = contentHeight
    
    view.layoutIfNeeded()
  }
  
  private func setupViewMask(with view: UIView) {
    // Make sure setup mask after view's layout is ready
    let radius: CGFloat = 10.0
    let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.path = maskPath.cgPath
    view.layer.mask = maskLayer
  }
  
  /// Update floating panel content height after all subviews setup, you can pass hardcore height value, or let auto layout do his work.
  /// - Parameter height: Custom specific height
  open func updateContentHeight(height: CGFloat? = nil, shouldAnimate: Bool = false) {
    if let height = height {
      contentHeight = min(maxHeight, height)
    } else {
      contentHeight = maxHeight
    }
    
    contentViewHeightConstraint.constant = contentHeight

    if shouldAnimate {
      UIView.animate(withDuration: 0.2) {
        self.view.layoutIfNeeded()
      }
    } else {
      self.view.layoutIfNeeded()
    }
    
    setupViewMask(with: contentView)
  }
  
  open func setupContentScrollView(scrollView: UIScrollView?) {
    contentScrollView = scrollView
    contentScrollView?.panGestureRecognizer.addTarget(self, action: #selector(handlePan(_:)))
    scrollView?.delegate = self
  }
  
  // MARK: - Actions
  @objc open func dismissAction() {
    handleDismiss(0.3)
  }
  
  open func handleDismiss(_ duration: TimeInterval = 0.3, completion: (() -> Void)? = nil) {
    dismissPanel(duration: duration) {
      self.dismiss(animated: false, completion: completion)
    }
  }
  
  // MARK: - Animation
  open func animatePanel(show: Bool, panelMode: FloatingPanelMode = .shrink, completion: (() -> Void)? = nil) {
    var bottomOffset: CGFloat = 0.0
    var maskAlpha: CGFloat = 0.0
    
    if show {
      switch panelType {
      case .normal:
        bottomOffset = 0.0
        maskAlpha = 1.0
        
      case .extendable:
        switch panelMode {
        case .shrink:
          self.panelMode = .shrink
          bottomOffset = contentHeight - shrinkContentHeight
          maskAlpha = 0.6
          
        case .extend:
          self.panelMode = .extend
          maskAlpha = 1.0
          bottomOffset = 0.0
        }
      }
      
      contentViewBottomConstraint.constant = bottomOffset
      
      UIView.animate(withDuration: 0.5,
                     delay: 0.0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 1.0,
                     options: .curveEaseInOut,
                     animations: {
                      self.view.layoutIfNeeded()
                      self.maskView.alpha = maskAlpha
      }, completion: { _ in
        completion?()
      })
    } else {
      dismissPanel(duration: 0.3, completion: completion)
    }
  }
  
  open func dismissPanel(duration: TimeInterval, completion: (() -> Void)?) {
    contentViewBottomConstraint.constant = contentHeight
    
    UIView.animate(withDuration: duration, animations: {
      self.maskView.alpha = 0.0
      self.view.layoutIfNeeded()
    }, completion: { _ in
      completion?()
    })
  }
  
  // handle panel floatation event
  @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
    // offset of pan gesture
    let panOffsetY = sender.translation(in: contentView).y
    let velocityY = abs(sender.velocity(in: contentView).y)
    let isSwipe = velocityY > 1000
    
    switch sender.state {
    case .began, .changed:
      isPaning = true
      if panelType == .normal || panelMode == .extend {
        if panOffsetY >= 0 {
          contentViewBottomConstraint.constant = panOffsetY
          
          let alpha = 1.0 - (panOffsetY / contentHeight)
          maskView.alpha = alpha
        }
      } else if panelMode == .shrink {
        contentViewBottomConstraint.constant = max(0, contentHeight - shrinkContentHeight + panOffsetY)
        
        var alpha: CGFloat = 0.0
        if panOffsetY >= 0 {
          alpha = 0.6 - (panOffsetY / shrinkContentHeight)
        } else {
          alpha = 0.6 + (abs(panOffsetY) / (contentHeight - shrinkContentHeight))
        }
        
        maskView.alpha = alpha
      } else {
        break
      }
      
    case .ended:
      isPaning = false
      let isSwipeDown = isSwipe && panOffsetY > 0
      switch panelType {
      case .normal:
        if panOffsetY < contentHeight / 2 {
          if isSwipeDown {
            let duration = TimeInterval((contentHeight / UIScreen.main.bounds.size.height) * 0.2)
            handleDismiss(duration)
          } else {
            if !isSwipe && panOffsetY > 0 {
              impactHapticFeedback()
            }
            animatePanel(show: true)
          }
        } else {
          handleDismiss(0.15)
        }
      case .extendable:
        switch panelMode {
        case .shrink:
          if panOffsetY < 0 {
            animatePanel(show: true, panelMode: .extend)
          } else if isSwipe || panOffsetY >= shrinkContentHeight / 2 {
            handleDismiss(0.1)
          } else {
            animatePanel(show: true, panelMode: .shrink)
          }
        case .extend:
          if panOffsetY < contentHeight - shrinkContentHeight {
            if isSwipeDown {
              animatePanel(show: true, panelMode: .shrink)
            } else {
              animatePanel(show: true, panelMode: .extend)
            }
          } else if panOffsetY < contentHeight - (shrinkContentHeight / 2) {
            animatePanel(show: true, panelMode: .shrink)
          } else {
            handleDismiss(0.1)
          }
        }
      }
      
    default:
      break
    }
  }
  
  private func impactHapticFeedback() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
      var feedback: UIImpactFeedbackGenerator!
      if #available(iOS 13.0, *) {
        feedback = UIImpactFeedbackGenerator(style: .rigid)
      } else {
        feedback = UIImpactFeedbackGenerator(style: .medium)
      }
      
      feedback.impactOccurred()
    }
  }
}

// MARK: - Scroll view delegate
extension DAOFloatingPanelViewController: UIScrollViewDelegate {
  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == contentScrollView {
      if enablePanGesture {
        if panelMode == .shrink || panelMode == .extend && scrollView.contentOffset.y <= 0 || isPaning {
          scrollView.contentOffset.y = lastContentOffsetY
        } else {
          enablePanGesture = false
        }
      }
      
      // Detect scroll direction
      if self.lastContentOffsetY < scrollView.contentOffset.y {
        self.scrollDirection = .up
      } else {
        self.scrollDirection = .down
      }
      self.lastContentOffsetY = scrollView.contentOffset.y
    }
  }
  
  open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollView == contentScrollView {
      if scrollView.contentOffset.y <= 0 {
        scrollView.contentOffset.y = 0
        if !enablePanGesture {
          enablePanGesture = true
        }
      }
    }
  }
}
