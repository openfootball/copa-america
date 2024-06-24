
## use (uploaded/published) gems (only)

require 'sportdb/readers'
require 'sportdb/exporters'


puts
puts "work_dir:"

root_dir = Dir.pwd
pp root_dir
#=> "/home/runner/work/copa-america/copa-america"

## note - copa-america/copa-america  



SportDb.open_mem   ## use (setup) in memory db

SportDb.read( "#{root_dir}/2024--usa/copa.txt" ) 


puts "table stats:"
SportDb.tables


##
## generate json

SportDb::Model::Event.order( :id ).each do |event|
    puts "    #{event.key} | #{event.league.key} - #{event.league.name} | #{event.season.key}"
end


SportDb::JsonExporter.export_copa( 'southamerica', out_root: './tmp/json/copa' )


### copy to copa-america.json repo
src  = './tmp/json/copa/2024/copa.json'
dest = "#{root_dir}/openfootball/copa-america.json/2024/copa.json" 

## make sure dir exists
dest_p = File.dirname( dest )
FileUtils.mkdir_p( dest_p )  unless File.exist?( dest_p )   
FileUtils.cp( src, dest )


## print for debugging
puts  File.open( dest, 'r:utf-8') { |f| f.read }


puts "bye"

