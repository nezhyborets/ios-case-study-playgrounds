# hidesBottomBarWhenPushed with UITabBarController

#### TL;DR
On UITabBarController's child navigation controller's push - UITabBar is being copied to the view controller that was top view controller before push. 

It is removed from UITabBarController's view at the start of push. 

It is also completely removed from window hierarchy after a push.

### More detail
In the case, UITabBar has 3 states:
1. UITabBarController is visible - e.g. UITabBarController's subclass's viewDidAppear
2. Inside of a transition when one of UITabBarController's child navigation controller has just pushed something - e.g. PushedViewController's viewWillAppear + 0.05 seconds
3. Child navigation controller has finished pushing - e.g. PushedViewController's viewDidAppar

The sample code has a lot of output, but the interesting part is that **UITabBar's parent hierarchy** is different in states described above. 

Note that closest parent in State 1 and 2 are completely different views.

Closest parent from top to bottom:

#### State 1 - UITabBarController is visible

> <UILayoutContainerView: 0x7fbf64c11630; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x608000221fe0>>
> 
> <UIWindow: 0x7fbf64c074f0; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x60800005b210>; layer = <UIWindowLayer: 0x608000221e00>>
> 
#### State 2 - Inside of a transition
> <UIView: 0x7fbf64d0fa00; frame = (-124 0; 414 736); userInteractionEnabled = NO; animations = { position=<CASpringAnimation: 0x608000425be0>; }; layer = <CALayer: 0x610000225dc0>>
> 
> <UIViewControllerWrapperView: 0x7fbf64c018e0; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x608000221b80>>
> 
> <UINavigationTransitionView: 0x7fbf64d15730; frame = (0 0; 414 736); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x6100002260a0>>
> 
> <UILayoutContainerView: 0x7fbf64d105f0; frame = (0 0; 414 736); autoresize = W+H; gestureRecognizers = <NSArray: 0x610000243f60>; layer = <CALayer: 0x610000225820>>
> 
> <UIViewControllerWrapperView: 0x7fbf64d17310; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x610000226360>>
> 
> <UITransitionView: 0x7fbf64c11a00; frame = (0 0; 414 736); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x608000221ee0>>
> 
> <UILayoutContainerView: 0x7fbf64c11630; frame = (0 0; 414 736); autoresize = W+H; layer = <CALayer: 0x608000221fe0>>
> 
> <UIWindow: 0x7fbf64c074f0; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x60800005b210>; layer = <UIWindowLayer: 0x608000221e00>>
#### State 3 - Child navigation controller has finished pushing
At this point:  
**!!!There is no UITabBar in Root Window's view hierarchy at all!!!**