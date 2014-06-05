#pragma mark Class Interface

@interface FDCache : NSObject


#pragma mark - Instance Methods

- (id)objectForKey: (id)key;
- (void)setObject: (id)obj 
	forKey: (id)key;


@end