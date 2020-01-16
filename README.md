# ios-case-study-playgrounds
These are just my investigation into different iOS/Mac Swift/Objective-C issues and approaches. Anyone is welcome into discussion and making new decisions

### hidesBottomBarWhenPushed with UITabBarController: Apple's implemenetation
Dive into what happens when we use hidesBottomBarWhenPushed for view controller being pushed onto UINavigationController that is on of UITabBarController's viewController's.

We can see that UITabBar is being copied to the previous top view controller and removed from UITabBarController's view at the start of push, and being completely removed from window's hierarchy when push ends.

See details here: https://github.com/nezhyborets/ios-case-study-playgrounds/blob/master/HidesBottomBarWhenPushed/README.md

### UITableView + UISearchView + hidesBottomBarWhenPushed
Initial condition:
- UINavigationController embedded in UITabBarController
- first view controller has `UITableView` with `UISearchView` set as `tableHeaderView`
- the `tableView` is empty or has cells less than screen size
- table view scrolled a little bit so that only `UISearchView` is hidden (yes, it's possible, thanks to Apple hacks for UISearchView)
- your second (trailing in navigation stack) view controller has `hidesBottomBarWhenPushed` set to `true`

Action:  
There is a chance you'll get in trouble after popping back from second controller. By trouble I mean that UISearchView will become visible again, though you scrolled to hide it few moments ago. You'll get into this both if your first controller has `automaticallyAdjustsScrollViewInsets` set to `true` AND if it's set to `false`, but `edgesForExtendedLayout` is set only to `[.top]` (Under Top Bars if you use storyboards).

Solution:  
Adding `.bottom` (Under Bottom Bars) to `edgesForExtendedLayout` seems to fix the issue for me.  
**Note:** This seem to be working only if `tabBarController.tabBar` is `translucent`

Playground project:  
TableViewWithSearchViewContentOffset

### Core Data doesn't check if value is the same

https://github.com/nezhyborets/ios-case-study-playgrounds/tree/master/CoreDataSaveWithoutChangesConflict

This case shows that if you set value on NSManagedObject object's property, Core Data will "save" this object even if the value is the same. This may eventually lead to conflict tho nothing's changed in one of saves.

Solution: always check for equality before setting new value.

While studying this, i've found this important note
> Always verify that the context has uncommitted changes (using the hasChanges property) before invoking the save: method. Otherwise, Core Data may perform unnecessary work.

### UINavigationBar large title and scrollView contentOffset jump when going back, if contentSize is specific
https://github.com/nezhyborets/ios-case-study-playgrounds/tree/master/UITableViewLargeTitle
There was a bug, on first viewController I scroll so that large title hides, then go forward and back in navigationController (both interactively and by tapping) - my UITableView would jump twice and large title would reappear even though it shouldn't. The research lead first to blaming usage of additionalSafeAreaInsets, because debug showed that margins of viewController would change. Then I moved to playing with tableView properties like insetsLayoutMarginsFromSafeArea. Then I found that  changing sectionHeaderHeight and sectionFooterHeight in Storyboard helped.

But in the end non of it was the reason. It's just the height of contentSize of any scrollView. In my example, when I run on Xs Max, only 818 height leads to bug. You can see that there is really almost no custom code, and if you change the height by one point it would work just fine
