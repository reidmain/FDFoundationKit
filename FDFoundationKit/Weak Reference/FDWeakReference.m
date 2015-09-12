#import "FDWeakReference.h"


#pragma mark - Class Definition

@implementation FDWeakReference


#pragma mark - Initializers

+ (id)weakReferenceWithObject: (id)object
{
	FDWeakReference *weakReference = [[FDWeakReference alloc] init];
	
	weakReference.referencedObject = object;
	
	return weakReference;
}


@end