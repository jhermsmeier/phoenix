#!/usr/bin/ruby

def splitfile(filename)
	file = File.open(filename)
	classnamesandranges = Hash.new 
	filearray = Array.new
	startnum = 0
	endnum = 0
	classname = ""
	index = 0
	file.each do |line|
		filearray.push(line)
		if line.include? "@implementation"
			startnum = index
			declcomp = line.split " "
			classname = declcomp[1]
		elsif line.include? "@end"
			endnum = index
			puts "Class #{classname} begins on #{startnum} and ends on #{endnum}"
			classfilename = "#{classname}.m"
			classfile = File.open(classfilename,'w')
			range = Range.new startnum,endnum
			range.each do |j|
				classfile.write(filearray[j])
			end
			classfile.close
		end
		index = index + 1
	end
end

# main
filename = ARGV[0]
puts "filename = #{filename}"
splitfile filename