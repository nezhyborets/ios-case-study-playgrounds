# ios-case-study-playgrounds
These are just my investigation into different iOS/Mac Swift/Objective-C issues and approaches. Anyone is welcome into discussion and making new decisions

### hidesBottomBarWhenPushed with UITabBarController
Dive into what happens when we use hidesBottomBarWhenPushed for view controller being pushed onto UINavigationController that is on of UITabBarController's viewController's.

We can see that UITabBar is being copied to the previous top view controller and removed from UITabBarController's view at the start of push, and being completely removed from window's hierarchy when push ends.

See details here: https://github.com/nezhyborets/ios-case-study-playgrounds/blob/master/HidesBottomBarWhenPushed/README.md
