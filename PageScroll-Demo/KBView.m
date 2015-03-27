//
//  KBView.m
//  PageScroll-Demo
//
//  Created by JieLee on 15/3/27.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "KBView.h"
#import "UIView+Autolayout.h"

@implementation KBView

- (instancetype)initWithArr:(NSArray *)KBArr {
    
    if (self = [super init]) {
        
        UILabel *one = [UILabel autolayoutView];
        one.text = KBArr[0];
        one.font = [UIFont systemFontOfSize:15];
        one.backgroundColor = [UIColor redColor];
        one.textAlignment = NSTextAlignmentCenter;
        
        one.numberOfLines = 0;
        [self addSubview:one];
        
        UILabel *two = [UILabel autolayoutView];
        two.text = KBArr[1];
        two.textAlignment = NSTextAlignmentCenter;
        two.backgroundColor = [UIColor blackColor];
        [self addSubview:two];
        
        UILabel *three = [UILabel autolayoutView];
        three.text = KBArr[2];
        three.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:three];
        
        UILabel *four = [UILabel autolayoutView];
        four.text = KBArr[3];
        four.textAlignment = NSTextAlignmentCenter;
        four.backgroundColor = [UIColor blueColor];
        [self addSubview:four];
        
        UILabel *five = [UILabel autolayoutView];
        five.text = KBArr[4];
        five.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:five];
        
        
        
        
        
        NSDictionary *metrics = @{@"height":@50.0};
        NSDictionary *views = NSDictionaryOfVariableBindings(one, two, three, four, five);
        
        NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[one(two)]-[two(three)]-[three(four)]-[four(five)]-[five]-|" options:0 metrics:metrics views:views];
        
        NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[one(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[two(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[three(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[four(160)]-|" options:0 metrics:metrics views:views];
        NSArray *constraints6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[five(160)]-|" options:0 metrics:metrics views:views];
        
        [self addConstraints:constraints1];
        [self addConstraints:constraints2];
        [self addConstraints:constraints3];
        [self addConstraints:constraints4];
        [self addConstraints:constraints5];
        [self addConstraints:constraints6];
        
    }
    return self;
}

+ (instancetype)viewWithArr:(NSArray *)KBArr {
    return [[self alloc] initWithArr:KBArr];
}

@end
