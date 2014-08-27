@import Foundation;


#pragma mark Class Interface

/**
This category adds methods on NSObject to allow for easier execution of blocks.
*/
@interface NSObject (PerformBlock)


#pragma mark - Instance Methods

/**
Executes the block on the current thread after a minimum amount of delay.

@param block The block to perform.
@param delay The minimum time before the block is called. Specifying a delay of 0 does not necessarily cause the block to be called immediately. The block is still queued on the current thread’s run loop and performed as soon as possible.
*/
- (void)performBlock: (dispatch_block_t)block 
	afterDelay: (NSTimeInterval)delay;

/**
Performs the specified block on the main thread but can block execution until it is finished.

@param block The block to perform on the main thread.
@param waitUntilDone If YES blocks the executing thread until the block finishes otherwise runs the block asynchronously.
*/
- (void)performBlockOnMainThread: (dispatch_block_t)block 
	waitUntilDone: (BOOL)waitUntilDone;

/**
Performs the specified block on the main thread asynchronously.

@param block The block to perform on the main thread.
*/
- (void)performBlockOnMainThread: (dispatch_block_t)block;

/**
Performs the specified block on a dispatch queue with DISPATCH_QUEUE_PRIORITY_BACKGROUND priority.

@param block The block to perform in the background.
*/
- (void)performBlockInBackground: (dispatch_block_t)block;


@end