
#import "UIView+AutolayoutSetter.h"
#import "Masonry.h"

@implementation UIView (AutolayoutSetter)

- (NSArray *)al_layUponOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_top).offset(-distance);
    }];
}

- (NSArray *)al_layBelowOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(distance);
    }];
}


- (NSArray *)al_layRightOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(distance);
    }];
}

- (NSArray *)al_alignToCenterOf:(UIView *)view distance:(CGPoint)pointDist
{
    if (view == nil) {
        return nil;
    }
    
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (pointDist.x != CGFLOAT_MAX) {
            make.centerX.equalTo(view).offset(pointDist.x);
        }
        if (pointDist.y != CGFLOAT_MAX) {
            make.centerY.equalTo(view).offset(pointDist.y);
        }
    }];
}

- (NSArray *)al_layLeftOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_left).offset(-distance);
    }];
}

- (NSArray *)al_alignToLeftOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(distance);
    }];
}

- (NSArray *)al_alignToTopOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(distance);
    }];
}

- (NSArray *)al_alignToBottomOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view.mas_bottom).offset(-distance);
    }];
}

- (NSArray *)al_alignToRightOf:(UIView *)view distance:(CGFloat)distance
{
    if (view == nil) {
        return nil;
    }
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(-distance);
    }];
}

- (NSArray *)al_alignSuperLeft:(CGFloat)distance
{
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(distance);
    }];
}

- (NSArray *)al_alignSuperRight:(CGFloat)distance
{
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-distance);
    }];
}

- (NSArray *)al_alignSuperBottom:(CGFloat)distance
{
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-distance);
    }];
}

- (NSArray *)al_alignSuperUpon:(CGFloat)distance
{
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(distance);
    }];
}

- (NSArray *)al_alignSuperCenter:(CGPoint)pointDist
{
    return [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (pointDist.x != CGFLOAT_MAX)
            make.centerX.mas_equalTo(pointDist.x);
        if (pointDist.y != CGFLOAT_MAX)
            make.centerY.mas_equalTo(pointDist.y);
    }];
}

- (NSArray *)al_alignSuperHorizontalCenter
{
    return [self al_alignSuperCenter:CGPointMake(0, CGFLOAT_MAX)];
}

- (NSArray *)al_alignSuperVerticalCenter
{
    return [self al_alignSuperCenter:CGPointMake(CGFLOAT_MAX, 0)];
}

- (NSArray *)al_alignSuperCenter
{
    return [self al_alignSuperCenter:CGPointZero];
}

//未修改
- (NSArray *)al_fixSupeWidth
{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    NSArray *c = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[self]-0-|"
                                                         options:NSLayoutFormatDirectionLeadingToTrailing metrics:0 views:viewsDictionary];
    [self addConstraints:c];
    return c;
}
//未修改
- (NSArray *)al_fixSupeHeight
{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self);
    NSArray *c = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[self]-0-|"
                                                         options:NSLayoutFormatDirectionLeadingToTrailing metrics:0 views:viewsDictionary];
    [self addConstraints:c];
    return c;
}

- (void)al_setSize:(CGSize)s
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (s.width != CGFLOAT_MAX) {
            make.width.mas_equalTo(s.width);
        }
        if (s.height != CGFLOAT_MAX) {
            make.height.mas_equalTo(s.height);
        }
    }];
}

- (void)al_setMinWidth:(CGFloat)minWidth
{
    if (minWidth >= 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(minWidth);
        }];
    }
}


- (void)al_setMaxWidth:(CGFloat)maxWidth
{
    if (maxWidth != CGFLOAT_MAX) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(maxWidth);
        }];
    }
}

- (void)al_setMinHeight:(CGFloat)minHeight
{
    if (minHeight >= 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(minHeight);
        }];
    }
    
}

- (void)al_setMaxHeight:(CGFloat)maxHeight
{
    if (maxHeight != CGFLOAT_MAX) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_lessThanOrEqualTo(maxHeight);
        }];
    }
}

- (void)al_alignToBoundOfView:(UIView *)view
{
    [self al_alignToLeftOf:view distance:0];
    [self al_alignToRightOf:view distance:0];
    [self al_alignToTopOf:view distance:0];
    [self al_alignToBottomOf:view distance:0];
}

- (void)al_removeFromSuperview
{
    [self.superview.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint *constraint = (NSLayoutConstraint *)obj;
        if (constraint.firstItem == self || constraint.secondItem == self) {
            [self.superview removeConstraint:constraint];
        }
    }];
    [self removeFromSuperview];
}

//根据需要移除某一单独约束
- (void)al_removeConstraint:(NSLayoutAttribute)Attribute
{
    [self.superview.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint *constraint = (NSLayoutConstraint *)obj;
        if (constraint.firstAttribute == Attribute && constraint.firstItem == self) {
            [self.superview removeConstraint:constraint];
        }
    }];
    
}

- (void)setTag:(NSString *)cid forConstraintsArray:(NSArray *)array
{
    for (NSLayoutConstraint *c in array) {
        c.identifier = cid;
    }
}

- (NSArray *)constraintsWithTag:(NSString *)cid
{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSLayoutConstraint *c in self.constraints) {
        if ([c.identifier isEqualToString:cid]) {
            [mArray addObject:c];
        }
    }
    return mArray;
}

@end
