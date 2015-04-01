// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ListItem.h instead.

#import <CoreData/CoreData.h>

extern const struct ListItemAttributes {
	__unsafe_unretained NSString *item;
} ListItemAttributes;

@interface ListItemID : NSManagedObjectID {}
@end

@interface _ListItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ListItemID* objectID;

@property (nonatomic, strong) NSString* item;

//- (BOOL)validateItem:(id*)value_ error:(NSError**)error_;

@end

@interface _ListItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveItem;
- (void)setPrimitiveItem:(NSString*)value;

@end
