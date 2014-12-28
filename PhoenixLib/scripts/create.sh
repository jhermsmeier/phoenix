#!/bin/sh

mfiles=`ls -C1 *.m`
hfiles=`ls -C1 *.h`
prefix=$1

for i in ${mfiles}; 
do 
	filename=${prefix}${i};
	mv $i $filename 
	#classname=`echo ${filename} | sed 's/\\.m//g'`; 
	#echo "#import <Foundation/Foundation.h>\n@implementation ${classname}\n@end\n" > ${filename}; 
done

for i in ${hfiles}; 
do 
	filename=${prefix}${i};
	mv $i $filename 
	#classname=`echo ${filename} | sed 's/\\.h//g'`; 
	#echo "#import <Foundation/Foundation.h>\n#import \"ASTNode.h\"\n\n@interface ${classname} : ASTNode\n@end\n" > ${filename}; 
done
