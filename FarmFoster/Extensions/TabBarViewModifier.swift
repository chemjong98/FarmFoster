//
//  TabBarViewModifier.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import FlowStacks

extension UITabBar {
    // if tab View is used show Tab Bar
    static func showTabBar(animated: Bool = true) {
        DispatchQueue.main.async {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ view in
                if let view = view as? UITabBar {
                    view.setIsHidden(false, animated: animated)
                }
            })
        }
    }

    private static func updateFrame(_ view: UIView) {
        if let superView = view.superview {
            let currentFrame = superView.frame
            superView.frame = currentFrame.insetBy(dx: 0, dy: 1)
            superView.frame = currentFrame
        }
    }

    static func hideTabBar(animated: Bool = true) {
        DispatchQueue.main.async {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            windowScene?.windows.first(where: { $0.isKeyWindow })?.allSubviews().forEach({ view in
                if let view = view as? UITabBar {
                    view.setIsHidden(true, animated: animated)
                }
            })
        }
    }

    private func setIsHidden(_ hidden: Bool, animated: Bool) {
        let isViewHidden = isHidden

        if animated {
            if isHidden && !hidden {
                isHidden = false
                Self.updateFrame(self)
                frame.origin.y = UIScreen.main.bounds.height + 200
            }

            if isViewHidden && !hidden {
                alpha = 0.0
            }

            UIView.animate(withDuration: 0.8, animations: {
                self.alpha = hidden ? 0.0 : 1.0
            })
            UIView.animate(withDuration: 0.6, animations: {
                if !isViewHidden && hidden {
                    self.frame.origin.y = UIScreen.main.bounds.height + 200
                } else if isViewHidden && !hidden {
                    self.frame.origin.y = UIScreen.main.bounds.height - self.frame.height
                }
            }, completion: { _ in
                if hidden && !self.isHidden {
                    self.isHidden = true
                    Self.updateFrame(self)
                }
            })
        } else {
            if !isViewHidden && hidden {
                frame.origin.y = UIScreen.main.bounds.height + 200
            } else if isViewHidden && !hidden {
                frame.origin.y = UIScreen.main.bounds.height - frame.height
            }
            isHidden = hidden
            Self.updateFrame(self)
            alpha = 1
        }
    }
}

extension UIView {
    func allSubviews() -> [UIView] {
        var allSubviews = subviews
        for subview in subviews {
            allSubviews.append(contentsOf: subview.allSubviews())
        }
        return allSubviews
    }
}

extension View {
    func hideTabBarOnPush<Screen>(routes: Binding<Routes<Screen>>) -> some View  where Screen: Equatable {
        return modifier(HideTabBarOnPush(routes: routes))
    }
}
