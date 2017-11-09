
#import <UIKit/UIKit.h>

@interface UIView (AutolayoutSetter)

// 放在某一侧，相邻两条边的边距
- (NSArray *)al_layLeftOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_layUponOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_layBelowOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_layRightOf:(UIView *)view distance:(CGFloat)distance;

// 同一侧对齐
- (NSArray *)al_alignToCenterOf:(UIView *)view distance:(CGPoint)pointDist;
- (NSArray *)al_alignToLeftOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_alignToTopOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_alignToBottomOf:(UIView *)view distance:(CGFloat)distance;
- (NSArray *)al_alignToRightOf:(UIView *)view distance:(CGFloat)distance;

// 和superView 同一侧的边对齐
- (NSArray *)al_alignSuperLeft:(CGFloat)distance;
- (NSArray *)al_alignSuperRight:(CGFloat)distance;
- (NSArray *)al_alignSuperBottom:(CGFloat)distance;
- (NSArray *)al_alignSuperUpon:(CGFloat)distance;
- (NSArray *)al_alignSuperCenter:(CGPoint)pointDist;

- (NSArray *)al_alignSuperHorizontalCenter;
- (NSArray *)al_alignSuperVerticalCenter;
- (NSArray *)al_alignSuperCenter;

- (NSArray *)al_fixSupeWidth;
- (NSArray *)al_fixSupeHeight;

- (void)al_setSize:(CGSize)s;

- (void)al_alignToBoundOfView:(UIView *)view;

- (void)al_setMinWidth:(CGFloat)minWidth;
- (void)al_setMaxWidth:(CGFloat)maxWidth;
- (void)al_setMinHeight:(CGFloat)minHeight;
- (void)al_setMaxHeight:(CGFloat)maxHeight;
- (void)al_removeFromSuperview;
- (void)al_removeConstraint:(NSLayoutAttribute)Attribute;

@end
