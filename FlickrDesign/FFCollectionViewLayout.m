//
//  FFCollectionViewLayout.m
//  FlickrDesign
//
//  Created by Admin on 30.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "FFCollectionViewLayout.h"

@interface FFCollectionViewLayout()

@property (nonatomic, assign) NSUInteger numberOfItems;
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) NSUInteger numberOfRows;
@property (nonatomic, assign) CGFloat defaultCellWidth;
@property (nonatomic, assign) BOOL **places;
@property (nonatomic, copy) NSDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *cellAtributes;

@end

@implementation FFCollectionViewLayout

-(instancetype) initWithDelegate: (id<FFCollectionLayoutDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _cellAtributes = [NSDictionary new];
    }
    return self;
}

-(void) prepareLayout {
    [super prepareLayout];
    [self countDimensions];
    self.places = [self createPlacesRows:self.numberOfRows columns:self.numberOfColumns];
    NSMutableDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *attributes = [NSMutableDictionary new];
    for (NSUInteger i = 0; i < self.numberOfItems; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes setObject:attribute forKey:indexPath];
    }
    self.cellAtributes = [attributes copy];
}

-(void) countDimensions {
    self.numberOfColumns = 3;
    self.numberOfItems = [self.delegate numberOfItems];
    NSUInteger numberOfItemsWithExtraCells = (self.numberOfItems + 3) - (self.numberOfItems + 3) % 3;
    self.numberOfRows = (numberOfItemsWithExtraCells + 1) / 2;
    self.defaultCellWidth = CGRectGetWidth(self.collectionView.frame) / 3;
}

-(CGSize) collectionViewContentSize {
    CGRect frame = self.collectionView.frame;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = width / 3 * self.numberOfRows;
    CGSize size = CGSizeMake(width, height);
    return size;
}

-(NSArray<UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect: (CGRect)rect {
    NSMutableArray *myAttributes = [NSMutableArray arrayWithCapacity:self.cellAtributes.count];
    for(NSIndexPath *key in self.cellAtributes) {
        UICollectionViewLayoutAttributes *attributes = [self.cellAtributes objectForKey:key];
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [myAttributes addObject:attributes];
        }
    }
    return myAttributes;
}

-(UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath: (NSIndexPath *)indexPath {
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 1, 1, 1);
    CGRect frame = [self frameForIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = UIEdgeInsetsInsetRect(frame, insets);
    return attributes;
}

-(CGRect) frameForIndexPath: (NSIndexPath *)indexPath {
    CGRect frame = CGRectZero;
    NSUInteger item = indexPath.item;
    if ((item % 12 == 0) || (item % 12 == 7)) {
        NSUInteger size = 2;
        frame = [self calculateFrame:size];
    }
    else {
        NSUInteger size = 1;
        frame = [self calculateFrame:size];
    }
    return frame;
}

-(CGRect) calculateFrame: (NSUInteger)side {
    CGFloat cellSide = self.defaultCellWidth;
    CGRect result = CGRectNull;
    for (NSUInteger i = 0; i < _numberOfRows; ++i) {
        for (NSUInteger j = 0; j < _numberOfColumns; ++j) {
            if (self.places[i][j] == true) {
                if (side == 1) {
                    self.places[i][j] = false;
                    result = CGRectMake(j * cellSide, i * cellSide, cellSide * side, cellSide * side);
                    return result;
                } else if (side == 2) {
                    if (j < _numberOfColumns - 1 && i < _numberOfRows - 1) {
                        self.places[i][j] = false;
                        self.places[i][j+1] = false;
                        self.places[i+1][j] = false;
                        self.places[i+1][j+1] = false;
                        result = CGRectMake(j * cellSide, i * cellSide, cellSide * side, cellSide * side);
                        return result;
                    }
                }
            }
        }
    }
    return result;
}

-(BOOL **) createPlacesRows: (NSUInteger)numberOfRows columns: (NSUInteger)numberOfColumns {
    BOOL **places;
    places = (BOOL **)malloc(numberOfRows * sizeof(BOOL *));
    for (int i = 0; i < numberOfRows; ++i) {
        places[i] = (BOOL *)malloc(numberOfColumns * sizeof(BOOL));
    }
    for (int i = 0; i < numberOfRows; ++i) {
        for (int j = 0; j < numberOfColumns; ++j) {
            places[i][j] = true;
        }
    }
    return places;
}

-(BOOL) shouldInvalidateLayoutForBoundsChange: (CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return NO;
    }
    return NO;
}

@end
